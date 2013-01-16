% Make windowed versions of flicker patterns

% Project name is folder patterns live in.
project = 'unilateral_flicker_and_phi_revphi_motion_windowed_v01';

% Pattern properties needed later
row_compression = 1;
gs_val = 3;
testing_flag = 1;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% Patterns: Unilateral Flicker, Unilateral Motion, Flicker + Motion
%grating_bar_sizes_freqs = [4 8 16 24]/2;
grating_bar_sizes_freqs = [8 16]/2;

% Make all the combinations of left and right (and unilateral stimuli)

% First make all flicker types (in flick_side_pat)
for side = {'left','right'}

    flicker60_pat_iter = 1;
    flicker120_pat_iter = 1;
    
    for flick_type = {'full_field_120_deg_mask','edge_120_deg_mask','full_field_60_deg_mask','edge_60_deg_mask'}
        
        switch flick_type{1}

            case 'full_field_120_deg_mask'
                function_name = ('FullFieldFlicker');
                flick_iters = 0;
                mask_size = 120;
                do_top_bottom_mask = 0;
                
            case 'edge_120_deg_mask'
                function_name = ('EdgeFlicker');
                flick_iters = grating_bar_sizes_freqs;
                mask_size = 120;
                do_top_bottom_mask = 0;
                
            case 'full_field_60_deg_mask'
                function_name = ('FullFieldFlicker');
                flick_iters = 0;
                mask_size = 60;
                do_top_bottom_mask = 1;
                
            case 'edge_60_deg_mask'
                function_name = ('EdgeFlicker');
                flick_iters = grating_bar_sizes_freqs;
                mask_size = 60;
                do_top_bottom_mask = 1;
        end
        
        for flick = flick_iters
            
            if mask_size == 60
                
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter} = patternFactory('small',row_compression,gs_val); %#ok<*SAGROW>
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter}.(function_name)(flick);
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter}.SimpleMask(side{1},mask_size);
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter}.MaskTopBottomPanelsInRowCompressedPattern;
                %flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter}.AddDummyFrames('x',1);
                
                if strcmpi(side,'right')
                    flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter}.SwitchXYChannels;
                end
                
                if numel(num2str(flick*2)) == 1
                    padding = '00';
                elseif numel(num2str(flick*2)) == 2
                    padding = '0';
                end
                
                flick_side_pat_names.(side{1}).(['l_' num2str(mask_size)]){flicker60_pat_iter} = ['flicker_' flick_type{1} '_lam_' padding num2str(flick*2)];

                flicker60_pat_iter = flicker60_pat_iter + 1;
            
            elseif mask_size == 120
                
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter} = patternFactory('small',row_compression,gs_val); %#ok<*SAGROW>
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter}.(function_name)(flick);
                flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter}.SimpleMask(side{1},mask_size);
                %flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter}.AddDummyFrames('x',1);

                if strcmpi(side,'right')
                    flick_side_pat.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter}.SwitchXYChannels;
                end
                
                if numel(num2str(flick*2)) == 1
                    padding = '00';
                elseif numel(num2str(flick*2)) == 2
                    padding = '0';
                end
                
                flick_side_pat_names.(side{1}).(['l_' num2str(mask_size)]){flicker120_pat_iter} = ['flicker_' flick_type{1} '_lam_' padding num2str(flick*2)];

                flicker120_pat_iter = flicker120_pat_iter + 1;
                
            end
        end
    end
end

% Make all motion types (in mot_side_pat)

