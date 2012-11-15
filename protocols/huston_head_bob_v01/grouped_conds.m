% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on
%

%% 
sym_conditions = {[1:2:148; 2:2:148]};

% The telethon experiment has several condition groups (divided as in the manuscript)
% Most are 2.5 seconds, 9-10 are 3 seconds, 13 is 10 seconds, 14 is 5 seconds.
% 01 - Full Field Rotation
% 02 - Full Field Expansion
% 03 - Lateral Flicker
% 04 - Low Contrast Rotation
% 05 - Reverse-Phi Rotation
% 06 - Stripe Oscillation ('94 degree' stripe/ grating)
% 07 - Regressive Motion
% 08 - Progressive Motion
% 09 - ON/OFF Expansion
% 10 - ON/OFF Sawtooth
% 11 - Optic Flow Oscillation (diff flow fields)
% 12 - Velocity Nulling (Contrast Nulling)
% 13 - Stripe Fixation (Interspersed 3 second and 10 second conditions)
% 14 - Small Object Oscillation (NEW)
% 15 - Coherent Motion (Testing Section...)

% 01 - Full Field Rotation - DONE
%
grouped_conditions{1}.name = 'Full Field Rotation';
grouped_conditions{1}.lam = [30 30 30 30 60 60 60 60 90 90 90 90];
grouped_conditions{1}.tf =  [.5 3 9 18 .25 1.5 4.5 9 .17 1 3 6];
grouped_conditions{1}.mc =  [1 1 1 1 1 1 1 1];
grouped_conditions{1}.dps = [15 90 270 540 15 90 270 540 15 90 270 540];
grouped_conditions{1}.list = ...
                       {[47,48];...% 30
                        [49,50];...
                        [51,52];...
                        [53,54];...
                        ...
                        [31,32];...% 60
                        [33,34];...
                        [35,36];...
                        [37,38];...
                        ...
                        [55,56];...% 90
                        [57,58];...
                        [59,60];...
                        [61,62]};

% 02 - Full Field Expansion - DONE
%
grouped_conditions{2}.name = 'Full Field Expansion';
grouped_conditions{2}.lam = [30 30];
grouped_conditions{2}.tf =  [1 9];
grouped_conditions{2}.mc =  [1 1];
grouped_conditions{2}.dps = [15 270];
grouped_conditions{2}.list = ...
                       {[63,64];...% 30
                        [65,66]};

% 03 - Lateral Flicker - DONE
%
grouped_conditions{3}.name = 'Lateral Flicker';
grouped_conditions{3}.lam = [30 30];
grouped_conditions{3}.tf =  [4 4];
grouped_conditions{3}.mc =  [1 1];
grouped_conditions{3}.list = ...
                       {[137,138]};
                    
% 04 - Low Contrast Rotation - DONE
%
grouped_conditions{4}.name = 'Low Contrast Rotation';
grouped_conditions{4}.lam = [22.5 22.5 22.5 22.5];
grouped_conditions{4}.mc =  [.23 .07 .06 .24];
grouped_conditions{4}.tf =  [8 8 8 8];
grouped_conditions{4}.dps = [180 180 180 180];
grouped_conditions{4}.list = ...
                       {[39,40];...% 
                        [41,42];...
                        [43,44];...
                        [45,46]};

% 05 - Reverse-Phi Rotation - DONE
%
grouped_conditions{5}.name = 'Reverse-Phi Rotation';
grouped_conditions{5}.lam = [30 30 30 90 90 90];
grouped_conditions{5}.mc =  [1 1 1 1 1 1];
grouped_conditions{5}.tf =  [1 3 9 .33 3 9];
grouped_conditions{5}.dps = [30 90 270 30 90 270];
grouped_conditions{5}.list = ...
                       {[75,76];...% 22.5
                        [77,78];...
                        [79,80];...
                        [81,82];...
                        [83,84];...
                        [85,86]};

% 06 - Stripe Oscillation ('94 degree' stripe/ grating) - DONE
%
grouped_conditions{6}.name = 'Stripe Oscillation';
grouped_conditions{6}.bar_size =  [32 32 32 32 32 32];
grouped_conditions{6}.lam = [30 30 30 30 30 30 30 30 30 30 30 30];
grouped_conditions{6}.mc =  [1 1 1 1 1 1 1 1 1 1 1 1];
grouped_conditions{6}.hz_osc =  [1 3 5 1 3 5 1 3 5];
grouped_conditions{6}.tf = [0 0 0 0 0 0 0 0 0]; % fill in...
grouped_conditions{6}.dps = [0 0 0 0 0 0 0 0 0]; % fill in...
grouped_conditions{6}.type = {'Dark Stripe','Dark Stripe','Dark Stripe','Bright Stripe','Bright Stripe','Bright Stripe','Grating','Grating','Grating'};
grouped_conditions{6}.list = ...
                       {[87,88];...% Dark on Bright
                        [89,90];...
                        [91,92];...
                        [93,94];...% Bright on Dark
                        [95,96];...
                        [97,98];...
                        [99,100];...% Grating
                        [101,102];...
                        [103,104]};

