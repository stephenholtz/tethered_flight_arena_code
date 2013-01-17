% Make edge vs several spatial frequencies to find an optimum for
% regressive motion

% Project name is folder patterns live in.
project = 'l_vs_r_edge_and_grating_combinations_v01';

% Pattern properties needed later
row_compression = 1;
gs_val = 3;
testing_flag = 1;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% All combinations of gratings with diff spatial frequencies, and edges
% with different widths on each half of the arena.
grating_bar_sizes_freqs = [4 8 16 24]/2;
edge_bar_sizes = [4 8 16 24]/2;

% Use the patternFactory class to make all of the patterns.
left_pattern = patternFactory('small',row_compression,gs_val);
right_pattern = patternFactory('small',row_compression,gs_val);

for left = {'grating','edge'}
    
    switch left{1}
        
        case 'grating'
            left_iters = grating_bar_sizes_freqs;
            left_func = 'SquareWave';
        case 'edge'
            left_iters = [edge_bar_sizes edge_bar_sizes];
            left_func = 'SingleBarForEdgeLoop';
    end
    
    left_use_regressive = -1;
    
    for left_val = left_iters
        
        switch left{1}
            case 'edge'
                
                if left_val == edge_bar_sizes(1)
                    left_use_regressive = left_use_regressive + 1;
                end
                
                if left_use_regressive
                    left_motion_type = 'regressive';
                else
                    left_motion_type = 'progressive';
                end

            otherwise
                left_motion_type = 'both';
        end
        
        % Passing extra args to SquareWave is allowed
        left_pattern.(left_func)(left_val,'left',left_motion_type);
        left_pattern.AddDummyFrames('x',1);
        
        for right = {'grating','edge'}
            
            switch right{1}
                case 'grating'
                    right_iters = grating_bar_sizes_freqs;
                    right_func = 'SquareWave';
                case 'edge'
                    right_iters = [edge_bar_sizes edge_bar_sizes];
                    right_func = 'SingleBarForEdgeLoop';
            end
            
            right_use_regressive = -1;
            
            for right_val = right_iters
                if counter == 50
                    'barf'
                end                             
                switch right{1}
                    case 'edge'

                        if right_val == edge_bar_sizes(1)
                            right_use_regressive = right_use_regressive + 1;
                        end
                        
                        if right_use_regressive
                            right_motion_type = 'regressive';
                        else
                            right_motion_type = 'progressive';
                        end

                    otherwise
                        right_motion_type = 'both';
                end

                % Passing extra args to SquareWave is allowed
                right_pattern.(right_func)(right_val,'right',right_motion_type);
                right_pattern.SwitchXYChannels;
                right_pattern.AddDummyFrames('y',1);
                
                unshifted_pattern = patternFactory.AddPatternsBilatLeftRight(left_pattern,right_pattern,120);
                
                switch left{1}
                    case 'edge'
                        
                        switch right{1}
                            case 'edge'
                                Pats = unshifted_pattern;
                            case 'grating'
                                Pats = patternFactory.ShiftWindowedToEdgeStart(unshifted_pattern,'y','low',1);
                        end
                        
                    case 'grating'
                        
                        switch right{1}
                            case 'grating'
                                right_shifted_pattern = patternFactory.ShiftWindowedToEdgeStart(unshifted_pattern,'x','low',1);
                                Pats = patternFactory.ShiftWindowedToEdgeStart(right_shifted_pattern,'y','low',1);
                                
                                clear right_shifted_pattern
                            case 'edge'
                                Pats = patternFactory.ShiftWindowedToEdgeStart(unshifted_pattern,'x','low',1);
                        end
                        
                end
                
                pattern_name = cell2mat(['left_' left '_Lbarsize_' num2str(left_val) '_dir_' left_motion_type '_right_' right '_Rbarsize_' num2str(right_val) '_dir_' right_motion_type '_frame_1_empty']);
                
                counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);
  
                clear pattern_name Pats
            end 
        end 
    end
end
