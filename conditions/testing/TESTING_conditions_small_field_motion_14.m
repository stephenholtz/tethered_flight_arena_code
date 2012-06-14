function [Conditions conds_matrix symPairs] = TESTING_conditions_small_field_motion_14

% List current SD card patterns
% slh_pats_list_20110906;

cond_num = 1;
pos = [1 25 49 73];
 for i = 1:41 % 3 Posfunc/Pattern Combos
        Conditions(cond_num).PatternID = 1;                                 %#ok<*AGROW>
        Conditions(cond_num).PatternName = Conditions(cond_num).PatternID;
        Conditions(cond_num).PosFunctionY = [0 0];
        Conditions(cond_num).Mode = [4 0];
        Conditions(cond_num).FuncFreqY = 150;
        Conditions(cond_num).SpatialFreq = 30; %%in degrees
        Conditions(cond_num).VelFunction = [1 0];
        Conditions(cond_num).PosFuncName = 'none';
        Conditions(cond_num).VelFuncName = 'none';
        Conditions(cond_num).Comments = '';
        Conditions(cond_num).Type = 'ol';
        Conditions(cond_num).Stimulus = 0;     
        Conditions(cond_num).Gains = [0 0 0 0];
        Conditions(cond_num).InitialPosition = [1 1];
        
        % shortsteps
        if      i < 12
        Conditions(cond_num).Duration =     0.0635+.5;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 i];        
        elseif  i < 23;
        Conditions(cond_num).Duration =     0.0635+.5;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 i];
        
        % Wiggles 
        elseif  i < 28
        Conditions(cond_num).Duration =     0.41;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 i];
        elseif  i < 33;
        Conditions(cond_num).Duration =     0.41;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 i];
        
        % sweeps   
        elseif  i < 37
            % 33 - 36
        base = i - 32; 
        Conditions(cond_num).Duration =     1.28;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 33];
        Conditions(cond_num).InitialPosition = [pos(base) 1];
        
        elseif  i < 41;
        base = i - 36; 
        Conditions(cond_num).Duration =     1.28;
        Conditions(cond_num).FuncFreqX =    150;
        Conditions(cond_num).PosFunctionX = [1 34];      
        Conditions(cond_num).InitialPosition = [pos(base) 1];
        
        elseif i == 41;
        Conditions(cond_num).PatternID = 2;                                 %#ok<*AGROW>
        Conditions(cond_num).PatternName = Conditions(cond_num).PatternID;
        Conditions(cond_num).PosFunctionY = [2 0];
        Conditions(cond_num).PosFunctionX = [1 0];
        Conditions(cond_num).InitialPosition = [1 1];
        Conditions(cond_num).Mode = [0 0];
        Conditions(cond_num).FuncFreqX = 150;
        Conditions(cond_num).FuncFreqY = 150;
        Conditions(cond_num).SpatialFreq = 30; %%in degrees
        Conditions(cond_num).VelFunction = [1 0];
        Conditions(cond_num).PosFuncName = 'none';
        Conditions(cond_num).VelFuncName = 'none';
        Conditions(cond_num).Comments = '';
        Conditions(cond_num).Type = 'ol';
        Conditions(cond_num).Stimulus = 0;     
        Conditions(cond_num).Gains = [-30 0 0 0];     
        Conditions(cond_num).Duration = 3;
        end
        %reward conds
        Conditions(cond_num).RewardConditions.RewardDuration = 3.5;
        Conditions(cond_num).RewardConditions.PatternID = 4;
        Conditions(cond_num).RewardConditions.Modes = [1 0];
        Conditions(cond_num).RewardConditions.Gains = [3 0 0 0];
        Conditions(cond_num).RewardConditions.InitialPosition = [1 1];
        Conditions(cond_num).RewardConditions.Sound = 'yes';
        Conditions(cond_num).RewardConditions.PhoneNumber = '571-338-0895';
        
%         %align conds
%         Conditions(cond_num).AlignConditions.RewardDuration = 2;
%         Conditions(cond_num).AlignConditions.PatternID = 1;
%         Conditions(cond_num).AlignConditions.Modes = [1 0];
%         Conditions(cond_num).AlignConditions.Gains = [-22 0 0 0];
%         Conditions(cond_num).AlignConditions.InitialPosition = [49 1];
%         Conditions(cond_num).AlignConditions.Sound = 'yes';
%         Conditions(cond_num).AlignConditions.PhoneNumber = '571-338-0895';
        cond_num = cond_num + 1;
end

Conditions(1).NumConditions = cond_num-1;
Conditions(1).EncodingRange = linspace(0.05,4.55,Conditions(1).NumConditions);

symPairs = [1:11,23:27,33:36 ; 22:-1:12,32:-1:28,37,40,39,38];

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

