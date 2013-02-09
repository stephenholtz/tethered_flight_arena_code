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
 
% OFF / ON
% Shortflick / Longflick
% 1 2 3 4 4 5 6 7
% Thick-Long / Thick-Short / Thin-Long / Thin-Short

fx = @(x)(mat2cell(x',ones(1,size(x,2)),1));
%rx = @(x)(mat2cell([x(5:-1:1); x(5:8)]',[ones(1,size(x,2)/2)],[2]));

Off_short_flick = 1:3;
Off_long_flick  = 4:6;
On_short_flick  = 7:9;
On_long_flick   = 10:12;

% OFF
grouped_conditions(1).bar_type      = 'OFF';
grouped_conditions(1).flick_time    = 50;
grouped_conditions(1).bar_width     = 'Thick';
grouped_conditions(1).bar_len       = 'Long';
grouped_conditions(1).pos_degs      = [-90 0 90];
grouped_conditions(1).conds = Off_short_flick;
grouped_conditions(1).non_sym_list = fx(Off_short_flick);
grouped_conditions(1).sym_list = fx(Off_short_flick);

grouped_conditions(2).bar_type      = 'OFF';
grouped_conditions(2).flick_time    = 150;
grouped_conditions(2).bar_width     = 'Thick';
grouped_conditions(2).bar_len       = 'Long';
grouped_conditions(2).pos_degs      = [-90 0 90];
grouped_conditions(2).conds = Off_long_flick;
grouped_conditions(2).non_sym_list = fx(Off_long_flick);
grouped_conditions(2).sym_list = fx(Off_long_flick);

% ON
grouped_conditions(3).bar_type      = 'ON';
grouped_conditions(3).flick_time    = 50;
grouped_conditions(3).bar_width     = 'Thick';
grouped_conditions(3).bar_len       = 'Long';
grouped_conditions(3).pos_degs      = [-90 0 90];
grouped_conditions(3).conds = On_short_flick;
grouped_conditions(3).non_sym_list = fx(On_short_flick);
grouped_conditions(3).sym_list = fx(On_short_flick);

grouped_conditions(4).bar_type      = 'ON';
grouped_conditions(4).flick_time    = 150;
grouped_conditions(4).bar_width     = 'Thick';
grouped_conditions(4).bar_len       = 'Long';
grouped_conditions(4).pos_degs      = [-90 0 90];
grouped_conditions(4).conds = On_long_flick;
grouped_conditions(4).non_sym_list = fx(On_long_flick);
grouped_conditions(4).sym_list = fx(On_long_flick);
