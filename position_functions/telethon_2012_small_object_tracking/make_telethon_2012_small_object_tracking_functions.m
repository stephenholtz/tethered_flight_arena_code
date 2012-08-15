% Make small object tracking sine wave position functions
% All will be 1 Hz - and will be at different positions around the arena
% (with both phases)

switch computer
    case {'PCWIN','PCWIN64'}
        root_dir = 'C:\tethered_flight_arena_code\position_functions';
    case {'MACI64'}
        root_dir = '/Users/holtzs/tethered_flight_arena_code/position_functions';
    otherwise
        error('is this linux?')            
end
project = 'telethon_2012_small_object_tracking';
counter = 12; % This is the number of previously existing telethon position functions
name = 'small_obj_track_1Hz_sine_wave_';

amplitude = 6; % 22.5 degrees @ 1 Hz, from Maimon et al 2008
base_func = amplitude*(make_sine_wave_function(10, 50, 1));

for loc = 1:3
    if loc == 1;
        location = 'pos33_';
        dir_func = base_func + 33;
    elseif loc == 2;
        location = 'pos49_';  
        dir_func = base_func + 49;
    elseif loc == 3;
        location = 'pos65_';  
        dir_func = base_func + 65;
    end
    loc_name = [name location];

    for dir = 1:2
        
        if dir == 1
            direction = 'positive_';
            func = round(dir_func);
        else
            direction = 'negative_';
            func = round(fliplr(dir_func));
        end
        dir_name = [loc_name direction];

        plot(func); hold all;
        
        counter = counter + 1;
        count = num2str(counter);
        
        % Need to add the z because john doesn't have numbers on his
        % position functions -- could just number those...
        function_name = ['position_function_z_' count '_' dir_name '50Hz_samp'];
        function_names{counter-12} = function_name;
        file_name = fullfile(root_dir,project,function_name);
        disp(file_name);
        save(file_name, 'func');

    end
end

legend(function_names);
