% Kitchen Sink Protocol - sine wave oscilation for the horizon, 41 amp
% position_function_01_sine_wave_amp_41_per_1

func = round(sin(0:(2*pi/41):2*pi)*41/2)+41/2;
func = round(func);

name = 'position_function_01_sine_wave_amp_41_per_1';
directory_name = 'C:\Users\holtzs\Desktop\Dropbox\Dropbox\ReiserLab\kitchen_sink\';
str = fullfile(directory_name, name);
save(str, 'func');