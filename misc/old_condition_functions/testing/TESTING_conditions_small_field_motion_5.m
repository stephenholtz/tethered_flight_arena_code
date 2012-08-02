function [Conditions conds_matrix] = TESTING_conditions_small_field_motion_5

% List current SD card patterns
% slh_pats_list_20110906;

% Conditions.Duration = 3;
cond_num = 1;

for i = 1:3 % 3 Posfunc/Pattern Combos
        Conditions(cond_num).PatternID = 3;    %#ok<*AGROW>
        Conditions(cond_num).PatternName = Conditions(cond_num).PatternID;
        Conditions(cond_num).InitialPosition = [1 7];
        Conditions(cond_num).PosFunctionY = [2 0];
        
        if      i == 1; Conditions(cond_num).Duration = 21.3;
                        Conditions(cond_num).PosFunctionX = [1 1];
                        Conditions(cond_num).InitialPosition = [1 7];
        elseif  i == 2; Conditions(cond_num).Duration = 21.3;
                        Conditions(cond_num).PosFunctionX = [1 6]; 
                        Conditions(cond_num).InitialPosition = [1 7];                
        elseif  i == 3; Conditions(cond_num).Duration = 21.3;
                        Conditions(cond_num).PosFunctionX = [1 2]; 
                        Conditions(cond_num).InitialPosition = [1 7];
        end
        
        Conditions(cond_num).Mode = [4 0];
        Conditions(cond_num).FuncFreqX = 100;
        Conditions(cond_num).FuncFreqY = 100;

        Conditions(cond_num).SpatialFreq = 30; %%in degrees
        Conditions(cond_num).VelFunction = [1 0];
        
        Conditions(cond_num).PosFuncName = 'none';
        Conditions(cond_num).VelFuncName = 'none';
        Conditions(cond_num).Comments = '';
        Conditions(cond_num).Type = 'ol';
        Conditions(cond_num).Stimulus = 0;     
        Conditions(cond_num).Gains = [0 0 0 0];
        cond_num = cond_num + 1;
end

Conditions(1).NumConditions = cond_num-1;
Conditions(1).EncodingRange = linspace(0.05,0.5,Conditions(1).NumConditions);

% Set up closed loop conditions
for q = 1:Conditions(1).NumConditions
Conditions(q).RewardConditions.RewardDuration = 3;
Conditions(q).RewardConditions.PatternID = 3;
Conditions(q).RewardConditions.Modes = [1 0];
Conditions(q).RewardConditions.Gains = [-20 0 0 0];
Conditions(q).RewardConditions.InitialPosition = [49 7];
Conditions(q).RewardConditions.Sound = 'yes';
Conditions(q).RewardConditions.PhoneNumber = '571-338-0895';
end

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

