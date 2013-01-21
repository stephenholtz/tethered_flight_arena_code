% Make small object tracking sine wave position functions
% All will be 1 Hz - and will be at different positions around the arena
% (with both phases)

switch computer
    case {'PCWIN','PCWIN64'}
        root_dir = 'C:\tethered_flight_arena_code\position_functions';
    case {'MACI64'}
        root_dir = '/Users/stephenholtz/tethered_flight_arena_code/position_functions';
    otherwise
        error('is this linux?')            
end
project = 'short_visual_phenotype_test_v01';
counter = 0;
name = 'small_obj_track_1Hz_sine_wave_';

amplitude = 12; % 22.5 degrees @ 1 Hz, from Maimon et al 2008
base_func = amplitude*(make_sine_wave_function(20, 50, 1));

for loc = 1

    location = 'pos49_';  
    dir_func = base_func + 49;

    loc_name = [name location];

    for dir = 1:2
        
        if dir == 1
            direction = 'positive_';
            func = round(dir_func) - 1; % Need to subtract one, numbered from 0
        else
            direction = 'negative_';
            func = round(fliplr(dir_func)) - 1; % Need to subtract one, numbered from 0
        end
        dir_name = [loc_name direction];

        plot(func); hold all;
        
        counter = counter + 1;
        count = ['00' num2str(counter)];
        
        % Need to add the z because john doesn't have numbers on his
        % position functions -- could just number those...
        function_name = ['position_function_' count '_' dir_name '50Hz_samp'];
        file_name = fullfile(root_dir,project,function_name);
        disp(file_name);
        save(file_name, 'func');

    end
end