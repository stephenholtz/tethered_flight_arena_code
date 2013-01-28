% make a bar that flickers at a few positions around the arena with a few
% heights and widths changing in the Y chan.

clear Pats
% Project name is folder patterns live in.
project = 'closed_loop_interspersal_pats';

% Pattern properties needed later
row_compression = 0;
gs_val = 2;
testing_flag = 0;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 999;

%loop_vec = 0:8:88; % every col
loop_vec = 0:95;

% Use the patternFactory class to make all of the patterns.
bar_factory = patternFactory('small',row_compression,gs_val);

bar_factory.SingleBar(8,'low',0,loop_vec);
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;
bar_factory.SingleBar(8,'high',0,loop_vec);
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;

pattern_name = '8px_stripe_mid_bck';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);
