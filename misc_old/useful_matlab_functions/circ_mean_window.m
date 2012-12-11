function [m,r] = circ_mean_window(Phi, win_size, win_increment)
% [m,r] = circ_mean_window(Phi, win_size, win_increment)
% this functions calculates the circular mean for the data.
% This function assumes that the data is in radians.
% slides a window of size win_size through the data set, computing a mean
% angle and vector for each window. Window moves over by units
% win_increment.

Phi = Phi(:);
num_pts = length(Phi);

C = cos(Phi);
S = sin(Phi);

num_winds = floor((num_pts - win_size)/win_increment);
m = zeros(1,num_winds);
r = zeros(1,num_winds);
for j = 1:num_winds
    IND = [1:win_size] + (j - 1)*win_increment;
    X = sum(C(IND))/win_size;
    Y = sum(S(IND))/win_size;

    r(j) = sqrt(X^2 + Y^2);
    m(j) = atan2(Y,X);

    if m(j) < 0
        m(j) = m(j) + 2*pi;
    end

end