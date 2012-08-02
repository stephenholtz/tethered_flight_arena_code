% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

%% sym_conditions 

% For unilateral stimuli (all in terms of cw!):
% cw_left and ccw_right go together -- regressive
% cw_right and ccw_left go together -- progressive
% the last two in each variable below are the standard phi stimuli
cm = make_cond_matrix(unilat_rev_phi_phase_delay_4_wide_v01);

% .5 Hz
cw_left.speed1 = 1:19;
ccw_left.speed1 = 20:38;

cw_right.speed1 = 107:125;
ccw_right.speed1 = 126:144;

% 2.25 Hz
cw_left.speed2 = 39:57;
ccw_left.speed2 = 58:76;

cw_right.speed2 = 145:163;
ccw_right.speed2 = 164:182;

% 4.15 Hz
cw_left.speed3 = 77:91;
ccw_left.speed3 = 92:106;

cw_right.speed3 = 183:197;
ccw_right.speed3 = 198:212;

iter = 1;

% Progressive Motion
for speed = 1:numel(fieldnames(cw_right))
    for i = 1:numel(cw_right.(['speed', num2str(speed)]))
        sym_conditions{iter}= [cw_right.(['speed', num2str(speed)])(i) ccw_left.(['speed', num2str(speed)])(i)]; %#ok<*SAGROW>
        iter = iter + 1;
        prog_motion.(['speed', num2str(speed)]){i} = [cw_right.(['speed', num2str(speed)])(i) ccw_left.(['speed', num2str(speed)])(i)];
    end
end

% Regressive Motion
for speed = 1:numel(fieldnames(cw_left))
    for i = 1:numel(cw_left.(['speed', num2str(speed)]))
        sym_conditions{iter}= [cw_left.(['speed', num2str(speed)])(i) ccw_right.(['speed', num2str(speed)])(i)]; %#ok<*SAGROW>
        iter = iter + 1;
        reg_motion.(['speed', num2str(speed)]){i} = [cw_left.(['speed', num2str(speed)])(i) ccw_right.(['speed', num2str(speed)])(i)];
    end
end

% Progressive Motion - Reverse Phi

grouped_conditions{1}.name = '.5 Hz Reverse Phi F2B (Progressive) Motion';
grouped_conditions{1}.tf = .5;
grouped_conditions{1}.phi = 'Reverse';
grouped_conditions{1}.direction = 'F2B (Progressive)';
grouped_conditions{1}.x_axis = [-125 -107.5 -90 -72.5 -55 -37.5 -20 -2.5  0  2.5 20 37.5 55 72.5 90 107.5 125];
grouped_conditions{1}.list = prog_motion.speed1(1:end-2);

grouped_conditions{2}.name = '2.25 Hz Reverse Phi F2B (Progressive) Motion';
grouped_conditions{2}.tf = 2.25;
grouped_conditions{2}.phi = 'Reverse';
grouped_conditions{2}.direction = 'F2B (Progressive)';
grouped_conditions{2}.x_axis = [-27.5 -25 -20 -17.5 -12.5 -10 -5 -2.5 0 2.5 5 10 12.5 17.5 20 25 27.5];
grouped_conditions{2}.list = prog_motion.speed2(1:end-2);

grouped_conditions{3}.name = '4.15 Hz Reverse Phi F2B (Progressive) Motion';
grouped_conditions{3}.tf = 4.15;
grouped_conditions{3}.phi = 'Reverse';
grouped_conditions{3}.direction = 'F2B (Progressive)';
grouped_conditions{3}.x_axis = [-15 -12.5 -10 -7.5 -5 -2.5 0 2.5 5 7.5 10 12.5 15];
grouped_conditions{3}.list = prog_motion.speed3(1:end-2);

% Progressive Motion - Sandard Phi

grouped_conditions{4}.name = '.5 Hz F2B (Progressive) Motion';
grouped_conditions{4}.tf = .5;
grouped_conditions{4}.phi = 'Standard';
grouped_conditions{4}.direction = 'F2B (Progressive)';
grouped_conditions{4}.x_axis = [1 2];
grouped_conditions{4}.contrast = {'dark','bright'};
grouped_conditions{4}.list = prog_motion.speed1([end-1, end]);