% 07 - Regressive Motion - DONE
grouped_conditions{7}.name = 'Regressive Motion';
grouped_conditions{7}.lam = [30 30 30]; %double check
grouped_conditions{7}.mc =  [1 1 1];
grouped_conditions{7}.tf =  [1 3 9];
grouped_conditions{7}.dps = [30 90 360];
grouped_conditions{7}.list = ...
                       {[125,126];...
                        [129,130];...
                        [133,134]};

% 08 - Progressive Motion - DONE
grouped_conditions{8}.name = 'Progressive Motion';
grouped_conditions{8}.lam = [30 30 30]; %double check
grouped_conditions{8}.mc =  [1 1 1 1 1 1];
grouped_conditions{8}.tf =  [1 3 9];
grouped_conditions{8}.dps = [30 90 360];
grouped_conditions{8}.list = ...
                       {[127,128];...% 22.5
                        [131,132];...
                        [135,136]};

% 09 - ON/OFF Expansion - DONE
grouped_conditions{9}.name = 'ON OFF Expansion';
grouped_conditions{9}.lam = [60 60];
grouped_conditions{9}.mc =  [1 1];
grouped_conditions{9}.tf =  [1/3 1/3];
grouped_conditions{9}.type =  {'on','off'};
grouped_conditions{9}.list = ...
                       {[117,118];...
                        [119,120]};

% 10 - ON/OFF Sawtooth - DONE
grouped_conditions{10}.name = 'ON OFF Sawtooth';
grouped_conditions{10}.lam = [60 60]; % not useful in this context
grouped_conditions{10}.tf =  [1/3 1/3];
grouped_conditions{10}.list = ...
                       {[121,122];...
                        [123,124]};

% 11 - Optic Flow Oscillation (diff flow fields) - DONE
grouped_conditions{11}.name = 'Optic Flow Oscillation';
grouped_conditions{11}.mc =  [1 1 1 1 1 1 1];
grouped_conditions{11}.tf =  [1 1 1 1 1 1 1];
grouped_conditions{11}.type =  {'Lift','Pitch','Roll','Sideslip','Thrust','Yaw'};
grouped_conditions{11}.list = ...
                       {[105,106];...
                        [107,108];...
                        [109,110];...
                        [111,112];...
                        [113,114];...
                        [115,116]};

% 12 - Velocity Nulling (Contrast Nulling) - DONE
grouped_conditions{12}.name = 'Velocity Nulling';
grouped_conditions{12}.lam = [22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5];
grouped_conditions{12}.mc =  [.09 .27 .45 .09 .27 .45 .09 .27 .45 .09 .27 .45 .09 .27 .45];
grouped_conditions{12}.tf =  [.3 .3 .3 1.3 1.3 1.3 5.3 5.3 5.3 10.6 10.6 10.6 16 16 16];
grouped_conditions{12}.dps = [6.75 6.75 6.75 29.25 29.25 29.25 119.25 119.25 119.25 238.5 238.5 238.5 360 360 360]; % look up
grouped_conditions{12}.list = ...
                       {[1,2];...
                        [3,4];...
                        [5,6];...
                        [7,8];...
                        [9,10];...
                        [11,12];...
                        [13,14];...
                        [15,16];...
                        [17,18];...
                        [19,20];...
                        [21,22];...
                        [23,24];...
                        [25,26];...
                        [27,28];...
                        [27,28];...
                        [29,30]};

% 13 - Stripe Fixation - DONE
grouped_conditions{13}.name =   'Stripe Fixation';
grouped_conditions{13}.pix  =   [8 8];
grouped_conditions{13}.mc   =   [1 1];
grouped_conditions{13}.time =   [10 3];
grouped_conditions{13}.list = ...
                       {147;...
                        -1};

% 14 - Small Object Oscillation - DONE
grouped_conditions{14}.name = 'Small Object Oscillation';
grouped_conditions{14}.pix = [4 4 4 4];
grouped_conditions{14}.bar_size =  [20 8 20 8];
grouped_conditions{14}.pos =  [33 33 49 49];
grouped_conditions{14}.pos_deg =  [45 45 0 0];
grouped_conditions{14}.mc =  [1 1 1 1];
grouped_conditions{14}.tf =  [0 0 0 0];
grouped_conditions{14}.list = ...
                       {[143,146];... % 33
                        [139,142];... 
                        [144,145];... % 49
                        [140,141]};

% 15 - Coherent Motion (Testing Section) - NOT INCLUDED!
grouped_conditions{15}.name = 'Coherent Motion';
grouped_conditions{15}.coherence = [15 30 45 60];
grouped_conditions{15}.mc =  [1 1 1 1];
grouped_conditions{15}.gain =  [24 24 24 24];
grouped_conditions{15}.list = ...
                       {[67,68];...
                        [69,70];...
                        [71,72];...                       
                        [73,74]};
