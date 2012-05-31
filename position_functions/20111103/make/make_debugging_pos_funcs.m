%% Position functions -- randomized for debuggging

% .2 == 187.5, .3 == 125 
% 
% This goes sweep forward, back, forward back in 2 seconds, returns to an
% original priming position centered on pixel 49.

% this part goes at the end to distinguish them from each other
ending = [0 0 0 0 0];
poss = repmat((41:60),1,100);
func = poss(randperm(numel(poss)));

for q = 1:4:numel(poss)-3
func(q:q+3) = repmat(func(q),1,4);
end

func = [func(1:1955) repmat(ending,1,10)];

cd('R:\slh_database\functions\20111103\')
save('position_function_01_rand_20range_2005_long_0_end','func')

clear func ending poss

ending = [95 95 95 95 95];
poss = repmat((31:70),1,50);
func = poss(randperm(numel(poss)));

for q = 1:4:numel(poss)-3
func(q:q+3) = repmat(func(q),1,4);
end

cd('R:\slh_database\functions\20111103\')
save('position_function_02_rand_40range_2005_long_95_end','func')


clear func

initpos = 0;
func = [];
for q = 3:1:6
    func = [func repmat(q,1,5)];
end

real_t3 = numel(func);
rev_func = fliplr(func);
func = [func repmat(func(numel(func)),1,100)];


cd('R:\slh_database\functions\20111103\')
save('position_function_03_4pos_sweep_300deg_sec_100hz_cw','func')

clear func

initpos = 0;
func = [];
for q = 3:-1:0
    func = [func repmat(q,1,5)];
end

real_t4 = numel(func);
func = [func repmat(func(numel(func)),1,100)];


cd('R:\slh_database\functions\20111103\')
save('position_function_04_4pos_sweep_300deg_sec_100hz_ccw','func')
