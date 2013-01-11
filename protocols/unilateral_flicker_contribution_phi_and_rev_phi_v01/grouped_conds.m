%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on
%
% For unilateral stimuli (all in terms of cw!):
% ccw_left(-) and cw_right(+)  go together -- progressive!!!!
% cw_left(+)  and ccw_right(-) go together -- regressive!!!!!

sym_conditions = [];
%%
% Coherent 30 Degree Motion (both halves)
grouped_conditions{1}.name = 'Both Halves 30 Degree Optomotor';
grouped_conditions{1}.flicker_type = 'none';
grouped_conditions{1}.tf = [.5 4 8];
grouped_conditions{1}.speed = [.5 4 8]*8;
grouped_conditions{1}.list = {[193,194],...
                              [195,196],...
                              [197,198]};

% Coherent 30 Degree Reverse Phi (both halves)
grouped_conditions{2}.name = 'Both Halves Reverse-Phi 30 Degree Optomotor';
grouped_conditions{2}.flicker_type = 'none';
grouped_conditions{2}.tf = [.5 4 8];
grouped_conditions{2}.speed = [.5 4 8]*8;
grouped_conditions{2}.list = {[199,200],...
                              [201,202],...
                              [203,204]};
%%                      
% Progressive 30 Degree Motion
grouped_conditions{3}.name = 'Progressive 30 Degree';
grouped_conditions{3}.flicker_type = 'none';
grouped_conditions{3}.tf = [.5 4 8];
grouped_conditions{3}.speed = [.5 4 8]*8;
grouped_conditions{3}.list = {[1,2],...
                              [3,4],...
                              [5,6]};

% Regressive 30 Degree Motion
grouped_conditions{4}.name = 'Regressive 30 Degree';
grouped_conditions{4}.flicker_type = 'none';
grouped_conditions{4}.tf = [.5 4 8];
grouped_conditions{4}.speed = [.5 4 8]*8;
grouped_conditions{4}.list = {[7,8],...
                              [9,10],...
                              [11,12]};

% Progressive 30 Degree  Reverse-Phi Motion
grouped_conditions{5}.name = 'Progressive Reverse-Phi 30 Degree';
grouped_conditions{5}.flicker_type = 'none';
grouped_conditions{5}.tf = [.5 4 8];
grouped_conditions{5}.speed = [.5 4 8]*8;
grouped_conditions{5}.list = {[13,14],...
                              [15,16],...
                              [17,18]};

% Regressive 30 Degree Reverse-Phi Motion
grouped_conditions{6}.name = 'Regressive Reverse-Phi 30 Degree';
grouped_conditions{6}.flicker_type = 'none';
grouped_conditions{6}.tf = [.5 4 8];
grouped_conditions{6}.speed = [.5 4 8]*8;
grouped_conditions{6}.list = {[19,20],...
                              [21,22],...
                              [23,24]};

% Progressive 30 Degree Motion Full Field Flicker
grouped_conditions{7}.name = 'Progressive 30 Degree Full Field Flicker';
grouped_conditions{7}.flicker_type = 'full_field';
grouped_conditions{7}.tf = [.5 4 8];
grouped_conditions{7}.speed = [.5 4 8]*8;
grouped_conditions{7}.list = {[25,26],...
                              [27,28],...
                              [29,30]};

% Regressive 30 Degree Motion Full Field Flicker
grouped_conditions{8}.name = 'Regressive 30 Degree Full Field Flicker';
grouped_conditions{8}.flicker_type = 'full_field';
grouped_conditions{8}.tf = [.5 4 8];
grouped_conditions{8}.speed = [.5 4 8]*8;
grouped_conditions{8}.list = {[31,32],...
                              [33,34],...
                              [35,36]};

% Progressive 30 Degree Reverse-Phi Motion Full Field Flicker
grouped_conditions{9}.name = 'Progressive Reverse-Phi 30 Degree Full Field Flicker';
grouped_conditions{9}.flicker_type = 'full_field';
grouped_conditions{9}.tf = [.5 4 8];
grouped_conditions{9}.speed = [.5 4 8]*8;
grouped_conditions{9}.list = {[37,38],...
                              [39,40],...
                              [41,42]};

