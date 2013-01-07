function [function_vector,min_pos_func_sample_rate] = make_determine_best_simple_looping_position_functions(spatial_freq,temporal_freq,direction)
% make a position function to move a pattern with a very simple vector

% get the speed the pattern must move at in frames per second
% i.e. (loop/second)*(frames/loop) = frames/second
fps = temporal_freq*spatial_freq;

% find the minimum sampling rate to make the loop work
range_samp_rates = 50:500;
potential_step_sizes = (1/fps)*range_samp_rates;
min_pos_func_sample_rate = min(range_samp_rates((round(potential_step_sizes)==potential_step_sizes)));
step_size = (1/fps)*min_pos_func_sample_rate;

function_vector = [];

for step = 1:spatial_freq
    function_vector = [function_vector repmat(step-1,1,step_size)];
end

if direction == -1
    function_vector = fliplr(function_vector);
end

end
