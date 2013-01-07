% Make all of the position functions for the simple looping stimuli

output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/l_vs_r_position_functions';

spatial_freq_list = [4 8 16 24];

temp_freq_list = [.5 4 8];

%pos_func_samp_freq = 400;

func_iter = 1;

for temp_freq = temp_freq_list

    for spatial_freq = spatial_freq_list
        
        for direction = [-1 1]
            
            [func,pos_func_samp_freq] = make_determine_best_simple_looping_position_functions(spatial_freq,temp_freq,direction);

            if temp_freq < 1
                temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
            else
                temp_freq_name = num2str(temp_freq);
            end
            
            if direction == -1
                dir = 'cw';
            elseif direction == 1
                dir = 'ccw';
            end
            
            if numel(num2str(pos_func_samp_freq)) < 2
                pos_func_samp_freq_name = ['00' num2str(pos_func_samp_freq)];
            elseif numel(num2str(pos_func_samp_freq)) < 3
                pos_func_samp_freq_name = ['0' num2str(pos_func_samp_freq)];        
            else
                pos_func_samp_freq_name = num2str(pos_func_samp_freq);        
            end
            
            func_name = ['spat_freq_' num2str(spatial_freq) 'Hz_temp_freq_' temp_freq_name 'Hz_at_SAMP_RATE_' pos_func_samp_freq_name '_dir_' dir];

            if numel(num2str(func_iter)) < 2
                count = ['00' num2str(func_iter)];
            elseif numel(num2str(func_iter)) < 3
                count = ['0' num2str(func_iter)];        
            else
                count = num2str(func_iter);        
            end
            
            func_name = ['position_function_' count '_' func_name];

            save(fullfile(output_location,func_name),'func')

            clear func_name

            func_iter = func_iter + 1;
        end
    end

end
