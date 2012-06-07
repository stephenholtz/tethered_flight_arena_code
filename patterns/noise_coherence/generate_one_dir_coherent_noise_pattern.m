function coherence_pattern = generate_one_dir_coherent_noise_pattern(coherence_matrix,direction_matrix,velocity_matrix,gs_value_matrix)
% function generate_one_dir_coherent_noise_pattern(direction_matrix,velocity_matrix,gs_value_matrix)
% Make coherence pattern of a certain velocity with different directions of
% coherence in different areas based on passed values.
%
% coherence_matrix: The coherence of the motion at all points in the matrix
%                   - [0 0 0 .1 .1 .1] = direction in half the pattern is
%                   of 10% coherence, the other half will be random
% direction_matrix: The direction of the motion at all points in the matrix
%                   - [0 0 0 -90 -90 -90] = half the pattern will have
%                   motion moving at -90 degrees
% velocity_matrix:  The velocity of the motion at all points in the matrix
%                   - [25 25 25 25 25 25] = the velocity of the motion in
%                   the entire pattern will be 25 ??
% gs_value_matrix:  The gs values that should be used in the pattern.
%

% some defaults are hard coded here:
num_x_pixels = 12*8; %96 wide
num_y_pixels =  4*8; %36 tall



coherence_pattern = [];
end