% Regressive 30 Degree Reverse-Phi Motion Full Field Flicker
grouped_conditions{10}.name = 'Regressive Reverse-Phi 30 Degree Full Field Flicker';
grouped_conditions{10}.flicker_type = 'full_field';
grouped_conditions{10}.tf = [.5 4 8];
grouped_conditions{10}.speed = [.5 4 8]*8;
grouped_conditions{10}.list = {[43,44],...
                              [45,46],...
                              [47,48]};

% Progressive 30 Degree Motion Alt Grat Flicker
grouped_conditions{11}.name = 'Progressive 30 Degree Alt Grat Flicker';
grouped_conditions{11}.flicker_type = 'grat_flick';
grouped_conditions{11}.tf = [.5 4 8];
grouped_conditions{11}.speed = [.5 4 8]*8;
grouped_conditions{11}.list = {[49,50],...
                              [51,52],...
                              [53,54]};

% Regressive 30 Degree Motion Alt Grat Flicker
grouped_conditions{12}.name = 'Regressive 30 Degree Alt Grat Flicker';
grouped_conditions{12}.flicker_type = 'grat_flick';
grouped_conditions{12}.tf = [.5 4 8];
grouped_conditions{12}.speed = [.5 4 8]*8;
grouped_conditions{12}.list = {[55,56],...
                              [57,58],...
                              [59,60]};

% Progressive 30 Degree Reverse-Phi Motion Alt Grat Flicker
grouped_conditions{13}.name = 'Progressive Reverse-Phi 30 Degree Alt Grat Flicker';
grouped_conditions{13}.flicker_type = 'grat_flick';
grouped_conditions{13}.tf = [.5 4 8];
grouped_conditions{13}.speed = [.5 4 8]*8;
grouped_conditions{13}.list = {[61,62],...
                              [63,64],...
                              [65,66]};

% Regressive 30 Degree Reverse-Phi Motion Alt Grat Flicker
grouped_conditions{14}.name = 'Regressive Reverse-Phi 30 Degree Alt Grat Flicker';
grouped_conditions{14}.flicker_type = 'grat_flick';
grouped_conditions{14}.tf = [.5 4 8];
grouped_conditions{14}.speed = [.5 4 8]*8;
grouped_conditions{14}.list = {[67,68],...
                              [69,70],...
                              [71,72]};

% Progressive 30 Degree Motion Edge Flicker
grouped_conditions{15}.name = 'Progressive 30 Degree Edge Flicker';
grouped_conditions{15}.flicker_type = 'edge_flick';
grouped_conditions{15}.tf = [.5 4 8];
grouped_conditions{15}.speed = [.5 4 8]*8;
grouped_conditions{15}.list = {[73,74],...
                              [75,76],...
                              [77,78]};

% Regressive 30 Degree Motion Edge Flicker
grouped_conditions{16}.name = 'Regressive 30 Degree Edge Flicker';
grouped_conditions{16}.flicker_type = 'edge_flick';
grouped_conditions{16}.tf = [.5 4 8];
grouped_conditions{16}.speed = [.5 4 8]*8;
grouped_conditions{16}.list = {[79,80],...
                              [81,82],...
                              [83,84]};

% Progressive 30 Degree Reverse-Phi Motion Edge Flicker
grouped_conditions{17}.name = 'Progressive Reverse-Phi 30 Degree Edge Flicker';
grouped_conditions{17}.flicker_type = 'edge_flick';
grouped_conditions{17}.tf = [.5 4 8];
grouped_conditions{17}.speed = [.5 4 8]*8;
grouped_conditions{17}.list = {[85,86],...
                              [87,88],...
                              [89,90]};

% Regressive 30 Degree Reverse-Phi Motion Edge Flicker
grouped_conditions{18}.name = 'Regressive Reverse-Phi 30 Degree Edge Flicker';
grouped_conditions{18}.flicker_type = 'edge_flick';
grouped_conditions{18}.tf = [.5 4 8];
grouped_conditions{18}.speed = [.5 4 8]*8;
grouped_conditions{18}.list = {[91,92],...
                              [93,94],...
                              [95,96]};
