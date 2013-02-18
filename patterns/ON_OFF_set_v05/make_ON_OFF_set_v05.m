% make the patterns for ON and OFF stimuli. All very! easily modifiable,
% except john's patterns (resaved with numbering that fits patterns made
% here)

clear Pats

% Project name is folder patterns live in.
project = 'ON_OFF_set_v05';

% Pattern properties needed later
row_compression = 0;
gs_val = 2;
testing_flag = 0;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% Minimal Motion Stimuli - Y positions change the location of the first
% 'bar' appearance. One pattern for CW and one pattern for CCW. all of
% these will have a dummy frame and need 'step-step' position functions
dist_bn_bars = 8;

for bar_size = 4
    for et_1 = {'on','off'}
        
        edge_type_1 = et_1{1};
        
        for et_2 = {'on','off'}
            
            edge_type_2 = et_2{1};
            
            for dir = {'cw','ccw'}
                
                direction = dir{1};
                
                bar_factory = patternFactory('small',row_compression,gs_val);
                start_cols = 0;
                bar_factory.MinimalMotionMultiple(bar_size,start_cols,direction,edge_type_1,edge_type_2,dist_bn_bars);
                bar_factory.AddDummyFrames('x',1);
                Pats(:,:,:,:) = bar_factory.ReturnPatternAndParams;
                
                pattern_name = [edge_type_1 '_to_' edge_type_2 '_minimal_motion_stim_step_' direction '_bar_sz_' num2str(bar_size) '_' num2str(dist_bn_bars) '_spacing_w_dummy_x_frame'];
                
                counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);
                
                clear Pats bar_factory
                
            end
        end
    end
end

% Bright and dark edges moving from opposite sides of the arena (CW and
% CCW) moving inward and meeting in the middle. The Y channels swap the
% bright and dark edges on each side. 

edge_factory = patternFactory('small',row_compression,gs_val);
start_loc = 0;
jump_size = 1;
on_direction = 'cw'; % The direction that the bright edge is going
edge_factory.MakeONOFFEdges(start_loc,jump_size,on_direction);
edge_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = edge_factory.ReturnPatternAndParams;

edge_factory = patternFactory('small',row_compression,gs_val);
on_direction = 'ccw'; % The direction that the bright edge is going
edge_factory.MakeONOFFEdges(start_loc,jump_size,on_direction);
edge_factory.AddDummyFrames('x',1);
Pats(:,:,:,2) = edge_factory.ReturnPatternAndParams;

pattern_name = ['ON_OFF_converging_rear_edges_step' num2str(jump_size) '_w_dummy_x_frame'];

counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats edge_factory

% Same, but for starting movement from the middle and moving apart.
edge_factory = patternFactory('small',row_compression,gs_val);
start_loc = 48;
jump_size = 1;
on_direction = 'cw'; % The direction that the bright edge is going
edge_factory.MakeONOFFEdges(start_loc,jump_size,on_direction);
edge_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = edge_factory.ReturnPatternAndParams;

edge_factory = patternFactory('small',row_compression,gs_val);
on_direction = 'ccw'; % The direction that the bright edge is going
edge_factory.MakeONOFFEdges(start_loc,jump_size,on_direction);
edge_factory.AddDummyFrames('x',1);
Pats(:,:,:,2) = edge_factory.ReturnPatternAndParams;

pattern_name = ['ON_OFF_edges_diverging_center_step' num2str(jump_size) '_w_dummy_x_frame'];

counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats edge_factory

% Sweeping an edge all the way around the arena. Y channels swap between
% OFF and ON. Has dummy frame and position function will need to make the
% CCW and CW versions. Y == 3,4 will be 8 px wide, and 

% 98 in the x channel

loop_vec = 0:96;
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SingleBar(4,'high',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(4,'low',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(8,'high',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,3) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(8,'low',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,4) = bar_factory.ReturnPatternAndParams;

pattern_name = 'ON_OFF_looping_bar_CW_4_8_wide_w_dummy_x_frame';

counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats bar_factory

loop_vec = 96:-1:0;
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SingleBar(4,'high',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(4,'low',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(8,'high',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,3) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(8,'low',0,loop_vec);
bar_factory.AddDummyFrames('x',1);
Pats(:,:,:,4) = bar_factory.ReturnPatternAndParams;

pattern_name = 'ON_OFF_looping_bar_CCW_4_8_wide_w_dummy_x_frame';

counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats bar_factory

% Make the steady state perturbation stimuli
start_mid_end_locs = [25 44 64];
for et_1 = {'on','off'}

    edge_type_1 = et_1{1};
    
    for et_2 = {'on','off'}

        edge_type_2 = et_2{1};

        for dir = {'cw','ccw'}

            direction = dir{1};
            
            bar_factory = patternFactory('small',row_compression,gs_val);
            bar_factory.SteadyStateONOFFStimulus(start_mid_end_locs,direction,edge_type_1,edge_type_2);
            bar_factory.AddDummyFrames('x',1);
            Pats(:,:,:,:) = bar_factory.ReturnPatternAndParams;

            pattern_name = [edge_type_1 '_to_' edge_type_2 '_steady_state_switch_' direction '_w_dummy_x_frame'];
            
            counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

            clear Pats bar_factory

        end
    end
end



% Copy the telethon motion stimuli from their default locations and rename
% them with this naming scheme. (also copy the telethon optomotor stimuli)

telethon_pat_loc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns/';

for telethon_pat = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat',...
                    'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat',...
                    'Pattern_23_expansion_on_foeright_48_RC_telethon.mat',...
                    'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat',...
                    'Pattern_25_expansion_off_foeright_48_RC_telethon.mat',...
                    'Pattern_12_rotation_sf_48P_RC.mat'}

    load(fullfile(telethon_pat_loc,telethon_pat{1}))
    
    if counter < 10
        new_telethon_pattern_name = ['Pattern_00' num2str(counter) telethon_pat{1}(11:end)];
    elseif counter < 100
        new_telethon_pattern_name = ['Pattern_0' num2str(counter) telethon_pat{1}(11:end)];
    else
        new_telethon_pattern_name = ['Pattern_' num2str(counter) telethon_pat{1}(11:end)];
    end
    
    counter = counter + 1;
    
    new_file_loc = fullfile('/Users/stephenholtz/tethered_flight_arena_code/patterns',project,new_telethon_pattern_name);
    
    save(new_file_loc,'pattern')

    disp(new_file_loc)
    
    clear pattern

end

% Here are john's other patterns I am adding in because nothing else really
% works well enough to justify not using them.
telethon_pat_loc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/jct_on_off_rotation_pats/';

for telethon_pat = {'Pattern_71_rotation_on.mat',...
                    'Pattern_72_rotation_off.mat',...
                    'Pattern_73_rotation_opposed.mat'}
    
    load(fullfile(telethon_pat_loc,telethon_pat{1}))
    
    if counter < 10
        new_telethon_pattern_name = ['Pattern_00' num2str(counter) telethon_pat{1}(11:end)];
    elseif counter < 100
        new_telethon_pattern_name = ['Pattern_0' num2str(counter) telethon_pat{1}(11:end)];
    else
        new_telethon_pattern_name = ['Pattern_' num2str(counter) telethon_pat{1}(11:end)];
    end
    
    counter = counter + 1;
    
    new_file_loc = fullfile('/Users/stephenholtz/tethered_flight_arena_code/patterns',project,new_telethon_pattern_name);
    
    save(new_file_loc,'pattern')

    disp(new_file_loc)
    
    clear pattern

end



