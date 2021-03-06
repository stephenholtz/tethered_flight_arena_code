%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

% For unilateral stimuli (all in terms of cw!):
% ccw_left(-) and cw_right(+)  go together -- progressive!!!!
% cw_left(+)  and ccw_right(-) go together -- regressive!!!!!
sym_conditions = [];

grouped_conditions{1}.name = '30 Degree Standard Phi Full Field'; % OKAY
grouped_conditions{1}.tf = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100];
grouped_conditions{1}.speed = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100]*8;
grouped_conditions{1}.list = {[1,2],...
                              [3,4],...
                              [5,6],...
                              [7,8],...
                              [9,10],...
                              [11,12],...
                              [13,14],...
                              [15,16],...
                              [17,18],...
                              [19,20]};

grouped_conditions{2}.name = '30 Degree Standard Phi Progressive Motion'; % OKAY
grouped_conditions{2}.tf = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100];
grouped_conditions{2}.speed = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100]*8;
grouped_conditions{2}.direction = 'Progressive';
grouped_conditions{2}.list = {[41,22],... % DEFINITELY FIXED
                              [43,24],...
                              [45,26],...
                              [47,28],...
                              [49,30],...
                              [51,32],...
                              [53,34],...
                              [55,36],...
                              [57,38],...
                              [59,40]};
%                           {[22,41],...
%                               [24,43],...
%                               [26,45],...
%                               [28,47],...
%                               [30,49],...
%                               [32,51],...
%                               [34,53],...
%                               [36,55],...
%                               [38,57],...
%                               [40,59]};

grouped_conditions{3}.name = '30 Degree Standard Phi Regressive Motion'; % OKAY
grouped_conditions{3}.tf = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100];
grouped_conditions{3}.speed = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100]*8;
grouped_conditions{3}.direction = 'Regressive';
grouped_conditions{3}.list = {[21,42],... % DEFINITELY FIXED
                              [23,44],...
                              [25,46],...
                              [27,48],...
                              [29,50],...
                              [31,52],...
                              [33,54],...
                              [35,56],...
                              [37,58],...
                              [39,60]};
                          
%                             {[42,21],... 
%                               [44,23],...
%                               [46,25],...
%                               [48,27],...
%                               [50,29],...
%                               [52,31],...
%                               [54,33],...
%                               [56,35],...
%                               [58,37],...
%                               [60,39]};

grouped_conditions{4}.name = '60 Degree Standard Phi Full Field'; % OKAY
grouped_conditions{4}.tf = [.5 4 8 25 75]; 
grouped_conditions{4}.speed = [.5 4 8 25 75]*16;
grouped_conditions{4}.list = {[61,62],...
                              [63,64],...
                              [65,66],...
                              [67,68],...
                              [69,70]};

grouped_conditions{5}.name = '60 Degree Standard Phi Progressive Motion'; %OKAY
grouped_conditions{5}.tf = [.5 4 8 25 75]; 
grouped_conditions{5}.speed = [.5 4 8 25 75]*16;
grouped_conditions{5}.direction = 'Progressive';
grouped_conditions{5}.list = {[81,72],... % FIXED FOR REAL
                              [83,74],...
                              [85,76],...
                              [87,78],...
                              [89,80]};
                          
%                              {[72,81],...
%                               [74,83],...
%                               [76,85],...
%                               [78,87],...
%                               [80,89]};

grouped_conditions{6}.name = '60 Degree Standard Phi Regressive Motion'; % OKAY
grouped_conditions{6}.tf = [.5 4 8 25 75]; 
grouped_conditions{6}.speed = [.5 4 8 25 75]*16;
grouped_conditions{6}.direction = 'Regressive';
grouped_conditions{6}.list = {[71,82],... % FIXED FOR REAL
                              [73,84],...
                              [75,86],...
                              [77,88],...
                              [79,90]};
                             
%                              {[82,71],...
%                               [84,73],...
%                               [86,75],...
%                               [88,77],...
%                               [90,79]};                          

grouped_conditions{7}.name = '60 Degree Reverse Phi Full Field'; % OKAY
grouped_conditions{7}.tf = [.5 4 8 25 75]; 
grouped_conditions{7}.speed = [.5 4 8 25 75]*16;
grouped_conditions{7}.list = {[91,92],...
                              [93,94],...
                              [95,96],...
                              [97,98],...
                              [99,100]};

grouped_conditions{8}.name = '60 Degree Standard Phi Progressive Motion'; % OKAY
grouped_conditions{8}.tf = [.5 4 8 25 75]; 
grouped_conditions{8}.speed = [.5 4 8 25 75]*16;
grouped_conditions{8}.direction = 'Progressive';
grouped_conditions{8}.list = {[111,102],...
                              [113,104],...
                              [115,106],...
                              [117,108],...
                              [119,110]};
                          
%                           {[102,111],...
%                               [104,113],...
%                               [106,115],...
%                               [108,117],...
%                               [110,119]};

grouped_conditions{9}.name = '60 Degree Standard Phi Regressive Motion'; % OKAY
grouped_conditions{9}.tf = [.5 4 8 25 75]; 
grouped_conditions{9}.speed = [.5 4 8 25 75]*16;
grouped_conditions{9}.direction = 'Regressive';
grouped_conditions{9}.list = {[101,112],... % fixed
                              [103,114],...
                              [105,116],...
                              [107,118],...
                              [109,120]};
                          
%                           {[112,101],... % fixed
%                               [114,103],...
%                               [116,105],...
%                               [118,107],...
%                               [120,109]};
% 
% 
