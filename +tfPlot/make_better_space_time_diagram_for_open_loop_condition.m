function std_hand = make_better_space_time_diagram_for_open_loop_condition(condition_struct,save_file_path)
% Uses the duration and sampling rate of the position functions to
% make a long vector for each channel that represents the repeats that will
% occur (or not) of each position function vector. The sampling rate of
% these two will be phase locked to the faster of the two stimuli and at
% the frequency of 4 times the faster stimulus. For 'regular' gain and bias
% a frames per second is calculated and a position function with direction
% is constructed then fed through the same proceedure... for ease of
% viewing.


x_chan_vector = zeros(total_len,0);
y_chan_vector = [];


    function posfunc = convert_gains_bias_to_pos_func(gain,bias)
       
        fps = gain + (2.5*bias);
        
        posfunc = [];
        
    end

end