% make the position functions that the ON OFF stimuli will use, these are
% very simple (all of complexity comes from the pattern files)

clear func

output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/ON_OFF_set_v02';
func_iter = 1;
ms_per_sample = (1/250)*1000;
freq_str = 'SAMP_RATE_250Hz_';

% make position function for minimal motion stimuli, just 'step-step'

time_before = 80;
time_between_1 = 100;
time_between_2 = 160;
time_after = 200;

before = ones(1,round(time_before/ms_per_sample));
actual_time_before = round(time_before/ms_per_sample)*ms_per_sample;

during_1 = repmat(2,1,round(time_between_1/ms_per_sample));
during_2 = repmat(3,1,round(time_between_2/ms_per_sample));

actual_time_between_1 = (round(time_between_1/ms_per_sample))*ms_per_sample;
actual_time_between_2 = (round(time_between_2/ms_per_sample))*ms_per_sample;


after = ones(1,round(time_after/ms_per_sample));
actual_time_after = round(time_after/ms_per_sample)*ms_per_sample;


func = [before during_1 during_2 after] - 1;

if numel(num2str(func_iter)) < 2
    count = ['00' num2str(func_iter)];
elseif numel(num2str(func_iter)) < 3
    count = ['0' num2str(func_iter)];        
else
    count = num2str(func_iter);        
end

total_time = numel(func)*ms_per_sample;

func_name = ['position_function_' count     '_minimal_motion_' ...
                                            num2str(actual_time_before) 'ms_bef_' ...
                                            num2str(actual_time_between_1) 'ms_flk1_'...
                                            num2str(actual_time_between_2) 'ms_flk2_'...
                                            num2str(actual_time_after) 'ms_aft_'...
                                            freq_str ...
                                            num2str(total_time) 'ms_total']; %#ok<*AGROW>
disp(func_name)

save(fullfile(output_location,func_name),'func')

func_iter = func_iter + 1;

clear before during* after func_name func actual_*


% make the edge convergence/divergence position function, will be changed
% by changing the function update frequency. The duration will be 
% = (num frames in pat + num samples before)/(function update frequency)

samples_after = 100;
time_before = 3;

before = ones(1,time_before);
during = [];

for pos = 2:97
    during = [during, pos];
end

after = ones(1,samples_after);

func = [before during after];

if numel(num2str(func_iter)) < 2
    count = ['00' num2str(func_iter)];
elseif numel(num2str(func_iter)) < 3
    count = ['0' num2str(func_iter)];        
else
    count = num2str(func_iter);        
end

func_name = ['position_function_' count '_ON_OFF_edges_w_96_pos_1_frame_per_pos']; %#ok<*AGROW>

disp(func_name)

save(fullfile(output_location,func_name),'func')

func_iter = func_iter + 1;




