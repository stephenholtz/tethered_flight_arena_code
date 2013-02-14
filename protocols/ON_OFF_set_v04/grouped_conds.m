%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
% This file is used to hopefully automate comparisons later on
sym_conditions = [];

% Minimal motion: ON-ON (all CW, CCW)
grouped_conditions(1).bar_type      = 'ON-ON';
grouped_conditions(1).loc           = [1 2 1 2];
grouped_conditions(1).len           = [80 80 160 160];
grouped_conditions(1).conds         = {[1,2],...
                                       [9,10],...
                                       [17,18],...
                                       [25,26]};
% Minimal motion: ON-OFF
grouped_conditions(2).bar_type      = 'ON-OFF';
grouped_conditions(2).loc           = [1 2];
grouped_conditions(2).conds         = {2+[1,2],...
                                       2+[9,10],...
                                       2+[17,18],...
                                       2+[25,26]};
% Minimal motion: OFF-ON
grouped_conditions(3).bar_type      = 'OFF-ON';
grouped_conditions(3).loc           = [1 2];
grouped_conditions(3).conds         = {4+[1,2],...
                                       4+[9,10],...
                                       4+[17,18],...
                                       4+[25,26]};
% Minimal motion: OFF-OFF
grouped_conditions(4).bar_type      = 'OFF-OFF';
grouped_conditions(4).loc           = [1 2];
grouped_conditions(4).conds         = {6+[1,2],...
                                       6+[9,10],...
                                       6+[17,18],...
                                       6+[25,26]};
% ON/OFF Edges (from rear)
grouped_conditions(5).bar_type      = 'ON/OFF';
grouped_conditions(5).pos_start     = 180;
grouped_conditions(5).conds         = {[33,34],...
                                       [37,38]};
% ON/OFF Edges (from center)
grouped_conditions(6).bar_type      = 'ON/OFF';
grouped_conditions(6).pos_start     = 0;
grouped_conditions(6).conds         = {[36,35],...
                                       [40,41]};
% ON Sweep (from rear)
grouped_conditions(7).bar_type      = 'ON';
grouped_conditions(7).speed         = [100 220];
grouped_conditions(7).conds         = {[41,42],...
                                       [45,46]};
% OFF Sweep (from rear)
grouped_conditions(8).bar_type      = 'OFF';
grouped_conditions(8).speed         = [100 220];
grouped_conditions(8).conds         = {[43,44],...
                                       [47,48]};
% tuthill ON expansion
grouped_conditions(9).bar_type      = 'ON';
grouped_conditions(9).speed         = 3*3.75;
grouped_conditions(9).conds         = {[49,50]};
% tuthill OFF expansion
grouped_conditions(10).bar_type      = 'OFF';
grouped_conditions(10).speed         = 3*3.75;
grouped_conditions(10).conds         = {[51,52]};
% tuthill ON sawtooth
grouped_conditions(11).bar_type      = 'ON';
grouped_conditions(11).speed         = 3*3.75;
grouped_conditions(11).conds         = {[55,56]};
% tuthill OFF sawtooth
grouped_conditions(12).bar_type      = 'OFF';
grouped_conditions(12).speed         = 3*3.75;
grouped_conditions(12).conds         = {[53,54]};