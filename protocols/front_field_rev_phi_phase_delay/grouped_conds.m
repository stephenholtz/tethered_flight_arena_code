% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

%% For figuring out the conditions...
% stim = rev_phi_phase_delay;
% cond_num = 104;
% disp(cond_num)
% disp(stim(cond_num).PosFuncNameX(19:end))
% disp(stim(cond_num).PosFuncNameY(19:end))

%% 
sym_conditions = ...
                       {[1,19];... % 0.5 Hz CW after [ccw]
                        [2,20];... % 
                        [3,21];... % 
                        [4,22];... % 
                        [5,23];... % 
                        [6,24];... % 
                        [7,25];... % 
                        [8,26];... % 
                        [9,27];... % 
                        [10,28];... % 0.5 Hz CW before [ccw]
                        [11,29];... % 
                        [12,30];... % 
                        [13,31];... % 
                        [14,32];... % 
                        [15,33];... % 
                        [16,34];... % 
                        [17,35];... % 
                        [18,36];... % 
                        [37,55];... % 1 Hz CW after
                        [38,56];... % 
                        [39,57];... %
                        [40,58];... %
                        [41,59];... %
                        [42,60];... %
                        [43,61];... %
                        [44,62];... %
                        [45,63];... %
                        [46,64];... % 1 Hz CW before [ccw]
                        [47,65];... %
                        [48,66];... %
                        [49,67];... %
                        [50,68];... %
                        [51,69];... %
                        [52,70];... %
                        [53,71];... %
                        [54,72];... %
                        [73,87];... % 2 Hz CW after [ccw]
                        [74,88];... %
                        [75,89];... %
                        [76,90];... %
                        [77,91];... %
                        [78,92];... %
                        [79,93];... %
                        [80,94];... % 2 Hz CW before [ccw]
                        [81,95];... %
                        [82,96];... %
                        [83,97];... %
                        [84,98];... %
                        [85,99];... %
                        [86,100];... %
                        [101,111];... %  3 Hz CW after [ccw]
                        [102,112];... %                        
                        [103,113];... % 
                        [104,114];... % 
                        [105,115];... % 
                        [106,116];... % 3 Hz CW before [ccw]
                        [107,117];... % 
                        [108,118];... % 
                        [109,119];... %  
                        [110,120]};

grouped_conditions{1}.name = '0.5 Hz';
grouped_conditions{1}.x_axis = [-62.5 -55 -45 -37.5 -27.5 -20 -10 -2.5 0 0 2.5 20 27.5 37.5 45 55 62.5];
grouped_conditions{1}.list = ...
                       {[18,36];... %
                        [17,35];... % 
                        [16,34];... % 
                        [15,33];... % 
                        [14,32];... % 
                        [13,31];... % 
                        [12,30];... % 
                        [11,29];... % 0.5 Hz CW before [ccw]
                        [10,28];... % 0 ms 'before'
                        [1,19];... %  0 ms 'after'
                        [2,20];... %  0.5 Hz CW after [ccw]
                        [3,21];... % 
                        [4,22];... % 
                        [5,23];... % 
                        [6,24];... % 
                        [7,25];... % 
                        [8,26];... % 
                        [9,27]};

grouped_conditions{2}.name = '1 Hz';
grouped_conditions{2}.x_axis = [-30 -25 -22.5 -17.5 -15 -10 -7.5 -2.5 0 0 2.5 7.5 10 15 17.5 22.5 25 30];
grouped_conditions{2}.list = ...
                       {[54,72];... %
                        [53,71];... %                        
                        [52,70];... %
                        [51,69];... %
                        [50,68];... %
                        [49,67];... %
                        [48,66];... %
                        [47,65];... % 1 Hz CW before [ccw]                        
                        [46,64];... % 0 ms 'before'
                        [37,55];... % 0 ms 'after'
                        [38,56];... % 1 Hz CW after [ccw]
                        [39,57];... %
                        [40,58];... %
                        [41,59];... %
                        [42,60];... %
                        [43,61];... %
                        [44,62];... %
                        [45,63]};

grouped_conditions{3}.name = '2 Hz';
grouped_conditions{3}.x_axis = [-15 -12 -10 -7.5  -5 -2.5 0 0 2.5 7.5 10 12 15];
grouped_conditions{3}.list = ...
                       {[86,100];...%
                        [85,99];... %
                        [84,98];... %
                        [83,97];... %
                        [82,96];... %
                        [81,95];... % 2 Hz CW before [ccw]
                        [80,94];... % 0 ms 'before'
                        [73,87];... % 0 ms 'after'
                        [74,88];... % 2 Hz CW after [ccw]
                        [75,89];... %
                        [76,90];... %
                        [77,91];... %
                        [78,92];... %
                        [79,93]};

grouped_conditions{4}.name = '3 Hz';
grouped_conditions{4}.x_axis = [-10 -7.5 -5 -2.5 0 0 2.5 5 7.5 10];
grouped_conditions{4}.list = ...
                       {[110,120];...%  
                        [109,119];... %  
                        [108,118];... % 
                        [107,117];... % 3 Hz CW before [ccw]
                        [106,116];... % 0 ms 'before'
                        [101,111];... % 0 ms 'after'
                        [102,112];... % 3 Hz CW after [ccw]
                        [103,113];... % 
                        [104,114];... % 
                        [105,115]};
