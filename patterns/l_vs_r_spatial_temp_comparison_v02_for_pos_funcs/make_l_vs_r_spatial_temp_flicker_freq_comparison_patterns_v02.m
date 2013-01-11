% function make_l_vs_r_spatial_temp_flicker_freq_comparison_patterns_v02()
% Make edge vs several spatial frequencies to find an optimum for
% regressive motion (but include progressive).


% Project name is folder patterns live in
project = 'l_vs_r_edges_spatial_temps_comparison';
row_compression = 1;
gs_val = 3;
testing_flag = 1;

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% All combinations of spatial frequencies, and edges.


counter = save_make_panelsV3_pattern(Pats,row_compression,gs_val,pattern_name,project,counter,testing_flag);

% All Unilateral gratings and edges.


% Use the patternFactory class to make all of the patterns.
left_pattern = patternFactory('small',row_compression,gs_val);
left_pattern.RevPhiSquareWave(4)
left_pattern.AddPatternLoops(2)
left_pattern.AddDummyFrames('x',1)

right_pattern = patternFactory('small',row_compression,gs_val);
right_pattern.EdgeFlicker(4)
right_pattern.AddPatternLoops(2)
right_pattern.AddDummyFrames('x',1)

%Pats = patternFactory.AddPatternsBilatLeftRight(left_pattern,right_pattern,120);
Pats = patternFactory.AddPatternsOverlayedForNulling(left_pattern,right_pattern,4);

pattern_name = 'testtesttest';


