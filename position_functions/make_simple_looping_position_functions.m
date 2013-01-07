function function_vector = make_simple_looping_position_functions(spatial_freq,temporal_freq,pos_func_samp_freq)
% make a position function to move a pattern with a very simple vector

% get the speed the pattern must move at in frames per second
% i.e. (loop/second)*(frames/loop) = frames/second
fps = temporal_freq*spatial_freq;

% calculate the step size
% (frames/second)^-1 * (samples/second) = (samples/frame)
step_size = (1/fps)*pos_func_samp_freq;
if step_size ~= ceil(step_size)
    warning('Speed not exact!')
    step_size = ceil(step_size);
end

function_vector = [];

for step = 1:spatial_freq
    function_vector = [function_vector repmat(step-1,1,step_size)];
end

end
