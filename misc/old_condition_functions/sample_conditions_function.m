function [Conditions] = sample_conditions_function

cond_num = 1;
list = [1 2 3];
for num = list;
    Conditions(cond_num).PatternID      = num;
    Conditions(cond_num).Gains          = [-5 0 0 0];
    Conditions(cond_num).Mode           = [1 0];
    Conditions(cond_num).Duration       = 3;
    Conditions(cond_num).InitialPosition= [1 1];
    Conditions(cond_num).FuncFreqX      = 32;
    Conditions(cond_num).PosFunctionX   = [1 1];    
    Conditions(cond_num).FuncFreqY      = 150;
    Conditions(cond_num).PosFunctionY   = [0 0];
    Conditions(cond_num).VelFunction    =  [1 0];
    
    Conditions(cond_num).PosFunctionName= '';    
    Conditions(cond_num).VelFunctionName= '';   
    Conditions(cond_num).PatternName    = '';
    
    cond_num = cond_num + 1;
end