grouped_conditions{5}.name = '2.25 Hz F2B (Progressive) Motion';
grouped_conditions{5}.tf = 2.25;
grouped_conditions{5}.phi = 'Standard';
grouped_conditions{5}.direction = 'F2B (Progressive)';
grouped_conditions{5}.x_axis = [1 2];
grouped_conditions{5}.contrast = {'dark','bright'};
grouped_conditions{5}.list = prog_motion.speed2([end-1, end]);

grouped_conditions{6}.name = '4.15 Hz F2B (Progressive) Motion';
grouped_conditions{6}.tf = 4.15;
grouped_conditions{6}.phi = 'Standard';
grouped_conditions{6}.direction = 'F2B (Progressive)';
grouped_conditions{6}.x_axis = [1 2];
grouped_conditions{6}.contrast = {'dark','bright'};
grouped_conditions{6}.list = prog_motion.speed3([end-1, end]);

% Regressive Motion - Reverse Phi

grouped_conditions{7}.name = '.5 Hz Reverse Phi B2F (Regressive) Motion';
grouped_conditions{7}.tf = .5;
grouped_conditions{7}.phi = 'Reverse';
grouped_conditions{7}.direction = 'B2F (Regressive)';
grouped_conditions{7}.x_axis = [-125 -107.5 -90 -72.5 -55 -37.5 -20 -2.5  0  2.5 20 37.5 55 72.5 90 107.5 125];
grouped_conditions{7}.list = reg_motion.speed1(1:end-2);

grouped_conditions{8}.name = '2.25 Hz Reverse Phi B2F (Regressive) Motion';
grouped_conditions{8}.tf = 2.25;
grouped_conditions{8}.phi = 'Reverse';
grouped_conditions{8}.direction = 'B2F (Regressive)';
grouped_conditions{8}.x_axis = [-27.5 -25 -20 -17.5 -12.5 -10 -5 -2.5 0 2.5 5 10 12.5 17.5 20 25 27.5];
grouped_conditions{8}.list = reg_motion.speed2(1:end-2);

grouped_conditions{9}.name = '4.15 Hz Reverse Phi B2F (Regressive) Motion';
grouped_conditions{9}.tf = 4.15;
grouped_conditions{9}.phi = 'Reverse';
grouped_conditions{9}.direction = 'B2F (Regressive)';
grouped_conditions{9}.x_axis = [-15 -12.5 -10 -7.5 -5 -2.5 0 2.5 5 7.5 10 12.5 15];
grouped_conditions{9}.list = reg_motion.speed3(1:end-2);


% Regressive Motion - Sandard Phi

grouped_conditions{10}.name = '.5 Hz B2F (Regressive) Motion';
grouped_conditions{10}.tf = .5;
grouped_conditions{10}.phi = 'Standard';
grouped_conditions{10}.direction = 'B2F (Regressive)';
grouped_conditions{10}.x_axis = [1 2];
grouped_conditions{10}.contrast = {'dark','bright'};
grouped_conditions{10}.list = reg_motion.speed1([end-1, end]);

grouped_conditions{11}.name = '2.25 Hz B2F (Regressive) Motion';
grouped_conditions{11}.tf = 2.25;
grouped_conditions{11}.phi = 'Standard';
grouped_conditions{11}.direction = 'B2F (Regressive)';
grouped_conditions{11}.x_axis = [1 2];
grouped_conditions{11}.contrast = {'dark','bright'};
grouped_conditions{11}.list = reg_motion.speed2([end-1, end]);

grouped_conditions{12}.name = '4.15 Hz B2F (Regressive) Motion';
grouped_conditions{12}.tf = 4.15;
grouped_conditions{12}.phi = 'Standard';
grouped_conditions{12}.direction = 'B2F (Regressive)';
grouped_conditions{12}.x_axis = [1 2];
grouped_conditions{12}.contrast = {'dark','bright'};
grouped_conditions{12}.list = reg_motion.speed3([end-1, end]);

