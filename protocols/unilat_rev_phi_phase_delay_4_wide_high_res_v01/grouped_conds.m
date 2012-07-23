% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

%% For figuring out the conditions...
% stim = unilat_rev_phi_phase_delay_4_wide_high_res_v01;
% cond_num = n;
% disp(cond_num)
% disp(stim(cond_num).PosFuncNameX(19:end))
% disp(stim(cond_num).PosFuncNameY(19:end))

%% sym_conditions 

% For unilateral stimuli (all in terms of cw!):
% cw_left and ccw_right go together -- regressive
% cw_right and ccw_left go together -- progressive
% the last two in each variable below are the standard phi stimuli

cw_left=1:37;
ccw_left=38:74;

cw_right=75:111;
ccw_right=112:148;

iter = 1;

% Progressive Motion
for i = 1:numel(cw_left)
    sym_conditions{iter}= [cw_right(i) ccw_left(i)]; %#ok<*SAGROW>
    iter = iter + 1;
    prog_motion{i} = [cw_right(i) ccw_left(i)];
end

% Regressive Motion
for i = 1:numel(cw_right)
    sym_conditions{iter}= [cw_left(i) ccw_right(i)]; %#ok<*SAGROW>
    iter = iter + 1;
    reg_motion{i} = [cw_left(i) ccw_right(i)];   
end

grouped_conditions{1}.name = '.75 Hz Reverse Phi F2B (Progressive) Motion';
grouped_conditions{1}.tf = .75;
grouped_conditions{1}.phi = 'Reverse';
grouped_conditions{1}.direction = 'F2B (Progressive)';
grouped_conditions{1}.x_axis = [-82.5:5:-2.5 0 2.5:5:82.5];
grouped_conditions{1}.list = prog_motion(1:end-2);

grouped_conditions{2}.name = '.75 Hz Reverse Phi B2F (Regressive) Motion';
grouped_conditions{2}.tf = .75;
grouped_conditions{2}.phi = 'Reverse';
grouped_conditions{2}.direction = 'B2F (Regressive)';
grouped_conditions{2}.x_axis = [-82.5:5:-2.5 0 2.5:5:82.5];
grouped_conditions{2}.list = reg_motion(1:end-2);

grouped_conditions{3}.name = '.75 Hz F2B (Progressive) Motion';
grouped_conditions{3}.tf = .75;
grouped_conditions{3}.phi = 'Standard';
grouped_conditions{3}.direction = 'F2B (Progressive)';
grouped_conditions{3}.x_axis = [1 2];
grouped_conditions{3}.contrast = ['low', 'high'];
grouped_conditions{3}.list = prog_motion([end-1, end]);

grouped_conditions{4}.name = '.75 Hz (Regressive) Motion';
grouped_conditions{4}.tf = .75;
grouped_conditions{4}.phi = 'Standard';
grouped_conditions{4}.direction = 'B2F (Regressive)';
grouped_conditions{4}.x_axis = [1 2];
grouped_conditions{4}.contrast = ['low', 'high'];
grouped_conditions{4}.list = reg_motion([end-1, end]);
