% make all of the position functions for the l vs r edge and grating etc.,
% all patterns will have dummy frames in the first position so indexed from
% 1:end, and loop without 0

clear func

output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/l_vs_r_edge_and_grating_combinations_for_pfuncs_v01';
dummy_frame_flag = 1;

spatial_freq_list = [4 8 16 24];

temp_freq_list = [.5 4 8];

func_iter = 1;

for temp_freq = temp_freq_list

    for spatial_freq = spatial_freq_list
        
        for direction = [-1 1]
            
            for stim_type = {'grat','edge'} 
                
                fps = spatial_freq*temp_freq;
                
                switch stim_type{1}
                    
                    case 'grat'
                        
                        [func,pos_func_samp_freq] = make_determine_best_simple_looping_position_functions(spatial_freq,temp_freq,direction,dummy_frame_flag);
                        
                    case 'edge'
                        func = 1:(32+(spatial_freq/2));
                        
                        pos_func_samp_freq = fps;
                        
                        if dir == -1
                            func = fliplr(func);
                        end
                end

                temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');

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
                
                % will just have to do some regexp on this...
                func_name = [stim_type{1} '_sf_' num2str(spatial_freq) 'Hz_tf_' temp_freq_name 'Hz_fps_' num2str(fps) '_SAMP_RATE_' pos_func_samp_freq_name '_dir_' dir];
                
                if numel(num2str(func_iter)) < 2
                    count = ['00' num2str(func_iter)];
                elseif numel(num2str(func_iter)) < 3
                    count = ['0' num2str(func_iter)];        
                else
                    count = num2str(func_iter);        
                end

                func_name = ['position_function_' count '_' func_name]; %#ok<*AGROW>

                save(fullfile(output_location,func_name),'func')

                clear func_name

                func_iter = func_iter + 1;
            end        
        end
    end

end
