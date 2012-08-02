function [Conditions conds_matrix symPairs patDir] = ol_contrast_sensitivity_20120105
% pat set = contrast_pat_set
% pat1 = pretest alignment
% pat2 = single stripe choice test
% pat3 = striped grating choice test
% pat4 = dark on light cl 3 stripe pats
% pat5 = light on dark cl 3 stripe pats\
% pat6 = john's dark vs bright edge pattern %% ADD IN

cond_num = 1;
% Do the contrast preference tests; 32 conditions for both bars and
% stripes...

ychans = 1:32;
% single stripe choice
for y = ychans
Conditions(cond_num).PatternID = 2;
Conditions(cond_num).Gains = [0 0 0 0];
Conditions(cond_num).Mode = [4 0];
Conditions(cond_num).Duration = (89/32)*.89;
Conditions(cond_num).FuncFreqX = 32;
Conditions(cond_num).PosFunctionX = [1 3];
Conditions(cond_num).InitialPosition = [1 y];
Conditions(cond_num).PosFuncLoc = ('C:\tethered_flight_arena_code\position_functions\20111209\pos*');
cond_num = cond_num + 1;
end

% wide field choice
for y = ychans
Conditions(cond_num).PatternID = 3;
Conditions(cond_num).Gains = [35 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).Duration = ((89/32)*.89);
Conditions(cond_num).FuncFreqX = 32;
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).InitialPosition = [1 y];
Conditions(cond_num).PosFuncLoc = ('C:\tethered_flight_arena_code\position_functions\20111209\pos*');
cond_num = cond_num + 1;
end

% john's extra condition

% for y = ychans
% Conditions(cond_num).PatternID = 6;
% Conditions(cond_num).Duration = (89/32)*.89;
% Conditions(cond_num).FuncFreqX = 32;
% Conditions(cond_num).PosFunctionX = [1 3];
% Conditions(cond_num).InitialPosition = [1 y];
% Conditions(cond_num).Gains = [-10 0 0 0];
% Conditions(cond_num).Mode = [4 0];
% Conditions(cond_num).PosFuncLoc = ('C:\tethered_flight_arena_code\position_functions\20111209\pos*');
% cond_num = cond_num + 1;
% end


for i = 1:cond_num - 1;
Conditions(i).RewardConditions.RewardDuration = 3.25;
Conditions(i).RewardConditions.Gains = [-12 0 0 0];
Conditions(i).RewardConditions.Modes = [1 0];
    
    if Conditions(i).InitialPosition(2) <17
        Conditions(i).RewardConditions.PatternID = 4;        
        Conditions(i).RewardConditions.InitialPosition = [49 16];
    else
        Conditions(i).RewardConditions.PatternID = 5;        
        Conditions(i).RewardConditions.InitialPosition = [49 16];
    end

Conditions(i).RewardConditions.Sound = 'yes';
Conditions(i).RewardConditions.PhoneNumber = '571-338-0895';
end

Conditions(1).NumConditions = cond_num-1;

for cond_num = 1:Conditions(1).NumConditions
Conditions(cond_num).PatternName = Conditions(cond_num).PatternID;
Conditions(cond_num).PosFunctionY = [0 0];
Conditions(cond_num).FuncFreqY = 150;
Conditions(cond_num).SpatialFreq = 30; %%in degrees
Conditions(cond_num).VelFunction = [1 0];
Conditions(cond_num).PosFuncName = 'none';
Conditions(cond_num).VelFuncName = 'none';
Conditions(cond_num).Comments = '';
Conditions(cond_num).Type = 'ol';
Conditions(cond_num).Stimulus = 0;     
end


Conditions(1).EncodingRange = linspace(0.05,4.55,Conditions(1).NumConditions);
% from no contrast to full contrast sweeps, with each background
set1 = [1:8;9:16;];
set2 = [24:-1:17;32:-1:25];
symPairs = [set1 set2];

% Patterns
patDir = ('C:\tethered_flight_arena_code\patterns\20111215\');
posFuncDir = '';%('C:\tethered_flight_arena_code\position_functions\20111209\');
velFuncDir = '';
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