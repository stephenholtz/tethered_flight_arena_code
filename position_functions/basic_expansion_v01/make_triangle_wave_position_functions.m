function func = make_triangle_wave_position_functions
% Make a triangle wave position function at specified temporal frequencies

    project = 'basic_expansion_v01';
    name = 'position_function_triangle_wave_';
        
    wavelength = 8;                 % How many frames for a full pattern (8 for 4 pix wide anything... almost)
    temporal_freqs = 5;             % Set of tf's to use, the .5 is set below to show up as 0pt5 when saved
    sampling_rate = 200;
    counter = 0;                    % Counter for numbering before saving (see below)    
    periods = 6;                    % how long it takes to go 'up down'... in seconds
    reps = 3;                       % number of times it goes through one direction then the other
    
    for temp_freq = temporal_freqs
        for period = periods
            samples_per_step = floor((sampling_rate/1)*(1/temp_freq)*(1/wavelength));
            actual_tf = (1/samples_per_step)*(sampling_rate/1)*(1/wavelength) %#ok<NASGU,NOPRT>
            
            desired_change_point = (period*sampling_rate)/2;
            actual_period = 2*(wavelength*samples_per_step*round(desired_change_point/(samples_per_step*wavelength)))/sampling_rate %#ok<NOPRT>
            actual_change_point = (actual_period*sampling_rate)/2;
            
            frames_per_full_cycle = actual_change_point*2 - 2*samples_per_step;
            
            func = [];
            
            incr = 1;
            curr_val = 1;
            
            for i = 1:frames_per_full_cycle
                
                if ~mod(i,actual_change_point)
                    incr = incr*(-1);
                end
                
                if ~mod(i,samples_per_step)
                    curr_val = curr_val + incr;
                end     
                
                if incr > 0
                    if ~mod(curr_val,wavelength+1)
                        curr_val = 1;
                    end
                elseif incr < 0
                   if ~mod(curr_val,wavelength+1)
                        curr_val = 8;
                    end                    
                end
                func = [func curr_val];
                
            end
            func = func - 1;
            
            if mod(temp_freq,1) ~= 0
                tf_str = regexp(num2str(temp_freq),'\.','split');
                tf_str = [tf_str{1} 'pt' tf_str{2}];
            else
                tf_str = num2str(temp_freq);
            end
            
            func = repmat(func,1,reps);            
            
            function_name = [name, tf_str, 'Hz' num2str(period) 's_period'];
            counter = counter + 1;
            save_function(project,function_name,func,counter,sampling_rate);
        end
    end
    
    function save_function(project,function_name,func,counter,sampling_rate) %#ok<INUSL>
        %% Save the function in the for loop
        switch computer
            case {'PCWIN','PCWIN64'}
                root_func_dir = 'C:\tethered_flight_arena_code\position_functions';
            case {'MACI64'}
                root_func_dir = '/Users/stephenholtz/tethered_flight_arena_code/position_functions';
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
        
        function_name = ['position_function' '_' count temp{2} '_samp_' num2str(sampling_rate) 'Hz'];
        file_name = fullfile(root_func_dir,project,function_name);
        save(file_name, 'func');
        disp(function_name); 
    end
end