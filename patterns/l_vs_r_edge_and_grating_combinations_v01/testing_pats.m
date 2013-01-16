% Make edge vs several spatial frequencies to find an optimum for
% regressive motion

clear Pats

% Project name is folder patterns live in.
project = 'testing';

% Pattern properties needed later
row_compression = 0;
gs_val = 3;
testing_flag = 1;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% Use the patternFactory class to make all of the patterns.
bar_factory = patternFactory('small',row_compression,gs_val);
bar_factory.SingleBar(8,'low',0,0:8:88);
bar_factory.AddDummyFrames('x',1)
Pats(:,:,:,1) = bar_factory.ReturnPatternAndParams;

bar_factory.VerticalTopBottomMaskUncompressedPattern(6)
Pats(:,:,:,3) = bar_factory.ReturnPatternAndParams;

bar_factory.SingleBar(4,'low',2,0:8:88);
bar_factory.AddDummyFrames('x',1)
Pats(:,:,:,2) = bar_factory.ReturnPatternAndParams;

bar_factory.VerticalTopBottomMaskUncompressedPattern(6)
Pats(:,:,:,4) = bar_factory.ReturnPatternAndParams;

pattern_name = 'test';
counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);