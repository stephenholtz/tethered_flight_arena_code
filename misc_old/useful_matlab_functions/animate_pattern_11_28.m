function ST = animate_pattern_11_28(pattern_name, frame_position, image_position, movie_name, fps, title_struct)
%retuns ST, the space-time version of the top line of the pattern

if ~all(movie_name == -1)
    aviobj = avifile(movie_name, 'compression', 'none', 'fps', fps, 'quality', 10);
end

[num_frames, num_ax] = size(frame_position);
load(pattern_name)

[numR, numC] = size(pattern.Panel_map);
numRows = numR*8;
numCols = numC*8;
ST = zeros(num_frames, numCols);

% the color maps
switch pattern.gs_val
    case 1
        C = [0 0 0; 0 1 0];   % 2 colors - on / off
    case 2
        C = [0 0 0; 0 1/3 0; 0 2/3 0; 0 1 0]; % 4 levels of gscale    
    case 3
        C = [0 0 0; 0 2/8 0; 0 3/8 0; 0 4/8 0; 0 5/8 0; 0 6/8 0; 0 7/8 0; 0 1 0];  % 8 levels of gscale        
    case 4
        C = [0 0 0; 0 2/16 0; 0 3/16 0; 0 4/16 0; 0 5/16 0; 0 6/16 0; 0 7/16 0; 0 8/16 0; 0 9/16 0; 0 10/16 0; 0 11/16 0; 0 12/16 0; 0 13/16 0 ; 0 14/16 0; 0 15/16 0; 0 1 0];  % 8 levels of gscale   
    otherwise
        error('the graycale value is not appropriately set for this pattern - must be 1, 2, or 3');
end

% place to adjust displayed image for row_compression - 
row_compression = 0;
if isfield(pattern, 'row_compression') % for backward compatibility
    if (pattern.row_compression)
        row_compression = 1;
    end
end

figure(1);
set(1, 'Position', image_position,'color','k');
for j = 1:num_frames
    if row_compression 
        frame = repmat(pattern.Pats(:,:,frame_position(j,1), frame_position(j,2))+1, 8, 1);
    else
        frame = pattern.Pats(:,:,frame_position(j,1), frame_position(j,2))+1;            
    end
    
    if numR == 1
        frame = repmat(frame, 4, 1);
    end
    
    framed = frame(:,13:96); %%use only the visible part of the arena
    ST(j,:) = frame(1,:);
    image(framed); axis image; axis off; colormap(C);

    if nargin == 6% that is if a title_struct is supplied
        gcf;
        text(2,35,title_struct.title(title_struct.title_seq(j)).name,'Color', 'w', 'Fontsize', 14, 'FontName','Times', 'Interpreter', 'none')
    end

    if ~all(movie_name == -1)
        frame = getframe(gca);
        aviobj = addframe(aviobj,frame);
    end
    
    pause(0.01)
end

if ~all(movie_name == -1)
    aviobj = close(aviobj);
end