for side = {'left','right'}
    
    mot60_pat_iter = 1;
    mot120_pat_iter = 1;
    
    for mask_size = [120,60]
        for bar_width = grating_bar_sizes_freqs
            
            if mask_size == 60

                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter} = patternFactory('small',row_compression,gs_val);
                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter}.SquareWave(flick);
                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter}.SimpleMask(side{1},mask_size);
                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter}.MaskTopBottomPanelsInRowCompressedPattern;
                %mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter}.AddDummyFrames('x',1);

                if strcmpi(side,'right')
                    mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter}.SwitchXYChannels;
                end
                
                if numel(num2str(bar_width*2)) == 1
                    padding = '00';
                elseif numel(num2str(bar_width*2)) == 2
                    padding = '0';
                end
                
                mot_side_pat_names.(side{1}).(['l_' num2str(mask_size)]){mot60_pat_iter} = ['motion_mask' num2str(mask_size) '_lam_' padding num2str(bar_width*2)];

                mot60_pat_iter = mot60_pat_iter + 1;

            elseif mask_size == 120

                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter} = patternFactory('small',row_compression,gs_val);
                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter}.SquareWave(flick);
                mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter}.SimpleMask(side{1},mask_size);
                %mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter}.AddDummyFrames('x',1);

                if strcmpi(side,'right')
                    mot_side_pat.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter}.SwitchXYChannels;
                end
                
                if numel(num2str(bar_width*2)) == 1
                    padding = '00';
                elseif numel(num2str(bar_width*2)) == 2
                    padding = '0';
                end
                
                mot_side_pat_names.(side{1}).(['l_' num2str(mask_size)]){mot120_pat_iter} = ['motion_mask' num2str(mask_size) '_lam_' padding num2str(bar_width*2)];
                
                mot120_pat_iter = mot120_pat_iter + 1;

            end
            
        end
    end
end

% Create all left and right by selves
for mask_size = [120,60]
    for pat_type = {'mot_side_pat','flick_side_pat'}

        % Stupid matlab.
        tmp.(pat_type{1}) = eval(pat_type{1});
        tmpN.([pat_type{1} '_names']) = eval([pat_type{1} '_names']);

        for side = {'left','right'}

            for pat_num = 1:numel(tmp.(pat_type{1}).(side{1}).(['l_' num2str(mask_size)]))

                Pats = tmp.(pat_type{1}).(side{1}).(['l_' num2str(mask_size)]){pat_num}.ReturnPatternAndParams;
                pattern_name = tmpN.([pat_type{1} '_names']).(side{1}).(['l_' num2str(mask_size)]){pat_num};

                switch side{1}
                    case 'left'
                        pattern_name = ['left_' pattern_name '_right_empty']; %#ok<*AGROW>
                    case 'right'
                        pattern_name = ['left_empty_right_' pattern_name];
                end

                counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);
                
            end
        end
    end
end

% Combine
for mask_size = [120,60]
    for flick_pat = 1:numel(flick_side_pat.right.l_60)
        for mot_pat = 1:numel(mot_side_pat.right.l_60)
            for combo_type = 1:3

                % Motion on the left
                if combo_type == 1

                    L_Pat = mot_side_pat.left.(['l_' num2str(mask_size)]){mot_pat};
                    R_Pat = flick_side_pat.right.(['l_' num2str(mask_size)]){flick_pat};

                    pattern_name = ['left_' mot_side_pat_names.left.(['l_' num2str(mask_size)]){mot_pat} '_right_' flick_side_pat_names.right.(['l_' num2str(mask_size)]){flick_pat}];

                % Motion on the right
                elseif combo_type == 2

                    L_Pat = flick_side_pat.left.(['l_' num2str(mask_size)]){flick_pat};
                    R_Pat = mot_side_pat.right.(['l_' num2str(mask_size)]){mot_pat};                

                    pattern_name = ['left_' flick_side_pat_names.left.(['l_' num2str(mask_size)]){flick_pat} '_right_'  mot_side_pat_names.right.(['l_' num2str(mask_size)]){mot_pat}];
                
                % Motion on both sides
                elseif combo_type == 3

                    L_Pat = mot_side_pat.left.(['l_' num2str(mask_size)]){mot_pat};
                    R_Pat = mot_side_pat.right.(['l_' num2str(mask_size)]){mot_pat};                
                    
                    pattern_name = ['left_' mot_side_pat_names.left.(['l_' num2str(mask_size)]){mot_pat} '_right_'  mot_side_pat_names.right.(['l_' num2str(mask_size)]){mot_pat}];
                                    
                end
                
                Pats = patternFactory.AddPatternsBilatLeftRight(L_Pat,R_Pat,120);

                counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);
            end 
        end
    end
end

