function make_motion_flashing_priming_functions_pt1
%% info

% sanity outline:

%% Set up some default values

project = 'priming';
temporal_freqs = [-3 -1 -.5 0 +.5 +1 +3];
priming_lengths = [50 100 250]; % in ms
sampling_rate = 333;            % 400 hz allows for 2 ms precision in offsets
pattern_flicker_vals = [0 7];  % 'on' and 'off' positions in the x chan
counter = 0;
function_total_length = 10; % 10 seconds (Make it really long so that I don't have to worry about aliasing...)
x_length = 16; % spatial wavelenth of the stimulus
y_length = 2;  % reversing polarity

%% Make the functions
for prime_type = {'motion','flicker'}; %,'rev_phi_X_chan','rev_phi_Y_chan'} add in later!
for pattern_x_length = 16; % the wavelength of the function (1/sf)
for prime_length = priming_lengths
for priming_freq = temporal_freqs
    base_name = ['position_function_' 'lam_' num2str(pattern_x_length) '_'];
    
    if mod(priming_freq,1) ~= 0
        tf_str = regexp(num2str(priming_freq),'\.','split');
        tf_str = [tf_str{1} 'pt' tf_str{2}];
    else
        tf_str = num2str(priming_freq);
    end
    
    pri_name = [base_name, prime_type,'_prime_', tf_str, 'Hz_', num2str(prime_length),'ms'];
    
    % get samples per step and the tf associated with this
    samples_per_priming_step = floor((sampling_rate/1)*(1/abs(priming_freq))*(1/pattern_x_length));
    actual_tf = (1/samples_per_priming_step)*(sampling_rate/1)*(1/pattern_x_length)
    % MIGHT BE BROKEN FROM HERE UP....
    switch prime_type{1}
        case 'motion'
            prime_func = [];
            num_prime_motion_steps = floor((1/sampling_rate)*(1000*prime_length)*(1/numel(samples_per_priming_step)));
            actual_prime_length=num_prime_motion_steps*(1/1000)*samples_per_priming_step;
            
            start_val = 0
            step_val = start_val;
            for i = 1:num_prime_motion_steps
                prime_func = [prime_func repmat(step_val,1,abs(samples_per_priming_step))]; %#ok<*AGROW>
                if (step_val - start_val) == (x_length-1)
                    step_val = start_val;
                end
            end
            if priming_freq < 0
                prime_func = fliplr(prime_func);
            end
            
        case {'flicker'}
            prime_func = [repmat(pattern_flicker_vals(1),1,samples_per_priming_step)...
                          repmat(pattern_flicker_vals(2),1,samples_per_priming_step)];
            prime_func = repmat(prime_func,1,num_prime_reps);
            % i.e. (400samps/1sec)(0.1sec prime)(1/samps per func
            % iteration) = num func iterations (floor or ceil of it...)
            num_prime_reps = floor((1/sampling_rate)*(1000*prime_length)*(1/numel(prime_func)));
            actual_prime_length = num_prime_reps*numel(prime_func)*1000 %#ok<*NOPRT>
            
%         case 'rev_phi_X_chan'
%             prime_func = [];
%         case 'rev_phi_Y_chan'
%             prime_func = [];
    end
    
    for test_freq = temporal_freqs
        if mod(test_freq,1) ~= 0
            tf_str = regexp(num2str(test_freq),'\.','split');
            tf_str = [tf_str{1} 'pt' tf_str{2}];
        else
            tf_str = num2str(test_freq);
        end
        
        function_name = [pri_name, 'test_', tf_str, 'Hz', '_samp_' num2str(sampling_rate)];
        % get samples per step and the tf associated with this
        samples_per_test_step = floor((sampling_rate/1)*(1/priming_freq)*(1/pattern_x_length));
        actual_tf = (1/samples_per_test_step)*(sampling_rate/1)*(1/pattern_x_length); %#ok<*NASGU>
        test_func = prime_func;
        
        num_reps = ceil(function_total_length/(numel(test_func)/sampling_rate));
        test_func = repmat(test_func,1,num_reps);
        position_func = [prime_func test_func];
        
        counter = counter + 1;
        save_function(project,[function_name{:}],position_func,counter);
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
