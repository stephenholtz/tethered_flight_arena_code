% make a bar that flickers at a few positions around the arena with a few
% heights and widths changing in the Y chan.

% Project name is folder patterns live in.
project = 'short_visual_phenotype_test_v01';

% Pattern properties needed later
row_compression = 0;
gs_val = 3;
testing_flag = 0;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% Use the patternFactory class to make all of the patterns.
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SquareWave(4);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

pattern_name = 'optomotor_4_wide_gs3';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats

bar_factory.SquareWaveContrasts(4,[7 0]);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;
bar_factory.SquareWaveContrasts(4,[6 1]);
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;
bar_factory.SquareWaveContrasts(4,[5 2]);
Pats(:,:,:,3) = bar_factory.ReturnPatternAndParams;
bar_factory.SquareWaveContrasts(4,[4 3]);
Pats(:,:,:,4) = bar_factory.ReturnPatternAndParams;

pattern_name = 'optomotor_4_wide_contrasts_1_71_43_14';
save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats

counter = 6;

bar_factory.SingleBar(2,'low',3,0:95);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;
bar_factory.SingleBar(2,'high',3,0:95);
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;

pattern_name = 'small_stripe_2_wide_gs3_mid_bck';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

clear Pats