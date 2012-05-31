function score = score_fixation_circ_mean_trial(per_fly_trial_data)
% October 17, 2006. Basically, same as previous version, but now the
% incomming piece of data is just the position data for one fly, but it
% could be multiple trials. 
% also modified April 19, 2011 to also return mm and rr.

win_size = 1000;
win_advance = 50;
r_thresh = 0.5;

FRONT_lims = [120 240]*pi/180;
REAR_lims = [60 300]*pi/180;

num_reps = size(per_fly_trial_data, 1);

for i = 1:num_reps 
    Pos_temp = [];
    Data_rads = per_fly_trial_data(i,:)*2*pi/95;

    [mm,rr] = circ_mean_window(Data_rads, win_size, win_advance);
    FRONT_range = (mm >= FRONT_lims(1) & mm <= FRONT_lims(2));
    REAR_range = (mm <= REAR_lims(1) | mm >= FRONT_lims(2));
    R_above_thresh = (rr >= r_thresh);
    FRONT_score(i) = sum(FRONT_range.*R_above_thresh);
    REAR_score(i) = sum(REAR_range.*R_above_thresh);

    scale_fact = length(FRONT_range)/100;    
    score.REAR(i) = REAR_score(i)./scale_fact;
    score.FRONT(i) = FRONT_score(i)./scale_fact;
    score.None(i) = 100 - ((REAR_score(i) + FRONT_score(i))./scale_fact);
    score.Diff(i) = (REAR_score(i) - FRONT_score(i))./scale_fact;
    score.FRONT_score(i,:) = FRONT_range.*R_above_thresh;
    score.REAR_score(i,:) = REAR_range.*R_above_thresh;
    
    score.mm(i,:) = mm;
    score.rr(i,:) = rr;    
end

score.mean_REAR = mean(score.REAR);
score.mean_FRONT = mean(score.FRONT);
score.mean_None = mean(score.None);
score.mean_Diff = mean(score.Diff);
%score.mm = mm;
%score.rr = rr;