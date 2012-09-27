% make_rev_phi_no_stagger_testing_v01_pos_funcs

func_count = 0;

for temp_freq = 1

% Direction: 1-cw, 2-ccw
directions = 1;
    
% The rate to set the function to (samples/second)
sampling_rate = 200;

% The increment between motion and flicker
delay_increment = 1;
delay_increment_ms = 1000 * delay_increment/sampling_rate;

% How many 'steps' in the position function minimum between flick and mot
minimum_delay = 1;
minimum_delay_ms = 1000 * minimum_delay/sampling_rate;

% Spatial frequency of just the movement part of the stimulus
spat_freq = 8;

% Pattern length, should be twice the spatial frequency
pat_length = spat_freq*2;

% Temporal frequency of the stimulus motion component
% temp_freq = 1;

% Length of the stimulus presentation in ms
stim_length = 3000;

% The temporal frequency determines the time between each first step.
% (1/temp_freq) * (1/spat_freq) * samp_rate = samples/step
first_step_spacing = (1/temp_freq) * (1/spat_freq) * sampling_rate;
first_step_spacing = round(first_step_spacing);

% Determine the number of possible delays between first and second steps
% (either the flick->move or move->flick) for the temporal frequency
% The maximum delay/2 will be completely out of phase flicker and motion;
maximum_delay = ceil(first_step_spacing/2);

delays = minimum_delay:delay_increment:maximum_delay;

num_cycles = ceil(stim_length/first_step_spacing);

% Base name of function
name = 'rev_phi_phase_delay';

project = 'rev_phi_no_stagger_testing_v01';

switch computer
    case {'PCWIN','PCWIN64'}
        root_func_dir = 'C:\tethered_flight_arena_code\position_functions';
    case {'MACI64'}
        root_func_dir = '/Users/holtzs/tethered_flight_arena_code/position_functions';
    otherwise
        error('is this linux?')
end

for i = 1:numel(delays);

    % Make the phase delay functions        
    for dir = directions
        if dir == 1
            dir_str = 'cw';
            step_vector = [ones(1,first_step_spacing - delays(i)) 2*ones(1,delays(i))];
            
        else
            dir_str = 'ccw';
            step_vector = [(pat_length)*ones(1,first_step_spacing - delays(i)) (pat_length-1)*ones(1,delays(i))];
            
        end
        
        step_iterator = 0;
        
        func = [];
        
        for g = 1:num_cycles

            func = [func step_vector+step_iterator];

            if dir == 1
                
                if step_iterator == pat_length-2;
                    step_iterator = 0;
                else
                    step_iterator = step_iterator + 2;
                end
                
            else
                
                if step_iterator == 2-pat_length;
                    step_iterator = 0;
                else
                    step_iterator = step_iterator - 2;
                end                 
            end
        end
        
        % functions are incremented from zero
        func = func - 1;
        
        % functions need to be saved in an automatic way
        func_count = func_count + 1;

        if func_count < 10;
            count_str = [ '0' num2str(func_count)];
        else
            count_str = num2str(func_count);
        end
        
        function_name = ['position_function_' count_str '_' name '_' num2str(delay_increment_ms*delays(i)) '_ms_' dir_str];
        
        file_name = fullfile(root_func_dir,project,function_name);
        
        save(file_name,'func')
    
    end
    
end
    
    % Make a standard reverse phi function in both directions
    
    for dir = directions
        
        if dir == 1
            dir_str = 'cw';
            step_vector = ones(1,first_step_spacing);
            
        else
            dir_str = 'ccw';
            step_vector = (pat_length)*ones(1,first_step_spacing);
            
        end
        
        step_iterator = 0;
        
        func = [];
        
        for g = 1:num_cycles
            
            func = [func step_vector+step_iterator];
            
            if dir == 1
                
                if step_iterator == pat_length-1;
                    step_iterator = 0;
                else
                    step_iterator = step_iterator + 1;
                end
                
            else
                
                if step_iterator == 1-pat_length;
                    step_iterator = 0;
                else
                    step_iterator = step_iterator - 1;
                end
            end
        end
        % functions are incremented from zero
        func = func - 1;
        
        % functions need to be saved in an automatic way
        func_count = func_count + 1;
        
        if func_count < 10;
            count_str = [ '0' num2str(func_count)];
        else
            count_str = num2str(func_count);
        end
        
        function_name = ['position_function_' count_str '_' name '_no_delay_' dir_str];
        
        file_name = fullfile(root_func_dir,project,function_name);
        
        save(file_name,'func')
        
    end
    
end
    