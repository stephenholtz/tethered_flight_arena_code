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
% 1-13 are 2.5 seconds, 14 is 10 seconds, 15 is 5 seconds.
% 01 - Full Field Rotation
% 02 - Full Field Expansion
% 03 - Lateral Flicker
% 04 - Low Contrast Rotation
% 05 - Reverse-Phi Rotation
% 06 - Stripe Oscillation ('94 degree' stripe/ grating)
% 07 - Regressive Motion
% 08 - Progressive Motion
% 10 - ON Motion
% 11 - OFF Motion
% 12 - Optic Flow Oscillation (diff flow fields)
% 13 - Contrast Nulling (velocity nulling)
% 14 - Stripe Fixation ()
% 15 - Small Object Oscillation (NEW)

% 01 - Full Field Rotation
grouped_conditions{1}.name = 'low contrast';
grouped_conditions{1}.tf = 0;
grouped_conditions{1}.x_axis = [.06 .24];
grouped_conditions{1}.list = ...
                       {[5,6];...
                        [7,8]};

grouped_conditions{1}.name = 'low contrast';
grouped_conditions{1}.tf = 0;
grouped_conditions{1}.x_axis = [.06 .24];
grouped_conditions{1}.list = ...
                       {[5,6];...
                        [7,8]};
