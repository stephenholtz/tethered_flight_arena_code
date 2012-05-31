% make_func_script.m
% make and save some position function files


func_path = 'C:\Matlabroot\Panel_controller_11_9_2010\functions\telethon_pos_funcs_04_11\';

amplitude = 10; %%2*this value gives you the full amplitude of the sine wave
func = round(amplitude*make_sine_wave_function(5, 100, 1));
% func2 = round(amplitude*make_sine_wave_function(4/3, 100, 3));
% func3 = round(amplitude*make_sine_wave_function(4/5, 100, 6));

% func = [func1 func2 func3 func3 func2 func1]; plot(func(:),'bo-')
% % plot(func1,'r');hold on; plot(func2,'bo-'); plot(func3,'go-');
% allfuncs = allfuncs(1:1000);
func_path = cd;
save([ func_path '\position_function_sine_1Hz_20wide_100Hzsf.mat'], 'func');
% 
% 
% func_path = 'C:\Matlabroot\Panel_controller_11_9_2010\functions\telethon_pos_funcs_04_11\';
% 
% amplitude = 10; %%2*this value gives you the full amplitude of the sine wave
% func1 = round(amplitude*make_sine_wave_function(4, 50, 1));
% func2 = round(amplitude*make_sine_wave_function(4/3, 50, 3));
% func3 = round(amplitude*make_sine_wave_function(4/6, 50, 6));
% 
% func = [func1 func2 func3 func3 func2 func1]; plot(func(:),'bo-')
% % % plot(func1,'r');hold on; plot(func2,'bo-'); plot(func3,'go-');
% % allfuncs = allfuncs(1:1000);
% save([ func_path 'position_function_sine_1_3_6Hz_598p_20wide_50Hzsf.mat'], 'func');
% 
% % make_func_script.m
% % make and save some position function files