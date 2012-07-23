function make_reverse_phi_double_check_v01_functions
%% info
% Make reverse phi position functions, reverse phi with phase delay
% position functions, and reverse phi with adaptation period position
% functions.
%
% sanity outline:
% For regular rev_phi and flicker/step delays
% 1) convert tf in Hz to # samples per step in discretized position
% function
% 2) figure out the actual tf possible from the # samples per step
% 3) for each tf, get the range of delays possible without stepping back
% into the previous step (running into the previous step/flicker's junk)
% 4) linspace the range (with 4, for example), get to values possible with
% the sampling rate and then populate an array with the negative and
% positive delays (and no delay)
% 5) make the function in x have the correct # steps, and make the function
% in y have the correct offset of changes between on flick and off flick
%
% could easily add doubleflick and adaptation periods to this

%% Set up some default values

project = 'reverse_phi_double_check_v01_functions'; % Determines the destination show up
temporal_freqs = [.5 1 3];      % Set of tf's to use, the .5 is set below to show up as 0pt5 when saved
verbose_flag = 0;               % will make an additional position function that has out of phase flicker and movement
sampling_rate = 400;            % 400 hz allows for 2.5ms precision in offsets
pattern_y_length = 2;           % on and off flicker for the rev phi
max_num_delays = -1;% 8;        % if -1 it will make all, and check that the completely out of phase position function works...
counter = 0;                    % Counter for numbering before saving (see below) s
function_total_length = 10;     % The function will be repeated this many times to make sure it doesn't alias when it plays

%% Make the functions
for pattern_x_length = 8; % the wavelength of the function (1/sf)
for temp_freq = temporal_freqs
    name = ['position_function_' 'lam_' num2str(pattern_x_length) '_'];
    
    if mod(temp_freq,1) ~= 0
        tf_str = regexp(num2str(temp_freq),'\.','split');
        tf_str = [tf_str{1} 'pt' tf_str{2}];
    else
        tf_str = num2str(temp_freq);
    end
    
    name = [name, 'rev_phi_', tf_str, 'Hz'];
    
    % get samples per step and the tf associated with this
    samples_per_step = floor((sampling_rate/1)*(1/temp_freq)*(1/pattern_x_length));
    actual_tf = (1/samples_per_step)*(sampling_rate/1)*(1/pattern_x_length) %#ok<NASGU,NOPRT>
    % repeats_of_step = ceil((function_total_length*sampling_rate)/(samples_per_step));
    
    % get delay range and round to delays actually possible with sampling rate
    short_delay = (1); %/sampling_rate;
    
    if max_num_delays == -1
        long_delay = ceil(samples_per_step/2); %/sampling_rate;    
        delays = linspace(long_delay,short_delay);
    else
        long_delay = floor(samples_per_step/2); %/sampling_rate;        
        delays = linspace(long_delay,short_delay,max_num_delays);
    end
    
    if verbose_flag; disp(delays); end
    
    if max_num_delays == -1
    if mod(delays(1),1)
        warning('Completely out of phase delay not possible for this temporal frequency');
        disp(delays(1))
    else
        disp('Out of phase position function works for this temporal frequency!')
    end
    end
    
    for g = 1:numel(delays)
        delays(g) = round(delays(g));
    end
    
    if verbose_flag; disp(delays); end
    delays = unique(delays);
    if verbose_flag; disp(delays); end

    func = [];

    for chan = 1:2
        if chan == 1
            for direction = 1:2;
                if direction == 1
                    direction_name = [name, '_CW'];
                elseif direction == 2
                    direction_name = [name, '_CCW'];
                end  

                chan_name = [direction_name, '_Xchan'];
                % X channel
                for g = 1:pattern_x_length
                    func = [func repmat(g-1,1,samples_per_step)]; %#ok<*AGROW>
                end
                % make it long enough for the full duration (round up, then
                % cut off extra part)
                func = repmat(func, 1, ceil((sampling_rate*function_total_length)/numel(func)));
                % func = func(1:function_total_length); 
                
                if direction == 2
                    func = fliplr(func);                
                end
                function_name = [chan_name '_' num2str(sampling_rate) 'Hz'] ;
                counter = counter + 1;
                save_function(project,function_name,func,counter);
                func = [];
            end
        else
            chan_name = [name, '_Ychan'];            
            % Y channel

            % no delay first
            delay_name = [chan_name, '_0ms_after_' num2str(sampling_rate) 'Hz'];
            for g = 1:(pattern_y_length)
                func = [func repmat(mod(g-1,2),1,samples_per_step)];
            end
            func = repmat(func, 1, ceil((sampling_rate*function_total_length)/numel(func)));
            % func = func(1:function_total_length);
            
            function_name = delay_name;
            counter = counter + 1;                                
            save_function(project,function_name,func,counter);  
            func = [];
            
            for delay = delays
                funct = [];
                for g = 1:(pattern_y_length)
                    funct = [funct repmat(mod(g-1,2),1,samples_per_step)];
                end
                funct = repmat(funct, 1, ceil((sampling_rate*function_total_length)/numel(funct)));
                
                for delay_type = [-1 1]
                    delay_val = 1000*delay/sampling_rate;
                    if mod(abs(delay_val),1) ~= 0
                        delay_val = regexp(num2str(delay_val),'\.','split');
                        delay_val = [delay_val{1} 'pt' delay_val{2}];
                    else
                        delay_val = num2str(delay_val);
                    end
                    
                    switch delay_type
                        case 1
                            function_name = [chan_name, '_', delay_val, 'ms_after_' num2str(sampling_rate) 'Hz'];
                            % SHIFT IT TO HAPPEN LATER
                            func = [repmat(funct(1),1,(delay)) funct]; % I will never know why repmat fails here...
                            
                            counter = counter + 1;
                            save_function(project,function_name,func,counter);  
                            func = [];

                        case -1
                            function_name = [chan_name, '_', delay_val, 'ms_before_' num2str(sampling_rate) 'Hz'];
                            % SHIFT IT TO HAPPEN EARLIER
                            func = funct((delay+1):end); % add 1 because offset requires inclusion
                            
                            counter = counter + 1;
                            save_function(project,function_name,func,counter);
                            func = [];
                    end
                end
            end
        end
    end
end
end

function save_function(project,function_name,func,counter) %#ok<INUSL>
    %% Save the function in the for loop
    switch computer
        case {'PCWIN','PCWIN64'}
            root_func_dir = 'C:\tethered_flight_arena_code\position_functions';
        case {'MACI64'}
            root_func_dir = '/Users/holtzs/tethered_flight_arena_code/position_functions';
        otherwise
            error('is this linux?')
    end
    temp = regexpi(function_name,'\position_function','split');
    if numel(num2str(counter)) < 2
        count = ['00' num2str(counter)];
    elseif numel(num2str(counter)) < 3
        count = ['0' num2str(counter)];        
    else
        count = num2str(counter);        
    end
    
    function_name = ['position_function' '_' count temp{2}];
    file_name = fullfile(root_func_dir,project,function_name);
    save(file_name, 'func');
    disp(function_name); 
end
end
