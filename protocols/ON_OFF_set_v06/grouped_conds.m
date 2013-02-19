%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
% This file is used to hopefully automate comparisons later on
sym_conditions = [];

% Minimal motion: ON-ON (all CW, CCW)
grouped_conditions(1).bar_type      = 'ON-ON';
grouped_conditions(1).len           = [.5 .7];
grouped_conditions(1).conds         = {[1,2],...
                                       [9,10]};
% Minimal motion: ON-OFF
grouped_conditions(2).bar_type      = 'ON-OFF';
grouped_conditions(2).len           = [.5 .7];
grouped_conditions(2).conds         = {2+[1,2],...
                                       2+[9,10]};
% Minimal motion: OFF-ON
grouped_conditions(3).bar_type      = 'OFF-ON';
grouped_conditions(3).len           = [.5 .7];
grouped_conditions(3).conds         = {4+[1,2],...
                                       4+[9,10]};
% Minimal motion: OFF-OFF
grouped_conditions(4).bar_type      = 'OFF-OFF';
grouped_conditions(4).len           = [.5 .7];
grouped_conditions(4).conds         = {6+[1,2],...
                                       6+[9,10]};
% ON/OFF Edges (from rear)
grouped_conditions(5).bar_type      = 'ON/OFF';
grouped_conditions(5).pos_start     = 180;
grouped_conditions(5).conds         = {[17,18],...
                                       [21,22]};
% ON/OFF Edges (from center)
grouped_conditions(6).bar_type      = 'ON/OFF';
grouped_conditions(6).pos_start     = 0;
grouped_conditions(6).conds         = {[20,19],...
                                       [24,23]};
% ON Sweep (from rear)
grouped_conditions(7).bar_type      = 'ON';
grouped_conditions(7).speed         = [100 220];
grouped_conditions(7).conds         = {[25,26],...
                                       [29,30]};
% OFF Sweep (from rear)
grouped_conditions(8).bar_type      = 'OFF';
grouped_conditions(8).speed         = [100 220];
grouped_conditions(8).conds         = {[27,28],...
                                       [31,32]};
% Steady state sweep: ON-ON               
grouped_conditions(9).bar_type      = 'ON-ON';
grouped_conditions(9).speed         = [100 220];
grouped_conditions(9).conds         = {[33,34],...
                                       [41,42]};
% Steady state sweep: ON-OFF
grouped_conditions(10).bar_type      = 'ON-OFF';
grouped_conditions(10).speed         = [100 220];
grouped_conditions(10).conds         = {2+[33,34],...
                                       2+[41,42]};
% Steady state sweep: OFF-ON
grouped_conditions(11).bar_type      = 'OFF-ON';
grouped_conditions(11).speed         = [100 220];
grouped_conditions(11).conds         = {4+[33,34],...
                                       4+[41,42]};
% Steady state sweep: OFF-OFF
grouped_conditions(12).bar_type      = 'OFF-OFF';
grouped_conditions(12).speed         = [100 220];
grouped_conditions(12).conds         = {6+[33,34],...
                                       6+[41,42]};
% tuthill rotation
grouped_conditions(13).bar_type      = 'lam_30_grating';
grouped_conditions(13).speed         = [15 30];
grouped_conditions(13).conds         = {[49,50],...
                                       [51,52],...
                                       [53,54]};
% tuthill rotation opposed
grouped_conditions(14).bar_type      = 'Opposed ON/OFF';
grouped_conditions(14).speed         = [4 24 72]*3.75;
grouped_conditions(14).conds         = {[55,56]};
% tuthill ON expansion
grouped_conditions(15).bar_type      = 'ON';
grouped_conditions(15).speed         = 3*3.75;
grouped_conditions(15).conds         = {[57,58]};
% tuthill OFF expansion
grouped_conditions(16).bar_type     = 'OFF';
grouped_conditions(16).speed        = 3*3.75;
grouped_conditions(16).conds        = {[59,60]};
% tuthill ON sawtooth
grouped_conditions(17).bar_type     = 'ON';
grouped_conditions(17).speed        = 3*3.75;
grouped_conditions(17).conds        = {[61,62]};
% tuthill OFF sawtooth
grouped_conditions(18).bar_type     = 'OFF';
grouped_conditions(18).speed        = 3*3.75;
grouped_conditions(18).conds        = {[63,64]};


%% For other uses

% Minimal motion: ON-ON (all CW, CCW)
grouped_conditions(19).bar_type      = 'ON-ON';
grouped_conditions(19).len           = [.5];
grouped_conditions(19).conds         = {[1,2]};

grouped_conditions(20).bar_type      = 'ON-ON';
grouped_conditions(20).len           = [.7];
grouped_conditions(20).conds         = {[9,10]};

% Minimal motion: ON-OFF
grouped_conditions(21).bar_type      = 'ON-OFF';
grouped_conditions(21).len           = [.5];
grouped_conditions(21).conds         = {2+[1,2]};

grouped_conditions(22).bar_type      = 'ON-OFF';
grouped_conditions(22).len           = [.7];
grouped_conditions(22).conds         = {2+[9,10]};

% Minimal motion: OFF-ON
grouped_conditions(23).bar_type      = 'OFF-ON';
grouped_conditions(23).len           = [.5];
grouped_conditions(23).conds         = {4+[1,2]};

grouped_conditions(24).bar_type      = 'OFF-ON';
grouped_conditions(24).len           = [.7];
grouped_conditions(24).conds         = {4+[9,10]};

% Minimal motion: OFF-OFF
grouped_conditions(24).bar_type      = 'OFF-OFF';
grouped_conditions(24).len           = [.5];
grouped_conditions(24).conds         = {6+[1,2]};

grouped_conditions(25).bar_type      = 'OFF-OFF';
grouped_conditions(25).len           = [.7];
grouped_conditions(25).conds         = {6+[9,10]};