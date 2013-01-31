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

fx = @(x)(mat2cell([x;fliplr(x)]',[ones(1,size(x,2))],[2]));
fx = @(x)(mat2cell([x]',[ones(1,size(x,2))],[1]));
rx = @(x)(mat2cell([x(4:-1:1); x(5:8)]',[ones(1,size(x,2)/2)],[2]));

Off_shortflick_thicklong = 1:4:32;
Off_shortflick_thickshort = (1:4:32)+1;
Off_shortflick_thinlong = (1:4:32)+2;
Off_shortflick_thinshort = (1:4:32)+3;

Off_longflick_thicklong = 33:4:64;
Off_longflick_thickshort = (33:4:64)+1;
Off_longflick_thinlong = (33:4:64)+2;
Off_longflick_thinshort = (33:4:64)+3;

On_shortflick_thicklong  = 65:4:96;
On_shortflick_thickshort  = (65:4:96)+1;
On_shortflick_thinlong  = (65:4:96)+2;
On_shortflick_thinshort  = (65:4:96)+3;

On_longflick_thicklong  = 97:4:128;
On_longflick_thickshort  = (97:4:128)+1;
On_longflick_thinlong  = (97:4:128)+2;
On_longflick_thinshort  = (97:4:128)+3;

% OFF
grouped_conditions(1).bar_type      = 'OFF';
grouped_conditions(1).flick_time    = 50;
grouped_conditions(1).bar_width     = 'Thick';
grouped_conditions(1).bar_len       = 'Long';
grouped_conditions(1).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(1).conds = Off_shortflick_thicklong;
grouped_conditions(1).non_sym_list = fx(Off_shortflick_thicklong);
grouped_conditions(1).sym_list = rx(Off_shortflick_thicklong);

grouped_conditions(2).bar_type      = 'OFF';
grouped_conditions(2).flick_time    = 50;
grouped_conditions(2).bar_width     = 'Thick';
grouped_conditions(2).bar_len       = 'Short';
grouped_conditions(2).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(2).conds = Off_shortflick_thickshort;
grouped_conditions(2).non_sym_list = fx(Off_shortflick_thickshort);
grouped_conditions(2).sym_list = rx(Off_shortflick_thickshort);

grouped_conditions(3).bar_type      = 'OFF';
grouped_conditions(3).flick_time    = 50;
grouped_conditions(3).bar_width     = 'Thin';
grouped_conditions(3).bar_len       = 'Long';
grouped_conditions(3).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(3).conds = Off_shortflick_thinlong;
grouped_conditions(3).non_sym_list = fx(Off_shortflick_thinlong);
grouped_conditions(3).sym_list = rx(Off_shortflick_thinlong);

grouped_conditions(4).bar_type      = 'OFF';
grouped_conditions(4).flick_time    = 50;
grouped_conditions(4).bar_width     = 'Thin';
grouped_conditions(4).bar_len       = 'Long';
grouped_conditions(4).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(4).conds = Off_shortflick_thinshort;
grouped_conditions(4).non_sym_list = fx(Off_shortflick_thinshort);
grouped_conditions(4).sym_list = rx(Off_shortflick_thinshort);

grouped_conditions(5).bar_type      = 'OFF';
grouped_conditions(5).flick_time    = 200;
grouped_conditions(5).bar_width     = 'Thick';
grouped_conditions(5).bar_len       = 'Long';
grouped_conditions(5).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(5).conds = Off_longflick_thicklong;
grouped_conditions(5).non_sym_list = fx(Off_longflick_thicklong);
grouped_conditions(5).sym_list = rx(Off_longflick_thicklong);

grouped_conditions(6).bar_type      = 'OFF';
grouped_conditions(6).flick_time    = 200;
grouped_conditions(6).bar_width     = 'Thick';
grouped_conditions(6).bar_len       = 'Short';
grouped_conditions(6).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(6).conds = Off_longflick_thickshort;
grouped_conditions(6).non_sym_list = fx(Off_longflick_thickshort);
grouped_conditions(6).sym_list = rx(Off_longflick_thickshort);

grouped_conditions(7).bar_type      = 'OFF';
grouped_conditions(7).flick_time    = 200;
grouped_conditions(7).bar_width     = 'Thin';
grouped_conditions(7).bar_len       = 'Long';
grouped_conditions(7).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(7).conds = Off_longflick_thinlong;
grouped_conditions(7).non_sym_list = fx(Off_longflick_thinlong);
grouped_conditions(7).sym_list = rx(Off_longflick_thinlong);

grouped_conditions(8).bar_type      = 'OFF';
grouped_conditions(8).flick_time    = 200;
grouped_conditions(8).bar_width     = 'Thin';
grouped_conditions(8).bar_len       = 'Short';
grouped_conditions(8).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(8).conds = Off_longflick_thinshort;
grouped_conditions(8).non_sym_list = fx(Off_longflick_thinshort);
grouped_conditions(8).sym_list = rx(Off_longflick_thinshort);

% ON
grouped_conditions(9).bar_type      = 'ON';
grouped_conditions(9).flick_time    = 50;
grouped_conditions(9).bar_width     = 'Thick';
grouped_conditions(9).bar_len       = 'Long';
grouped_conditions(9).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(9).conds = On_shortflick_thicklong;
grouped_conditions(9).non_sym_list = fx(On_shortflick_thicklong);
grouped_conditions(9).sym_list = rx(On_shortflick_thicklong);

grouped_conditions(10).bar_type      = 'ON';
grouped_conditions(10).flick_time    = 50;
grouped_conditions(10).bar_width     = 'Thick';
grouped_conditions(10).bar_len       = 'Short';
grouped_conditions(10).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(10).conds = On_shortflick_thickshort;
grouped_conditions(10).non_sym_list = fx(On_shortflick_thickshort);
grouped_conditions(10).sym_list = rx(On_shortflick_thickshort);

grouped_conditions(11).bar_type      = 'ON';
grouped_conditions(11).flick_time    = 50;
grouped_conditions(11).bar_width     = 'Thin';
grouped_conditions(11).bar_len       = 'Long';
grouped_conditions(11).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(11).conds = On_shortflick_thinlong;
grouped_conditions(11).non_sym_list = fx(On_shortflick_thinlong);
grouped_conditions(11).sym_list = rx(On_shortflick_thinlong);

grouped_conditions(12).bar_type      = 'ON';
grouped_conditions(12).flick_time    = 50;
grouped_conditions(12).bar_width     = 'Thin';
grouped_conditions(12).bar_len       = 'Short';
grouped_conditions(12).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(12).conds = On_shortflick_thinshort;
grouped_conditions(12).non_sym_list = fx(On_shortflick_thinshort);
grouped_conditions(12).sym_list = rx(On_shortflick_thinshort);

grouped_conditions(13).bar_type      = 'ON';
grouped_conditions(13).flick_time    = 200;
grouped_conditions(13).bar_width     = 'Thick';
grouped_conditions(13).bar_len       = 'Long';
grouped_conditions(13).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(13).conds = On_longflick_thicklong;
grouped_conditions(13).non_sym_list = fx(On_longflick_thicklong);
grouped_conditions(13).sym_list = rx(On_longflick_thicklong);

grouped_conditions(14).bar_type      = 'ON';
grouped_conditions(14).flick_time    = 200;
grouped_conditions(14).bar_width     = 'Thick';
grouped_conditions(14).bar_len       = 'Short';
grouped_conditions(14).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(14).conds = On_longflick_thickshort;
grouped_conditions(14).non_sym_list = fx(On_longflick_thickshort);
grouped_conditions(14).sym_list = rx(On_longflick_thickshort);

grouped_conditions(15).bar_type      = 'ON';
grouped_conditions(15).flick_time    = 200;
grouped_conditions(15).bar_width     = 'Thin';
grouped_conditions(15).bar_len       = 'Long';
grouped_conditions(15).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(15).conds = On_longflick_thinlong;
grouped_conditions(15).non_sym_list = fx(On_longflick_thinlong);
grouped_conditions(15).sym_list = rx(On_longflick_thinlong);

grouped_conditions(16).bar_type      = 'ON';
grouped_conditions(16).flick_time    = 200;
grouped_conditions(16).bar_width     = 'Thin';
grouped_conditions(16).bar_len       = 'Short';
grouped_conditions(16).pos_degs      = [1 2 3 4 4 5 6 7];
grouped_conditions(16).conds = On_longflick_thinshort;
grouped_conditions(16).non_sym_list = fx(On_longflick_thinshort);
grouped_conditions(16).sym_list = rx(On_longflick_thinshort);
