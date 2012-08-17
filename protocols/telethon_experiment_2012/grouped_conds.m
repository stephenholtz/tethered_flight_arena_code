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
% 1-12 are 2.5 seconds, 13 is 10 seconds, 14 is 5 seconds.
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
% 13 - Stripe Fixation (Both interspersed and the 10 second)
% 14 - Small Object Oscillation (NEW)

% 01 - Full Field Rotation
%
grouped_conditions{1}.name = 'Full Field Rotation';
grouped_conditions{1}.lam = [30 30 30 30 60 60 60 60 90 90 90 90];
grouped_conditions{1}.tf =  [.5 3 9 18 .25 1.5 4.5 9 .17 1 3 6];
grouped_conditions{3}.mc =  [1 1 1 1 1 1 1 1 1 1 1 1];
grouped_conditions{1}.dps = [15 90 270 540 15 90 270 540 15 90 270 540];
grouped_conditions{1}.list = ...
                       {[47,48];...% 30
                        [49,50];...
                        [51,52];...
                        [53,54];...
                        [55,56];...% 60
                        [57,58];...
                        [59,60];...
                        [61,62];...
                        [63,64];...% 90
                        [65,67];...
                        [68,69];...
                        [70,71]};

% 02 - Full Field Expansion
%
grouped_conditions{2}.name = 'Full Field Expansion';
grouped_conditions{2}.lam = [30 30];
grouped_conditions{2}.tf =  [1 9];
grouped_conditions{3}.mc =  [1 1];
grouped_conditions{2}.dps = [15 270];
grouped_conditions{2}.list = ...
                       {[72,73];...% 30
                        [74,75]};
                    
% 04 - Low Contrast Rotation
%
grouped_conditions{4}.name = 'Low Contrast Rotation';
grouped_conditions{4}.lam = [22.5 22.5 22.5 22.5];
grouped_conditions{4}.mc =  [.23 .07 .06 .24];
grouped_conditions{4}.tf =  [8 8 8 8];
grouped_conditions{4}.dps = [180 180 180 180];
grouped_conditions{4}.list = ...
                       {[72,73];...% 22.5
                        [74,75];...
                        [76,77];...
                        [78,79]};
                    
% 05 - Reverse-Phi Rotation
%
grouped_conditions{5}.name = 'Reverse-Phi Rotation';
grouped_conditions{5}.lam = [30 30 30 90 90 90];
grouped_conditions{5}.mc =  [1 1 1 1 1 1];
grouped_conditions{5}.tf =  [1 3 9 .33 3 9]; % maybe messed up...
grouped_conditions{5}.dps = [30 90 270 30 90 270];
grouped_conditions{5}.list = ...
                       {[80,81];...% 22.5
                        [82,83];...
                        [84,85];...
                        [82,83];...
                        [84,85];...
                        [86,87]};

% 06 - Stripe Oscillation ('94 degree' stripe/ grating)
%
grouped_conditions{6}.name = 'Stripe Oscillation';
grouped_conditions{6}.bar_size =  [32 32 32 32 32 32];
grouped_conditions{6}.name = 'Reverse-Phi Rotation';
grouped_conditions{6}.lam = [30 30 30 30 30 30 30 30 30 30 30 30];
grouped_conditions{6}.mc =  [1 1 1 1 1 1 1 1 1 1 1 1];
grouped_conditions{6}.hz_osc =  [1 3 5 1 3 5 1 3 5];
grouped_conditions{6}.tf = [0 0 0 0 0 0 0 0 0]; % fill in...
grouped_conditions{6}.dps = [0 0 0 0 0 0 0 0 0]; % fill in...
grouped_conditions{6}.type = [1 1 1 1 2 2 2 2 3 3 3]; %
grouped_conditions{6}.list = ...
                       {[80,81];...% Dark on Bright
                        [82,83];...
                        [84,85];...
                        [82,83];...
                        [84,85];...% Bright on Dark
                        [82,83];...
                        [84,85];...
                        [82,83];...
                        [82,83];...% Grating
                        [84,85];...
                        [82,83];...                        
                        [86,87]};

