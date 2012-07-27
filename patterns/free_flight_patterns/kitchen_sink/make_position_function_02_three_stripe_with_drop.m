% Kitchen Sink Protocol - 30 sec, rotate, 30 sec, rotate, 30 sec, drop, 15
% sec.
% position_function_02_three_stripe_with_drop


% at 50 Hz, 1500 samples required for 30 seconds

func = [1*ones(1500,1),; 2*ones(1500,1); 1*ones(1500,1); 3*ones(1500/2,1)];
func = func';

name = 'position_function_02_three_stripe_with_drop';
directory_name = 'C:\Users\holtzs\Desktop\Dropbox\Dropbox\ReiserLab\kitchen_sink\';
str = fullfile(directory_name, name);
save(str, 'func');