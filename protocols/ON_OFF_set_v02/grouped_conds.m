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

% Minimal motion: ON 44ms (all CW, CCW)
grouped_conditions(1).bar_type      = 'ON';
grouped_conditions(1).time_between  = 44;
grouped_conditions(1).pos_degs      = 1:5;
grouped_conditions(1).conds         = {[1, 18],...
                                       [5, 14],...
                                       [9, 10],...
                                       [13, 6],...
                                       [17, 2]};
% Minimal motion: OFF 44ms
grouped_conditions(2).bar_type      = 'OFF';
grouped_conditions(2).time_between  = 44;
grouped_conditions(2).pos_degs      = 1:5;
grouped_conditions(2).conds         = {2+[1, 18],...
                                       2+[5, 14],...
                                       2+[9, 10],...
                                       2+[13, 6],...
                                       2+[17, 2]};

% Minimal motion: ON 76ms (all CW, CCW)
grouped_conditions(3).bar_type      = 'ON';
grouped_conditions(3).time_between  = 76;
grouped_conditions(3).pos_degs      = 1:5;
grouped_conditions(3).conds         = {20+[1, 18],...
                                       20+[5, 14],...
                                       20+[9, 10],...
                                       20+[13, 6],...
                                       20+[17, 2]};
% Minimal motion: OFF 76ms
grouped_conditions(4).bar_type      = 'OFF';
grouped_conditions(4).time_between  = 76;
grouped_conditions(4).pos_degs      = 1:5;
grouped_conditions(4).conds         = {22+[1, 18],...
                                       22+[5, 14],...
                                       22+[9, 10],...
                                       22+[13, 6],...
                                       22+[17, 2]};
% Minimal motion: ON 116ms (all CW, CCW)
grouped_conditions(5).bar_type      = 'ON';
grouped_conditions(5).time_between  = 116;
grouped_conditions(5).pos_degs      = 1:5;
grouped_conditions(5).conds         = {40+[1, 18],...
                                       40+[5, 14],...
                                       40+[9, 10],...
                                       40+[13, 6],...
                                       40+[17, 2]};
% Minimal motion: OFF 116ms
grouped_conditions(6).bar_type      = 'OFF';
grouped_conditions(6).time_between  = 116;
grouped_conditions(6).pos_degs      = 1:5;
grouped_conditions(6).conds         = {42+[1, 18],...
                                       42+[5, 14],...
                                       42+[9, 10],...
                                       42+[13, 6],...
                                       42+[17, 2]};
% ON/OFF Edges (from rear)
grouped_conditions(7).bar_type      = 'ON/OFF';
grouped_conditions(7).pos_start     = 180;
grouped_conditions(7).conds         = {[61,62],...
                                       [65,66]};
% ON/OFF Edges (from center)
grouped_conditions(8).bar_type      = 'ON/OFF';
grouped_conditions(8).pos_start     = 0;
grouped_conditions(8).conds         = {[64,63],...
                                       [68,67]};
% ON Sweep (from rear)
grouped_conditions(9).bar_type      = 'ON';
grouped_conditions(9).speed         = [100 220];
grouped_conditions(9).conds         = {[69,70],...
                                       [73,74]};
% OFF Sweep (from rear)
grouped_conditions(10).bar_type      = 'OFF';
grouped_conditions(10).speed         = [100 220];
grouped_conditions(10).conds         = {[71,72],...
                                       [75,76]};
% tuthill ON expansion
grouped_conditions(11).bar_type      = 'ON';
grouped_conditions(11).speed         = 3*3.75;
grouped_conditions(11).conds         = {[77,78]};
% tuthill OFF expansion
grouped_conditions(12).bar_type      = 'OFF';
grouped_conditions(12).speed         = 3*3.75;
grouped_conditions(12).conds         = {[79,80]};
% tuthill ON sawtooth
grouped_conditions(13).bar_type      = 'ON';
grouped_conditions(13).speed         = 3*3.75;
grouped_conditions(13).conds         = {[83,84]};
% tuthill OFF sawtooth
grouped_conditions(14).bar_type      = 'OFF';
grouped_conditions(14).speed         = 3*3.75;
grouped_conditions(14).conds         = {[81,82]};
                                   