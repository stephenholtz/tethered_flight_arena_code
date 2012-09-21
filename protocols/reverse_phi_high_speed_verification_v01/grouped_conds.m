% Grouped conditions file, specifies which conditions belong together in
%
% This file is used to hopefully automate comparisons later on

%%
cc=1:7;
ccw=8:14;
for i = 1:numel(cc)
    sym_conditions{i}= [cc(i) ccw(i)]; %#ok<*SAGROW>
end

grouped_conditions{1}.name = '.75 Hz';
grouped_conditions{1}.tf = .75;
grouped_conditions{1}.x_axis = [-82.5 -40 -2.5 0 2.5 40 82.5];
grouped_conditions{1}.list = sym_conditions(1:7);
