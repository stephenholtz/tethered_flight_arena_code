function std_hand = make_space_time_diagram_for_open_loop_condition(condition_struct,save_file_path)
% std_hand = make_space_time_diagram_for_open_loop_condition()
% Function will make a space time diagram for a few open loop conditions.
% 
% Works for simple gain and bias in either channel, and/or position
% functions in either channel. But only patterns where row compression
% makes sense...
%
% Needs: condition_struct w/fields , pattern location, and position
% function location if the mode of the condition struct requires it
%
% Required fields in condition_struct (if using position functions):
% condition_struct.PatternLoc
% condition_struct.PatternName
% condition_struct.Mode
% condition_struct.InitialPosition
% condition_struct.Gains
% condition_struct.Duration
% (condition_struct.FuncFreqY)
% (condition_struct.FuncFreqX)
% (condition_struct.PosFuncLoc)
% (condition_struct.PosFuncNameX)
% (condition_struct.PosFuncNameY)
% 
%% A few flags not (yet) in the function call:
video_flag = 0;
video_desired_height = 10;%#ok<*NASGU> %720/4
condition_info_pdf_flag = 1;
display_figure_flag = 0; % If loading figures and set to zero, will need to set(gcf,'Visible','on') to see it...
color_mode = 'green'; %'green'; % 'alien'
figure_color = [1 1 1];
verbose = 1;

%% Get the correct save path and names
if ~isvarname('save_file_path')
    save_folder = cd;
    std_name = 'std';
    save_file_path = fullfile(save_folder,std_name);
else
    [~,std_name] = fileparts(save_file_path);
    if isempty(std_name); std_name = 'std'; end
end

%% Load the pattern
pattern_location = fullfile(condition_struct.PatternLoc,condition_struct.PatternName);
load(pattern_location);

%% Build a list of frame indicies for the buffer (from the Duration in the struct)

% Convert from gains/biases to just gains for easy fps calculation
% if abs(condition_struct.Gains(1))<127
% elseif abs(condition_struct.Gains(1))>127 && condition_struct.Gains(2) == 0
%     condition_struct.Gains(2) = condition_struct.Gains(1)/2.5;
%     condition_struct.Gains(1) = 0;
% else
%     error('Need more complicated gain -> bias conversion!')
% end
% 
% if abs(condition_struct.Gains(3))<127
% elseif abs(condition_struct.Gains(3))>127 && condition_struct.Gains(4) == 0
%     condition_struct.Gains(4) = condition_struct.Gains(2)/2.5;
%     condition_struct.Gains(3) = 0;
% else
%     error('Need more complicated gain -> bias conversion!')
% end

% X Chan frames
switch condition_struct.Mode(1)
    case 0
        fps(1) = condition_struct.Gains(1) + condition_struct.Gains(2)*2.5;
        num_frames(1) = ceil(fps(1) * condition_struct.Duration);
    case 4
        num_frames(1) = ceil(condition_struct.FuncFreqX * condition_struct.Duration);
end

% For finding LCM later
if num_frames(1) == 0; num_frames(1) = 1; end
% Y Chan frames
switch condition_struct.Mode(2)
    case 0
        fps(2) = condition_struct.Gains(3) + condition_struct.Gains(4)*2.5;        
        num_frames(2) = ceil(fps(2) * condition_struct.Duration);
    case 4
        num_frames(2) = ceil(condition_struct.FuncFreqY * condition_struct.Duration);
end

% For finding LCM later
if num_frames(2) == 0; num_frames(2) = 1; end

% Find the LCM
num_frames = lcm(abs(num_frames(1)),abs(num_frames(2)));

% Through all of the frames for x and y channels using position function if
% needed, folding the number of pattern repeats into the correct numbers 
% for x and y. Add 1 to position functions because they number from zero

% X channel
if condition_struct.Mode(1) == 4
    load(fullfile(condition_struct.PosFuncLoc,condition_struct.PosFuncNameX))
    for frame = 1:num_frames
        ind = mod(frame,numel(func));
        if ind == 0; ind = numel(func); end
        x_index(frame) = func(ind)+1;
    end
    clear func
elseif condition_struct.Mode(1) == 0
    frames_between_moves = ceil(abs(num_frames/fps(1)));
    
    x_index(1) = condition_struct.InitialPosition(1);
    
    % If the gain is zero (frames_between_moves is infinite) repmat
    if isinf(frames_between_moves)
        x_index = repmat(x_index(1),1,num_frames);
    else

        for frame = 2:num_frames

            if ~mod(frame,frames_between_moves);
                x_index(frame) = x_index(frame-1) + sign(condition_struct.Gains(1));
            else
                x_index(frame) = x_index(frame-1);
            end
        end
        x_index = mod(x_index,pattern.x_num)+1; %#ok<*NODEF>
    end
    
end

% Y channel
if condition_struct.Mode(2) == 4
    load(fullfile(condition_struct.PosFuncLoc,condition_struct.PosFuncNameY))
    for frame = 1:num_frames
        ind = mod(frame,numel(func));
        if ind == 0; ind = numel(func);end
        y_index(frame) = func(ind)+1;
    end
    clear func
