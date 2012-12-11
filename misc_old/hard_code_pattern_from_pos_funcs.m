function [pattern_out row_compressed] = hard_code_pattern_from_pos_funcs(pattern_loc,pos_func_x,pos_func_y,func_freq,duration)
% function hard_code_pattern_from_pos_funcs(pattern_loc[full file path],pos_func_x[full file path],...
%                                           pos_func_y[full file path],func_freq[Hz],duration[Seconds])
% Makes a hard coded pattern using a preexisting pattern and position
% functions to create the frames.
%
% Will return a one dimensional pattern that is made to run in X at the 
% SAME frame rate (gain + 2.5bias) as the frequency of the function.
%

% TODO:
% To hackishly wrap the patterns around,the pattern is progressed through
% until it moves, then the next time it equals the starting state, it is
% considered wrapped... seems cool, otherwise it goes for full duration
% calculated (this is working)

% Load pattern struct from the full file path
load(pattern_loc);

num_frames = func_freq*duration;

% X channel
load(pos_func_x)
for frame = 1:num_frames
    x_index(frame) = func(mod(frame,numel(func)))+1;
end
clear func

% Y channel
load(pos_func_y)
for frame = 1:num_frames
    y_index(frame) = func(mod(frame,numel(func)))+1;
end
clear func

% Get the first frame and save it
frame = 1;
orig_pat = pattern.Pats(:,:,x_index(frame),y_index(frame));


pat_has_moved = 0;
while ~pat_has_moved && num_frames > frame
    full_frame = pattern.Pats(:,:,x_index(frame),y_index(frame));

    if full_frame ~= orig_pat
        pat_has_moved = 1;
    end    

    pattern_out(:,:,frame) = full_frame; %#ok<*AGROW>
    frame = frame + 1;
    

end


pat_has_wrapped = 0;
while ~pat_has_wrapped && num_frames > frame
    full_frame = pattern.Pats(:,:,x_index(frame),y_index(frame));
    
    pattern_out(:,:,frame) = full_frame;
    frame = frame + 1;

    if full_frame == orig_pat
        pat_has_wrapped = 1;
    end
    
end


fprintf('Size: %d %d \n',size(pattern_out,1),size(pattern_out,2));

if pattern.row_compression
    row_compressed = 1;
else
    row_compressed = 0;
end

end