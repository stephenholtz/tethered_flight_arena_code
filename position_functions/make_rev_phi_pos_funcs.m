% Make reverse phi position functions, reverse phi with phase delay
% position functions, and reverse phi with adaptation period position
% functions

project = 'reverse_phi';

for type = 1:3

name = 'position_function_';
temporal_freqs = [.5 1 2 4]; % the .5 is hard coded below to show up as 0-5
sampling_rate = 500; %500 hz allows for 2ms precision in offsets
pattern_x_length = 16;
pattern_y_length = 2;
position_func_length = 3; % seconds

switch type
    case 1
    % Normal reverse phi
    name = [name 'rev_phi']; %#ok<*AGROW>
    offsets = 0;  % in radians
    
    case 2
    % Phase delay reverse phi
    name = [name 'rev_phi_phase_delay'];
    offsets = 0;  % in radians
    
    case 3
    % Phase delay adaptation reverse phi
    name = [name 'rev_phi_adapt_'];
end

for tf = temporal_freqs
    for channel = ['x','y']
        % This functino name is long, but should have everything needed to
        % understand what it should be used for
        if tf < 1
            tf_str = '0-5'; % hard coded!
        else
            tf_str = num2str(tf);
        end
        function_name = [name '_tf_' tf_str '_' channel 'chan_' 'at_' num2str(sampling_rate) 'Hz'];
        
        % Make the actual functions here, need another switch on the type
        % because they all need different manipulations, bad coding!
        
        % For 1 Hz tf --> travel spatial frequency of pattern for the
        % sampling rate; i.e. 16 pix in 1 second, or 16 pix in 500 samples
        % if at 500 hz. 500/16 = 31.25 ~ 31, actual tf = (31*16)/500 = .992
        % hz
        
        % 
        spacing_bn_samps = ceil((tf * sampling_rate)/pattern_x_length);
        repeats_of_step = ceil((position_func_length*sampling_rate)/(spacing_bn_samps));
        
        real_tf = (spacing_bn_samps*pattern_x_length)/sampling_rate;
        fprintf('\nideal tf = %2.2d; actual tf = %2.2d\n ',tf, real_tf);
        
        func = [];
        
        switch channel
            case 'x'
                for g = 1:repeats_of_step
                    func = [func repmat(g-1,spacing_bn_samps,1)];
                end
            
            case 'y'
            % Channel y will need only to change between 1 and 2                
                for g = 1:repeats_of_step
                    func = [func repmat(mod(g-1,2),spacing_bn_samps,1)];
                end
        end
        
        % Make it the correct number of samples
        func = func(1:sampling_rate*position_func_length);
        
        % Save the function
        
        switch computer
            case {'PCWIN','PCWIN64'}
                root_func_dir = 'C:\tethered_flight_arena_code\position_functions';
            case {'MACI64'}
                root_func_dir = '/Users/holtzs/tethered_flight_arena_code/position_functions';
            otherwise
                error('is this linux?')
        end
        
        file_name = fullfile(root_func_dir,project,function_name);
        save(file_name, 'func');
        disp(function_name); clearvars('function_name')
        
    end
end
end