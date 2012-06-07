function [Conditions conds_matrix symPairs patDir] = cl_contrast_sensitivity_20120123_2
% pat2 = positive contrast analog of 20120113. b = 8 b1 = 15 b3 = 10


cond_num = 1;
pats = 2; %:5;
ychans = [26 27 29 30]; %[26 27 29]; % 1,2-1,3
initial_positions =  [17 49 81]; %[17 49 81]; % 3 pos
% for dark on light
for pat = pats
    for y_pos = ychans
        for x_pos = initial_positions;
            Conditions(cond_num).PatternID = pat;
            Conditions(cond_num).Duration = 90;

            Conditions(cond_num).InitialPosition = [x_pos y_pos];
            cond_num = cond_num + 1;
        end
    end
end
for i = 1:cond_num - 1;
    % GAIN
    Conditions(i).RewardConditions.Gains = [-5 0 0 0];

    Conditions(i).RewardConditions.RewardDuration = 3;
    Conditions(i).RewardConditions.PatternID = Conditions(i).PatternID;
    Conditions(i).RewardConditions.Modes = [1 0];
    
    Conditions(i).RewardConditions.InitialPosition = [49 26];
    
    Conditions(i).RewardConditions.Sound = 'yes';
    Conditions(i).RewardConditions.PhoneNumber = '571-338-0895';
end

Conditions(1).NumConditions = cond_num-1;

% The things that don't change
for cond_num = 1:Conditions(1).NumConditions
    % GAINS
    Conditions(cond_num).Gains = [-5 0 0 0];
    Conditions(cond_num).PosFuncLoc = '';    
    Conditions(cond_num).Mode = [1 0];
    Conditions(cond_num).FuncFreqX = 32;
    Conditions(cond_num).PosFunctionX = [1 1];    
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