% make the position functions that the ON OFF stimuli will use, these are
% very simple (all of complexity comes from the pattern files)

clear func

output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/ON_OFF_set_v01';
func_iter = 1;
ms_per_sample = (1/250)*1000;

freq = 'SAMP_RATE_250Hz';

% make position function for minimal motion stimuli, just 'step-step'

total_time = 400;
time_before = 100;
time_between_set = [45 75 115];

for time_between = time_between_set

    before = ones(1,round(time_before/ms_per_sample));
    
    actual_time_before = round(time_before/ms_per_sample)*ms_per_sample;
    
    during_1 = repmat(2,1,round(time_between/ms_per_sample));
    during_2 = repmat(3,1,round(time_between/ms_per_sample));
    
    actual_time_between = (round(time_between/ms_per_sample))*ms_per_sample;
    
    time_after = total_time - ms_per_sample*(numel(before) + numel(during_1) + numel(during_2));
    after = ones(1,time_after/ms_per_sample);

    func = [before during_1 during_2 after] - 1;

    if numel(num2str(func_iter)) < 2
        count = ['00' num2str(func_iter)];
    elseif numel(num2str(func_iter)) < 3
        count = ['0' num2str(func_iter)];        
    else
        count = num2str(func_iter);        
    end

    func_name = ['position_function_' count '_minimal_motion_' num2str(actual_time_before) 'ms_before_' num2str(actual_time_between) 'ms_inter_flick_' freq '_total_dur' num2str(total_time) 'ms']; %#ok<*AGROW>

    disp(func_name)

    save(fullfile(output_location,func_name),'func')

    func_iter = func_iter + 1;

    clear before during* after func_name func actual_*

end

% % make the edge convergence/divergence position function
% 
% degrees_per_step = 3.75;
% time_after = 20;
% dps_set = [80 220];
% 
% for dps_wanted = dps_set
% 
%     wanted_steps_per_ms = (dps_wanted * (1/degrees_per_step))/1000;
%     samples_per_step = round(ms_per_sample/wanted_steps_per_ms);
%     
% 
% %     
% %     ms_per_step = ((dps_wanted/degrees_per_step)/1000)^-1;
% %     samples_per_step = ms_per_step*(1/ms_per_sample);
% % 
% %     actual_samples_per_step = round(samples_per_step);
%      actual_dps = 1000*(ms_per_sample * samples_per_step * (1/degrees_per_step))^-1;
% % 
% %     real_num_steps = round(ms_per_step/ms_per_sample);
% %     real_ms_per_step = real_num_steps*ms_per_step;
% %     real_dps = degrees_per_step * real_ms_per_step;
% 
%     time_before = 100;
%     
%     before = ones(1,time_before/ms_per_sample);
%     during = [];
% 
%     for pos = 2:97
% 
%         during = [during pos*ones(1,samples_per_step)];
% 
%     end
% 
%     after = ones(1,round(time_after/ms_per_sample));
%     actual_time_after = round(time_after/ms_per_sample)*ms_per_sample;
%     
%     stim_time = (numel(during) + numel(before + numel(after)))*ms_per_sample;
% 
%     func = [before during after] - 1;
% 
%     if numel(num2str(func_iter)) < 2
%         count = ['00' num2str(func_iter)];
%     elseif numel(num2str(func_iter)) < 3
%         count = ['0' num2str(func_iter)];        
%     else
%         count = num2str(func_iter);
%     end
% 
%     func_name = ['position_function_' count '_ON_OFF_edges_w_96_pos' num2str(time_before) 'ms_before_' num2str(round(actual_dps)) 'real_dps_' freq '_total_dur' num2str(stim_time) 'ms']; %#ok<*AGROW>
% 
%     disp(func_name)
% 
%     save(fullfile(output_location,func_name),'func')
% 
%     func_iter = func_iter + 1;
% 
%     clear before during after func_name func
% 
% end




