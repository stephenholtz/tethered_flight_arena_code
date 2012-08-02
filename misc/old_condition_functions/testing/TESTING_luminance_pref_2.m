function [Conditions conds_matrix symPairs] = TESTING_luminance_pref_2

% List current SD card patterns
% slh_pats_list_20110906;
% Functions in 20111201
cond_num = 1;
% Wiggles AT 7 positions CW AT 2 speeds, 3 diff funcs
for y = [1 2 4]
Conditions(cond_num).PatternID = 1;
Conditions(cond_num).Duration = 360;
% Conditions(cond_num).Duration = .45;
Conditions(cond_num).FuncFreqX = 50;
Conditions(cond_num).PosFunctionX = [1 1];
Conditions(cond_num).InitialPosition = [49 y];
Conditions(cond_num).Gains = [-4 0 0 0];
cond_num = cond_num + 1;
end

Conditions(cond_num).PatternID = 1;
Conditions(cond_num).Duration = 1;
Conditions(cond_num).FuncFreqX = 50;
Conditions(cond_num).PosFunctionX = [1 1];
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [0 0 0 0];
cond_num = cond_num + 1;

for i = 1:cond_num - 1;
Conditions(i).RewardConditions.RewardDuration = 3;
Conditions(i).RewardConditions.PatternID = 1;
Conditions(i).RewardConditions.Modes = [1 0];
Conditions(i).RewardConditions.Gains = [-4 0 0 0];
Conditions(i).RewardConditions.InitialPosition = [1 1];
Conditions(i).RewardConditions.Sound = 'yes';
Conditions(i).RewardConditions.PhoneNumber = '571-338-0895';
end
        
Conditions(1).NumConditions = cond_num-1;

for cond_num = 1:Conditions(1).NumConditions
Conditions(cond_num).PatternID = 1;
Conditions(cond_num).PatternName = Conditions(cond_num).PatternID;
Conditions(cond_num).PosFunctionY = [0 0];
Conditions(cond_num).Mode = [1 0];
Conditions(cond_num).FuncFreqY = 150;
Conditions(cond_num).SpatialFreq = 30; %%in degrees
Conditions(cond_num).VelFunction = [1 0];
Conditions(cond_num).PosFuncName = 'none';
Conditions(cond_num).VelFuncName = 'none';
Conditions(cond_num).Comments = '';
Conditions(cond_num).Type = 'ol';
Conditions(cond_num).Stimulus = 0;     
% Conditions(cond_num).InitialPosition = [1 1];
end

Conditions(1).EncodingRange = linspace(0.05,4.55,Conditions(1).NumConditions);

symPairs = [0];

for j = 1:Conditions(1).NumConditions
    for k = 1:18; conds_matrix{j,k} = [];end %#ok<*AGROW> % Prepopulate the Cell Array
    conds_matrix{j,1} = j;  %%the condition number
    conds_matrix{j,2} = Conditions(j).PatternName;
    conds_matrix{j,3} = Conditions(j).SpatialFreq;
    conds_matrix{j,4} = Conditions(j).Type;
    conds_matrix{j,5} = Conditions(j).Duration;
    conds_matrix{j,6} = Conditions(j).InitialPosition(1);       % X_ind;
    conds_matrix{j,7} = Conditions(j).InitialPosition(2);       % Y_ind;
    conds_matrix{j,8} = Conditions(j).Gains(1);                 % X_gain;
    conds_matrix{j,9} = Conditions(j).Gains(3);                 % Y_gain;
    conds_matrix{j,10} = Conditions(j).Mode;
    conds_matrix{j,11} = Conditions(j).VelFunction;
    conds_matrix{j,12} = Conditions(j).PosFunctionX;
    conds_matrix{j,13} = Conditions(j).PosFuncName;
    conds_matrix{j,14} = Conditions(j).VelFuncName;
    conds_matrix{j,15} = Conditions(j).Gains(2);                % X_bias;
    conds_matrix{j,16} = Conditions(j).Gains(4);                % Y_bias;
    conds_matrix{j,17} = Conditions(j).Comments;
    conds_matrix{j,18} = Conditions(1).EncodingRange;
end