elseif condition_struct.Mode(2) == 0
    frames_between_moves = ceil(abs(num_frames/fps(2)));
    
    y_index(1) = condition_struct.InitialPosition(2);
    
    % If the gain is zero (frames_between_moves is infinite) repmat
    if isinf(frames_between_moves)
        y_index = repmat(y_index(1),1,num_frames);
    else

        for frame = 2:num_frames

            if ~mod(frame,frames_between_moves);
                y_index(frame) = y_index(frame-1) + sign(condition_struct.Gains(3));
            else
                y_index(frame) = y_index(frame-1);
            end
        end
        y_index = mod(y_index,pattern.y_num)+1;
    end
    
end

%% Get formatting of the pattern

% Determine row compression and uncompress later if needed (backward compatable)
if ~isfield(pattern, 'row_compression') 
    pattern.row_compression = 0;
end

% Make an appropriate (green) color map for the pattern
switch color_mode
    case 'green'
        grayscale_color_map = repmat([0 -1 0],pattern.gs_val^2 - 1,1);
    case 'gray'
        grayscale_color_map = repmat([-1 0],pattern.gs_val^2 - 1,1);
    case 'alien'
        grayscale_color_map = repmat([.1 -1 .5],pattern.gs_val^2 - 1,1);
end

grayscale_color_map(grayscale_color_map == -1) = linspace(0,1,pattern.gs_val^2-1)';

%% Make the space time video and diagram
% add 1 because there are zero values in the pattern
% Preallocate the image
if verbose; fprintf(1,'Preallocating Frames...'); end

%st_image = zeros(num_frames*size(pattern.Pats,1),num_frames*size(pattern.Pats,2));
st_image = []
if verbose; fprintf(1,'\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'); end


if verbose; fprintf(1,'Making Frames: 000000 of 000000'); end

if video_flag
    % Preallocate (MxNxRGBxFrame) it takes FOREVER without doing this.
    frame = 1;
    if pattern.row_compression
        full_frame = repmat(pattern.Pats(:,:,x_index(frame),y_index(frame)), 8, 1);
    else
        full_frame = pattern.Pats(:,:,x_index(frame),y_index(frame));
    end
    
    [frame_height frame_width] = size(full_frame);
    scale_factor = (video_desired_height/frame_height);
    movie_images(:,:,:,:) = zeros(ceil(scale_factor*frame_height),ceil(scale_factor*frame_width),3,num_frames);
end



for frame = 1:num_frames
    if pattern.row_compression
        full_frame = repmat(pattern.Pats(:,:,x_index(frame),y_index(frame)), 8, 1);
    else
        full_frame = pattern.Pats(1,:,x_index(frame),y_index(frame));
    end
    
    % imagesc(full_frame)
    % pause
    
    % Keep appending to bottom of image
    rows = (1+size(st_image,1)):(size(st_image,1)+size(full_frame,1));
    cols = (1+size(st_image,2)):(size(st_image,2)+size(full_frame,2));
    
    st_image(rows,:) = full_frame(:,:); %#ok<*AGROW>
    
    if video_flag
        % Store movie images in this format (MxNxRGBxFrame)
        movie_images(:,:,:,frame) = imresize((reshape(grayscale_color_map(full_frame,:),size(full_frame,1),size(full_frame,2),size(grayscale_color_map,2))),scale_factor,'nearest');
    end
    
    if verbose; fprintf(1,'\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b%6d of %6d',frame,num_frames); end
    
end

if verbose;  fprintf(1,'    DONE! \n'); end

std_hand = figure('Color',figure_color,'Colormap',grayscale_color_map,'Name',std_name,'NumberTitle','off');

if ~display_figure_flag
   set(std_hand,'Visible','off')
else
   set(std_hand,'Visible','on')    
end

image(st_image); axis off;
%saveas(std_hand,save_file_path,'fig')
export_fig(std_hand,save_file_path,'-pdf')

% Write the video to file (the slowest part!)
if video_flag
    st_video = VideoWriter(save_file_path,'Motion JPEG AVI'); %#ok<*UNRCH>
    set(st_video,'Quality',95);
    open(st_video)
    writeVideo(st_video,movie_images)
    close(st_video)
end

%% Append the information from condition_struct onto the pdf

if condition_info_pdf_flag
    info_hand = figure('Color',figure_color,'Name',['Condition Info: ' std_name],'NumberTitle','off');
    if ~display_figure_flag
       set(info_hand,'Visible','off')
    else
       set(info_hand,'Visible','on')        
    end
    
    fields = fieldnames(condition_struct);
    
    for i = 1:numel(fields)
        field_content = getfield(condition_struct,fields{i});
        if isnumeric(field_content);
            field_text = num2str(field_content);
        elseif ischar(field_content)
            field_text = field_content;
        elseif iscell(field_content)
            if isnumeric(field_content{1});
                field_text = num2str(field_content{1});
            elseif ischar(field_content{1})
                field_text = field_content{1};
            end
        end
        
        figure_text{i,:} = [fields{i}, ' = ', field_text];
    end
    
    annotation(info_hand,'Textbox',[0 0 1 1],'String',figure_text,'Edgecolor','None','Interpreter','none')
    export_fig(info_hand,save_file_path,'-pdf','-append')
end

end