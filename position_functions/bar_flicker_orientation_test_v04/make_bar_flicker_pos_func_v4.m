% make_bar_flicker_pos_funcs

clear func

output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/bar_flicker_orientation_test_v01';
func_iter = 1;
time_before = 150;
ms_per_sample = (1/200)*1000;

durations = [50 200];
total_time = max(durations) + 1000;
freq = 'SAMP_RATE_200Hz';

for duration = durations
    
    for pos = 1:7 % the locations in the arena
        
        before = ones(1,time_before/ms_per_sample);
        
        during = repmat(pos+1,1,duration/ms_per_sample);
        
        time_after = total_time - ms_per_sample*(numel(before) + numel(during));
        
        after = ones(1,time_after/ms_per_sample);
        
        func = [before during after] - 1;
        
        if numel(num2str(func_iter)) < 2
            count = ['00' num2str(func_iter)];
        elseif numel(num2str(func_iter)) < 3
            count = ['0' num2str(func_iter)];        
        else
            count = num2str(func_iter);        
        end
        
        func_name = ['position_function_' count '_pos_' num2str(pos) '_flick_dur_' num2str(duration) 'ms_' freq '_total_dur' num2str(total_time) 'ms']; %#ok<*AGROW>
        
        disp(func_name)
        
        save(fullfile(output_location,func_name),'func')
        
        clear func_name
        
        func_iter = func_iter + 1;
        
    end
    
end

% Old version with 500 Hz position functions that keep crashing the
% controller
% % make_bar_flicker_pos_funcs
% 
% clear func
% 
% output_location = '/Users/stephenholtz/tethered_flight_arena_code/position_functions/bar_flicker_orientation_test_v01';
% func_iter = 1;
% time_before = 150;
% durations = [50 200 500];
% total_time = max(durations) + 1000;
% freq = 'SAMP_RATE_500Hz';
% 
% for duration = durations
%     
%     for pos = 1:7 % the locations in the arena
%         
%         before = ones(1,time_before/2);
%         
%         during = repmat(pos+1,1,duration/2);
%         
%         time_after = total_time - 2*(numel(before) + numel(during));
%         
%         after = ones(1,time_after/2);
%         
%         func = [before during after] - 1;
%         
%         if numel(num2str(func_iter)) < 2
%             count = ['00' num2str(func_iter)];
%         elseif numel(num2str(func_iter)) < 3
%             count = ['0' num2str(func_iter)];        
%         else
%             count = num2str(func_iter);        
%         end
%         
%         func_name = ['position_function_' count '_pos_' num2str(pos) '_flick_dur_' num2str(duration) 'ms_' freq '_total_dur' num2str(total_time) 'ms']; %#ok<*AGROW>
%         
%         disp(func_name)
%         
%         save(fullfile(output_location,func_name),'func')
%         
%         clear func_name
%         
%         func_iter = func_iter + 1;
%         
%     end
%     
% end