% 07 - Regressive Motion
grouped_conditions{7}.name = 'Regressive Motion';
grouped_conditions{7}.lam = [30 30 30]; %double check
grouped_conditions{7}.mc =  [1 1 1];
grouped_conditions{7}.tf =  [1 3 9];
grouped_conditions{7}.dps = [30 90 360];
grouped_conditions{7}.list = ...
                       {[80,81];...% 22.5
                        [82,83];...
                        [86,87]};

% 08 - Progressive Motion
grouped_conditions{8}.name = 'Progressive Motion';
grouped_conditions{8}.lam = [30 30 30]; %double check
grouped_conditions{8}.mc =  [1 1 1 1 1 1];
grouped_conditions{8}.tf =  [1 3 9];
grouped_conditions{8}.dps = [30 90 360];
grouped_conditions{8}.list = ...
                       {[80,81];...% 22.5
                        [82,83];...
                        [86,87]};

% 09 - ON/OFF Expansion
grouped_conditions{9}.name = 'ON/OFF Expansion';
grouped_conditions{9}.lam = [0 0]; % not really...
grouped_conditions{9}.mc =  [1 1]; % not really...
grouped_conditions{9}.tf =  [1 3]; % bad in this context...
grouped_conditions{9}.dps = [30 90]; % look up
grouped_conditions{9}.list = ...
                       {[80,81];...
                        [86,87]};

% 10 - ON/OFF Sawtooth
grouped_conditions{10}.name = 'ON/OFF Sawtooth';
grouped_conditions{10}.lam = [0 0]; % not useful in this context
grouped_conditions{10}.mc =  [1 1]; % not useful in this context
grouped_conditions{10}.tf =  [1 3]; % bad in this context...
grouped_conditions{10}.dps = [30 90]; % look up
grouped_conditions{10}.list = ...
                       {[80,81];...
                        [86,87]};

% 11 - Optic Flow Oscillation (diff flow fields)
grouped_conditions{11}.name = 'Optic Flow Oscillation';
grouped_conditions{11}.mc =  [1 1 1 1 1 1 1];
grouped_conditions{11}.tf =  [1 1 1 1 1 1 1];
grouped_conditions{11}.type =  ['Lift','Pitch','Roll','Sideslip','Thrust','Yaw'];
grouped_conditions{11}.list = ...
                       {[80,81];...
                        [82,83];...
                        [82,83];...
                        [82,83];...
                        [82,83];...                        
                        [86,87]};
                    
% 12 - Velocity Nulling (Contrast Nulling)
grouped_conditions{12}.name = 'Velocity Nulling';
grouped_conditions{12}.lam = [22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5 22.5];
grouped_conditions{12}.mc =  [.09 .09 .09 .09 .27 .27 .27 .27 .45 .45 .45 .45];
grouped_conditions{12}.tf =  [3 1.3 5.3 10.6 16 3 1.3 5.3 10.6 16 3 1.3 5.3 10.6 16]; % bad in this context...
grouped_conditions{12}.dps = []; % look up
grouped_conditions{12}.list = ...
                       {[80,81];...
                        [86,87]};

% 13 - Stripe Fixation
grouped_conditions{13}.name =   'Stripe Fixation';
grouped_conditions{13}.pix  =   [8 8];
grouped_conditions{13}.mc   =   [1 1];
grouped_conditions{13}.time =   [10 3];
grouped_conditions{13}.list = ...
                       {1;...
                        2};

% 14 - Small Object Oscillation
grouped_conditions{12}.name = 'Small Object Oscillation';
grouped_conditions{12}.pix = [4 4 4 4];
grouped_conditions{12}.bar_size =  [8 8 20 20];
grouped_conditions{12}.pos =  [45 45 0 0];
grouped_conditions{12}.mc =  [1 1 1 1];
grouped_conditions{12}.tf =  [3 1.3 5.3 10.6 16 3 1.3 5.3 10.6 16 3 1.3 5.3 10.6 16]; % bad in this context...
grouped_conditions{12}.dps = []; % look up
grouped_conditions{12}.list = ...
                       {[80,81];...
                        [86,87]};