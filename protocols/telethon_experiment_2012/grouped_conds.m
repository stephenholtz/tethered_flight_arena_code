% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

% CONDITION 17 IS A DUPLICATE...
%

%% 
sym_conditions = ...
                       {[1,2];...   % b2f L [R]
                        [3,4];...   % f2b R [L]
                        [5,6];...   % .06 low contrast rot CW [CCW]
                        [7,8];...   % .24 low contrast rot CW [CCW]
                        [9,10];...  % reverse phi CW [CCW]
                        [11,12];... % dark stripe 3 Hz sine wave stripe track [different phase]
                        [13,14];... % bright stripe 3 Hz sine wave stripe track [different phase]
                        [15,16]};   % square wave grating 3 Hz sine wave stripe track [different phase]

grouped_conditions{1}.name = 'low contrast';
grouped_conditions{1}.tf = 0;
grouped_conditions{1}.x_axis = [.06 .24];
grouped_conditions{1}.list = ...
                       {[5,6];...
                        [7,8]};