%%
% Coherent 60 Degree Motion (both halves)
grouped_conditions{19}.name = 'Both Halves 60 Degree Optomotor';
grouped_conditions{19}.flicker_type = 'none';
grouped_conditions{19}.tf = [.5 4 8];
grouped_conditions{19}.speed = [.5 4 8]*16;
grouped_conditions{19}.list = {[205,206],...
                              [207,208],...
                              [209,210]};

% Coherent 60 Degree Motion (both halves)
grouped_conditions{20}.name = 'Both Halves Reverse-Phi 60 Degree Optomotor';
grouped_conditions{20}.flicker_type = 'none';
grouped_conditions{20}.tf = [.5 4 8];
grouped_conditions{20}.speed = [.5 4 8]*16;
grouped_conditions{20}.list = {[211,212],...
                              [213,214],...
                              [215,216]};
                          
%%
% Progressive 60 Degree Motion
grouped_conditions{21}.name = 'Progressive 60 Degree';
grouped_conditions{21}.flicker_type = 'none';
grouped_conditions{21}.tf = [.5 4 8];
grouped_conditions{21}.speed = [.5 4 8]*16;
grouped_conditions{21}.list = {[97,98],...
                              [99,100],...
                              [101,102]};

% Regressive 60 Degree Motion
grouped_conditions{22}.name = 'Regressive 60 Degree';
grouped_conditions{22}.flicker_type = 'none';
grouped_conditions{22}.tf = [.5 4 8];
grouped_conditions{22}.speed = [.5 4 8]*16;
grouped_conditions{22}.list = {[103,104],...
                              [105,106],...
                              [107,108]};

% Progressive 60 Degree Reverse-Phi Motion
grouped_conditions{23}.name = 'Progressive Reverse-Phi 60 Degree';
grouped_conditions{23}.flicker_type = 'none';
grouped_conditions{23}.tf = [.5 4 8];
grouped_conditions{23}.speed = [.5 4 8]*16;
grouped_conditions{23}.list = {[109,110],...
                              [111,112],...
                              [113,114]};

% Regressive 60 Degree Reverse-Phi Motion
grouped_conditions{24}.name = 'Regressive Reverse-Phi 60 Degree';
grouped_conditions{24}.flicker_type = 'none';
grouped_conditions{24}.tf = [.5 4 8];
grouped_conditions{24}.speed = [.5 4 8]*16;
grouped_conditions{24}.list = {[115,116],...
                              [117,118],...
                              [119,120]};

% Progressive 60 Degree Motion Full Field Flicker
grouped_conditions{25}.name = 'Progressive 60 Degree Full Field Flicker';
grouped_conditions{25}.flicker_type = 'full_field';
grouped_conditions{25}.tf = [.5 4 8];
grouped_conditions{25}.speed = [.5 4 8]*16;
grouped_conditions{25}.list = {[127,128],...
                              [129,130],...
                              [131,132]};

% Regressive 60 Degree Motion Full Field Flicker
grouped_conditions{26}.name = 'Regressive 60 Degree Full Field Flicker';
grouped_conditions{26}.flicker_type = 'full_field';
grouped_conditions{26}.tf = [.5 4 8];
grouped_conditions{26}.speed = [.5 4 8]*16;
grouped_conditions{26}.list = {[121,122],...
                              [123,124],...
                              [125,126]};

% Progressive 60 Degree Reverse-Phi Motion Full Field Flicker
grouped_conditions{27}.name = 'Progressive Reverse-Phi 60 Degree Full Field Flicker';
grouped_conditions{27}.flicker_type = 'full_field';
grouped_conditions{27}.tf = [.5 4 8];
grouped_conditions{27}.speed = [.5 4 8]*16;
grouped_conditions{27}.list = {[133,134],...
                              [135,136],...
                              [137,138]};

