%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
% This file is used to hopefully automate comparisons later on
sym_conditions = [];

% % ON/OFF Edges (from rear)
% grouped_conditions(1).bar_type      = 'ON/OFF';
% grouped_conditions(1).pos_start     = 180;
% grouped_conditions(1).conds         = {[1,2],...
%                                        [5,6]};
% % ON/OFF Edges (from center)
% grouped_conditions(2).bar_type      = 'ON/OFF';
% grouped_conditions(2).pos_start     = 0;
% grouped_conditions(2).conds         = {[4,3],...
%                                        [8,7]};
% ON Sweep (from rear)
grouped_conditions(3).bar_type      = 'ON';
grouped_conditions(3).speed         = [100 220];
grouped_conditions(3).conds         = {[ 1,2],...
                                       [5,6]};
% OFF Sweep (from rear)
grouped_conditions(4).bar_type      = 'OFF';
grouped_conditions(4).speed         = [100 220];
grouped_conditions(4).conds         = {[3,4],...
                                       [7,8]};
% % Steady state sweep: ON-ON               
% grouped_conditions(5).bar_type      = 'ON-ON';
% grouped_conditions(5).speed         = [100 220];
% grouped_conditions(5).conds         = {[17,18],...
%                                        [25,26]};
% % Steady state sweep: ON-OFF
% grouped_conditions(6).bar_type      = 'ON-OFF';
% grouped_conditions(6).speed         = [100 220];
% grouped_conditions(6).conds         = {2+[17,18],...
%                                        2+[25,26]};
% % Steady state sweep: OFF-ON
% grouped_conditions(7).bar_type      = 'OFF-ON';
% grouped_conditions(7).speed         = [100 220];
% grouped_conditions(7).conds         = {4+[17,18],...
%                                        4+[25,26]};
% % Steady state sweep: OFF-OFF
% grouped_conditions(8).bar_type      = 'OFF-OFF';
% grouped_conditions(8).speed         = [100 220];
% grouped_conditions(8).conds         = {6+[17,18],...
%                                        6+[25,26]};
% tuthill rotation
grouped_conditions(9).bar_type      = 'lam_30_grating';
grouped_conditions(9).speed         = [15 30];
grouped_conditions(9).conds         = {[9,10],...
                                       [11,12],...
                                       [13,14]};
% tuthill rotation opposed
grouped_conditions(10).bar_type      = 'Opposed ON/OFF';
grouped_conditions(10).speed         = [4 24 72]*3.75;
grouped_conditions(10).conds         = {[15,16]};
% tuthill ON expansion
grouped_conditions(11).bar_type      = 'ON';
grouped_conditions(11).speed         = 3*3.75;
grouped_conditions(11).conds         = {[17,18]};
% tuthill OFF expansion
grouped_conditions(12).bar_type     = 'OFF';
grouped_conditions(12).speed        = 3*3.75;
grouped_conditions(12).conds        = {[19,20]};
% tuthill ON sawtooth
grouped_conditions(13).bar_type     = 'ON';
grouped_conditions(13).speed        = 3*3.75;
grouped_conditions(13).conds        = {[21,22]};
% tuthill OFF sawtooth
grouped_conditions(14).bar_type     = 'OFF';
grouped_conditions(14).speed        = 3*3.75;
grouped_conditions(14).conds        = {[23,24]};
% closed loop stripe fixation
grouped_conditions(15).bar_type     = 'dark';
grouped_conditions(15).speed        = -12;
grouped_conditions(15).conds        = {25};
