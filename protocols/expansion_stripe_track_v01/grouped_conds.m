%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

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

grouped_conditions{1}.name = 'Unidirectional Motion';
grouped_conditions{1}.tf = 0;
grouped_conditions{1}.x_axis = [1 2];
grouped_conditions{1}.x_text = {'B2F','F2B'};
grouped_conditions{1}.x_text_2 = {'reg','prog'};
grouped_conditions{1}.x_label = 'Direction';
grouped_conditions{1}.list = ...
                       {[1,2];...
                        [3,4]};

grouped_conditions{2}.name = 'Low Contrast Optomotor';
grouped_conditions{2}.tf = 0;
grouped_conditions{2}.x_axis = [.06 .24];
grouped_conditions{2}.x_text = {'low', 'high'};
grouped_conditions{2}.x_label = 'Contrast';
grouped_conditions{2}.list = ...
                       {[5,6];...
                        [7,8]};

grouped_conditions{3}.name = 'Reverse Phi';
grouped_conditions{3}.tf = 1;
grouped_conditions{3}.x_axis = 1;
grouped_conditions{3}.x_text = 'CW';
grouped_conditions{3}.list = ...
                       {[9,12]};

grouped_conditions{4}.name = 'Stripe Tracking';
grouped_conditions{4}.tf = 0;
grouped_conditions{4}.x_axis = [1 2 3];
grouped_conditions{4}.x_label = 'Stripe Type';
grouped_conditions{4}.x_text = {'Dark' 'Bright' 'Grating'};
grouped_conditions{4}.list = ...
                       {[11,12];... % dark stripe 3 Hz sine wave stripe track [different phase]
                        [13,14];... % bright stripe 3 Hz sine wave stripe track [different phase]
                        [15,16]};                   