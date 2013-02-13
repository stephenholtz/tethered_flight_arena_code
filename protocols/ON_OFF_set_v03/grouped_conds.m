%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

sym_conditions = [];

% Minimal motion: ON-ON (all CW, CCW)
grouped_conditions(1).bar_type      = 'ON-ON';
grouped_conditions(1).loc           = [1 2];
grouped_conditions(1).conds         = {[1,3],...
                                       [4,2]};
% Minimal motion: ON-OFF
grouped_conditions(2).bar_type      = 'ON-OFF';
grouped_conditions(2).loc           = [1 2];
grouped_conditions(2).conds         = 
% Minimal motion: OFF-ON
grouped_conditions(3).bar_type      = 'OFF-ON';
grouped_conditions(3).loc           = [1 2];
grouped_conditions(3).conds         = 
% Minimal motion: OFF-OFF
grouped_conditions(4).bar_type      = 'OFF-OFF';
grouped_conditions(4).loc           = [1 2];
grouped_conditions(4).conds         = 
% ON/OFF Edges (from rear)
grouped_conditions(5).bar_type      = 'ON/OFF';
grouped_conditions(5).pos_start     = 180;
grouped_conditions(5).conds         = {[49,50],...
                                       [53,54]};
% ON/OFF Edges (from center)
grouped_conditions(6).bar_type      = 'ON/OFF';
grouped_conditions(6).pos_start     = 0;
grouped_conditions(6).conds         = {[52,51],...
                                       [56,55]};
% ON Sweep (from rear)
grouped_conditions(7).bar_type      = 'ON';
grouped_conditions(7).speed         = [100 220];
grouped_conditions(7).conds         = {[57,58],...
                                       [61,62]};
% OFF Sweep (from rear)
grouped_conditions(8).bar_type      = 'OFF';
grouped_conditions(8).speed         = [100 220];
grouped_conditions(8).conds         = {[59,60],...
                                       [63,64]};
% tuthill ON expansion
grouped_conditions(9).bar_type      = 'ON';
grouped_conditions(9).speed         = 3*3.75;
grouped_conditions(9).conds         = {[65,66]};
% tuthill OFF expansion
grouped_conditions(10).bar_type      = 'OFF';
grouped_conditions(10).speed         = 3*3.75;
grouped_conditions(10).conds         = {[67,68]};
% tuthill ON sawtooth
grouped_conditions(11).bar_type      = 'ON';
grouped_conditions(11).speed         = 3*3.75;
grouped_conditions(11).conds         = {[69,70]};
% tuthill OFF sawtooth
grouped_conditions(12).bar_type      = 'OFF';
grouped_conditions(12).speed         = 3*3.75;
grouped_conditions(12).conds         = {[71,72]};