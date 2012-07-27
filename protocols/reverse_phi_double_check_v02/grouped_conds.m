% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

% For figuring out the conditions...
% cm=make_cond_matrix(reverse_phi_double_check_v02);
% stim=reverse_phi_double_check_v02;

% First half of the conditions are using the hard coded patterns made from 
% the position functions used in the second half of the conditions
%
% This file is very confusing, I hope nobody ever has to look at it...

pat_cond_inds = 1:82;
pfunc_cond_inds = 83:164;
               
pat_conds_cw = [1:21 43:55 69:75]; % .75hz 2hz 4hz
pat_conds_ccw = [22:42 56:68 76:82]; 

%pfunc_conds_cw = pat_conds_cw + 82; % .75hz 2hz 4hz
%pfunc_conds_ccw = pat_conds_ccw + 82;

pfunc_conds_cw = [83:103 125:137 151:157] ; % .75hz 2hz 4hz
pfunc_conds_ccw = [104:124 138:150 158:164];

% Checked: 70,77 and 152,159 are sym conds and equal to each other
iter = 1;
for g = 1:numel(pat_conds_cw)
    sym_conditions{iter} = [pat_conds_cw(g) pat_conds_ccw(g)]; %#ok<*SAGROW>
    pat_conds{g} = [pat_conds_cw(g) pat_conds_ccw(g)];
    iter = iter + 1;
end

for g = 1:numel(pfunc_conds_cw)
    sym_conditions{iter} = [pfunc_conds_cw(g) pfunc_conds_ccw(g)];
    pfunc_conds{g} = [pfunc_conds_cw(g) pfunc_conds_ccw(g)];    
    iter = iter + 1;
end

%
tf0pt75_pat_conds = pat_conds(1:21);
tf0pt75_cond_order = [0 -5 5 -15 15 -20 20 -30 30 -40 40 -45 45 -55 55 -65 65 -70 70 -80 80];
[~,idxpt75hz] = sort(tf0pt75_cond_order);
tf0pt75_pat_conds = tf0pt75_pat_conds(idxpt75hz);

tf2_pat_conds = pat_conds(22:34);
tf2_cond_order = [0 -5 5 -10 10 -15 15 -20 20 -25 25 -30 30];
[~,idx2hz] = sort(tf2_cond_order);
tf2_pat_conds = tf2_pat_conds(idx2hz);

tf4_pat_conds = pat_conds(35:41);
tf4_cond_order = [0 -5 5 -10 10 -15 15];
[~,idx4hz] = sort(tf4_cond_order);
tf4_pat_conds = tf4_pat_conds(idx4hz);

%
tf0pt75_pfunc_conds = pfunc_conds(1:21);
tf0pt75_cond_order = [0 -5 5 -15 15 -20 20 -30 30 -40 40 -45 45 -55 55 -65 65 -70 70 -80 80];
[tfpt75hz,idxpt75hz] = sort(tf0pt75_cond_order);
tf0pt75_pfunc_conds = tf0pt75_pfunc_conds(idxpt75hz);

tf2_pfunc_conds = pfunc_conds(22:34);
tf2_cond_order = [0 -5 5 -10 10 -15 15 -20 20 -25 25 -30 30];
[tf2hz,idx2hz] = sort(tf2_cond_order);
tf2_pfunc_conds = tf2_pfunc_conds(idx2hz);

tf4_pfunc_conds = pfunc_conds(35:41);
tf4_cond_order = [0 -5 5 -10 10 -15 15];
[tf4hz,idx4hz] = sort(tf4_cond_order);
tf4_pfunc_conds = tf4_pfunc_conds(idx4hz);

% Grouped conditions for the plot to easily iterate

% Pat based
grouped_conditions{1}.name = 'Pat 0.75 Hz';
grouped_conditions{1}.tf = .75;
grouped_conditions{1}.x_axis = tfpt75hz;
grouped_conditions{1}.list = tf0pt75_pat_conds;

grouped_conditions{2}.name = 'Pat 2 Hz';
grouped_conditions{2}.tf = 2;
grouped_conditions{2}.x_axis = tf2hz;
grouped_conditions{2}.list = tf2_pat_conds;

grouped_conditions{3}.name = 'Pat 3 Hz';
grouped_conditions{3}.tf = 3;
grouped_conditions{3}.x_axis = tf4hz;
grouped_conditions{3}.list = tf4_pat_conds;


% Pos func based
grouped_conditions{4}.name = 'Func 0.75 Hz';
grouped_conditions{4}.tf = .75;
grouped_conditions{4}.x_axis = tfpt75hz;
grouped_conditions{4}.list = tf0pt75_pfunc_conds;

grouped_conditions{5}.name = 'Func 2 Hz';
grouped_conditions{5}.tf = 2;
grouped_conditions{5}.x_axis = tf2hz;
grouped_conditions{5}.list = tf2_pfunc_conds;

grouped_conditions{6}.name = 'Func 3 Hz';
grouped_conditions{6}.tf = 3;
grouped_conditions{6}.x_axis = tf4hz;
grouped_conditions{6}.list = tf4_pfunc_conds;



% Pat based
pat_conditions{1}.name = 'Pat 0.75 Hz';
pat_conditions{1}.tf = .75;
pat_conditions{1}.x_axis = tfpt75hz;
pat_conditions{1}.list = tf0pt75_pat_conds;

pat_conditions{2}.name = 'Pat 2 Hz';
pat_conditions{2}.tf = 2;
pat_conditions{2}.x_axis = tf2hz;
pat_conditions{2}.list = tf2_pat_conds;

pat_conditions{3}.name = 'Pat 3 Hz';
pat_conditions{3}.tf = 3;
pat_conditions{3}.x_axis = tf4hz;
pat_conditions{3}.list = tf4_pat_conds;


% Pos func based
pfunc_conditions{1}.name = 'Func 0.75 Hz';
pfunc_conditions{1}.tf = .75;
pfunc_conditions{1}.x_axis = tfpt75hz;
pfunc_conditions{1}.list = tf0pt75_pfunc_conds;

pfunc_conditions{2}.name = 'Func 2 Hz';
pfunc_conditions{2}.tf = 2;
pfunc_conditions{2}.x_axis = tf2hz;
pfunc_conditions{2}.list = tf2_pfunc_conds;

pfunc_conditions{3}.name = 'Func 3 Hz';
pfunc_conditions{3}.tf = 3;
pfunc_conditions{3}.x_axis = tf4hz;
pfunc_conditions{3}.list = tf4_pfunc_conds;