% Regressive 60 Degree Reverse-Phi Motion Full Field Flicker
grouped_conditions{28}.name = 'Regressive Reverse-Phi 60 Degree Full Field Flicker';
grouped_conditions{28}.flicker_type = 'full_field';
grouped_conditions{28}.tf = [.5 4 8];
grouped_conditions{28}.speed = [.5 4 8]*16;
grouped_conditions{28}.list = {[139,140],...
                              [141,142],...
                              [143,144]};

% Progressive 60 Degree Motion Alt Grat Flicker
grouped_conditions{29}.name = 'Progressive 60 Degree Alt Grat Flicker';
grouped_conditions{29}.flicker_type = 'grat_flick';
grouped_conditions{29}.tf = [.5 4 8];
grouped_conditions{29}.speed = [.5 4 8]*16;
grouped_conditions{29}.list = {[145,146],...
                              [147,148],...
                              [149,150]};

% Regressive 60 Degree Motion Alt Grat Flicker
grouped_conditions{30}.name = 'Regressive 60 Degree Alt Grat Flicker';
grouped_conditions{30}.flicker_type = 'grat_flick';
grouped_conditions{30}.tf = [.5 4 8];
grouped_conditions{30}.speed = [.5 4 8]*16;
grouped_conditions{30}.list = {[151,152],...
                              [153,154],...
                              [155,156]};

% Progressive 60 Degree Reverse-Phi Motion Alt Grat Flicker
grouped_conditions{31}.name = 'Progressive Reverse-Phi 60 Degree Alt Grat Flicker';
grouped_conditions{31}.flicker_type = 'grat_flick';
grouped_conditions{31}.tf = [.5 4 8];
grouped_conditions{31}.speed = [.5 4 8]*16;
grouped_conditions{31}.list = {[157,158],...
                              [159,160],...
                              [161,162]};

% Regressive 60 Degree Reverse-Phi Motion Alt Grat Flicker
grouped_conditions{32}.name = 'Regressive Reverse-Phi 60 Degree Alt Grat Flicker';
grouped_conditions{32}.flicker_type = 'grat_flick';
grouped_conditions{32}.tf = [.5 4 8];
grouped_conditions{32}.speed = [.5 4 8]*16;
grouped_conditions{32}.list = {[163,164],...
                              [165,166],...
                              [167,168]};

% Progressive 60 Degree Motion Edge Flicker
grouped_conditions{33}.name = 'Progressive 60 Degree Edge Flicker';
grouped_conditions{33}.flicker_type = 'edge_flick';
grouped_conditions{33}.tf = [.5 4 8];
grouped_conditions{33}.speed = [.5 4 8]*16;
grouped_conditions{33}.list = {[169,170],...
                              [171,172],...
                              [173,174]};

% Regressive 60 Degree Motion Edge Flicker
grouped_conditions{34}.name = 'Regressive 60 Degree Edge Flicker';
grouped_conditions{34}.flicker_type = 'edge_flick';
grouped_conditions{34}.tf = [.5 4 8];
grouped_conditions{34}.speed = [.5 4 8]*16;
grouped_conditions{34}.list = {[175,176],...
                              [177,178],...
                              [179,180]};

% Progressive 60 Degree Reverse-Phi Motion Edge Flicker
grouped_conditions{35}.name = 'Progressive Reverse-Phi 60 Degree Edge Flicker';
grouped_conditions{35}.flicker_type = 'edge_flick';
grouped_conditions{35}.tf = [.5 4 8];
grouped_conditions{35}.speed = [.5 4 8]*16;
grouped_conditions{35}.list = {[181,182],...
                              [183,184],...
                              [185,186]};

% Regressive 60 Degree Reverse-Phi Motion Edge Flicker
grouped_conditions{36}.name = 'Regressive Reverse-Phi 60 Degree Edge Flicker';
grouped_conditions{36}.flicker_type = 'edge_flick';
grouped_conditions{36}.tf = [.5 4 8];
grouped_conditions{36}.speed = [.5 4 8]*16;
grouped_conditions{36}.list = {[187,188],...
                              [189,190],...
                              [191,192]};
