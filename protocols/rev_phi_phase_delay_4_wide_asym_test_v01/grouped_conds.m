% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

%% For figuring out the conditions...
% stim = rev_phi_phase_delay_4_wide_asym_test_v01;
% cond_num = n;
% disp(cond_num)
% disp(stim(cond_num).PosFuncNameX(19:end))
% disp(stim(cond_num).PosFuncNameY(19:end))

%%
cc=1:70;
ccw=71:140;
for i = 1:numel(cc)
    sym_conditions{i}= [cc(i) ccw(i)]; %#ok<*SAGROW>
end

grouped_conditions{1}.name = '.75 Hz Polarity 0';
grouped_conditions{1}.tf = .75;
grouped_conditions{1}.polarity = 'on';
grouped_conditions{1}.x_axis = [-82.5:5:-2.5 0 2.5:5:82.5];
grouped_conditions{1}.list = sym_conditions([1:18 54:70]);

grouped_conditions{2}.name = '.75 Hz Polarity 1';
grouped_conditions{2}.tf = .75;
grouped_conditions{2}.polarity = 'off';
grouped_conditions{2}.x_axis = [-82.5:5:-2.5 0 2.5:5:82.5];
grouped_conditions{2}.list = sym_conditions(19:53);
