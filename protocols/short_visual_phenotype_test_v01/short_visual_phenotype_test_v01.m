function [Conditions] = short_visual_phenotype_test_v01
% Protocol to quickly test for reduced standard visual responses, including
% some contrast things
% 
% SLH - 2013

% get to the correct directory
switch computer
    case 'MACI64'
        dir = '/Users/stephenholtz/tethered_flight_arena_code/';
    otherwise
        dir = 'C:\tethered_flight_arena_code\';        
end

% gather some information
cf = pwd;
patterns = what(fullfile(dir,'patterns','short_visual_phenotype_test_v01'));
pattern_loc = patterns.path;
patterns = patterns.mat;
pos_func_loc = fullfile(dir,'position_functions','short_visual_phenotype_test_v01');
position_functions = what(pos_func_loc);
position_functions = position_functions.mat;
panel_cfgs_loc = fullfile(dir,'panel_configs');
panel_cfgs = what(panel_cfgs_loc);
panel_cfgs = panel_cfgs.mat;
cd(cf);

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 200;
duration = 2.25;
vel_null = 1;

% Make a standard optomotor tuning curve
for frame_fps = [.5 2 4 8]*8
    for dir = [-1 1]
        
        Conditions(cond_num).PatternID      = 1; %#ok<*AGROW>
        Conditions(cond_num).PatternName    = patterns{Conditions(cond_num).PatternID};
        Conditions(cond_num).Gains          = [dir*frame_fps 0 0 0];
        Conditions(cond_num).Mode           = [0 0];
        Conditions(cond_num).InitialPosition= [1 1];
        Conditions(cond_num).PosFuncLoc     = '';
        Conditions(cond_num).PosFunctionX   = [1 0];
        Conditions(cond_num).FuncFreqX 		= default_frequency;
        Conditions(cond_num).PosFuncNameX   = 'null';
        Conditions(cond_num).PosFunctionY 	= [2 0];
        Conditions(cond_num).FuncFreqY 		= default_frequency;
        Conditions(cond_num).PosFuncNameY   = 'null';
        Conditions(cond_num).Duration       = duration;
        Conditions(cond_num).note           = '';
        
        cond_num = cond_num + 1;
        
    end
end

% Make a contrast optomotor tuning curve
for contrast = 1:4
    for dir = [-1 1]
        
        Conditions(cond_num).PatternID      = 2;
        Conditions(cond_num).PatternName    = patterns{Conditions(cond_num).PatternID};
        Conditions(cond_num).Gains          = [dir*4*8 0 0 0];
        Conditions(cond_num).Mode           = [0 0];
        Conditions(cond_num).InitialPosition= [1 contrast];
        Conditions(cond_num).PosFuncLoc     = '';
        Conditions(cond_num).PosFunctionX   = [1 0];
        Conditions(cond_num).FuncFreqX 		= default_frequency;
        Conditions(cond_num).PosFuncNameX   = 'null';
        Conditions(cond_num).PosFunctionY 	= [2 0];
        Conditions(cond_num).FuncFreqY 		= default_frequency;
        Conditions(cond_num).PosFuncNameY   = 'null';
        Conditions(cond_num).Duration       = duration;
        Conditions(cond_num).note           = '';
        
        cond_num = cond_num + 1;
        
    end
end

% Add in a few speeds of an oscillating stripe
for sampling_rate = [.5 1 2]*50
    for dir = [1 2]
        
        Conditions(cond_num).PatternID      = 6;
        Conditions(cond_num).PatternName    = patterns{Conditions(cond_num).PatternID};
        Conditions(cond_num).Gains          = [0 0 0 0];
        Conditions(cond_num).Mode           = [0 0];
        Conditions(cond_num).InitialPosition= [1 dir];
        Conditions(cond_num).PosFuncLoc     = '';
        Conditions(cond_num).PosFunctionX   = [1 1];
        Conditions(cond_num).FuncFreqX 		= sampling_rate;
        Conditions(cond_num).PosFuncNameX   = position_functions{dir};
        Conditions(cond_num).PosFunctionY 	= [2 0];
        Conditions(cond_num).FuncFreqY 		= default_frequency;
        Conditions(cond_num).PosFuncNameY   = 'null';
        Conditions(cond_num).Duration       = duration;
        Conditions(cond_num).note           = '';
        
        cond_num = cond_num + 1;
        
    end
end

if vel_null
    
    % from telethon_vel_nulling_conditions_9_14
    % These are all of the velocity nulling conditions (30 of them)
    % 1
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [4 0 -48 0 ];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];        
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 2
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-4 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 3
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [4 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 4
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-4 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1;
    % 5
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [4 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 6
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-4 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 7
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [16 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 8
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-16 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 9
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [16 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 10
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-16 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 11
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [16 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 12
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-16 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 13
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [64 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 14
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-64 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 15
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [64 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 16
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-64 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 17
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [64 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 18
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-64 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 19
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [128 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 20
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-128 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 21
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [128 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 22
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-128 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 23
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [128 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 24
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-128 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 25
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [192 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 26
    Conditions(cond_num).PatternID = 3;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-192 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_003_nulling_6wide_rotation_74_65.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 27
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [192 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 28
    Conditions(cond_num).PatternID = 4;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-192 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];
    Conditions(cond_num).PatternName = 'Pattern_004_nulling_6wide_rotation_74_74.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 29
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [192 0 -48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1; 
    % 30
    Conditions(cond_num).PatternID = 5;
    Conditions(cond_num).Duration = 2.5;
    Conditions(cond_num).InitialPosition = [1 1];
    Conditions(cond_num).Gains = [-192 0 48 0];
    Conditions(cond_num).Mode = [0 0];
    Conditions(cond_num).PosFunctionX = [1 0];
    Conditions(cond_num).PosFunctionY = [2 0];    
    Conditions(cond_num).PatternName = 'Pattern_005_nulling_6wide_rotation_74_83.mat';
    Conditions(cond_num).PosFuncNameX = 'none';
    Conditions(cond_num).Duration = duration;
    cond_num = cond_num + 1;

end

% closed loop inter-trial stimulus
Conditions(cond_num).PatternID      = numel(patterns); % single stripe 8 wide, same contrast as rev phi stims
Conditions(cond_num).PatternName    = patterns(numel(patterns));
Conditions(cond_num).PatternLoc     = pattern_loc;
Conditions(cond_num).Mode           = [1 0];
Conditions(cond_num).InitialPosition= [49 1];
Conditions(cond_num).Gains          = [-12 0 0 0]; % 12-14 seems to work pretty well, 42-48 is another regime that looks nice
Conditions(cond_num).PosFunctionX   = [1 0];
Conditions(cond_num).PosFunctionY 	= [2 0];
Conditions(cond_num).FuncFreqY 		= default_frequency;
Conditions(cond_num).FuncFreqX 		= default_frequency;
Conditions(cond_num).PosFuncLoc     = 'none';            
Conditions(cond_num).PosFuncNameX   = 'none';
Conditions(cond_num).PosFuncNameY   = 'none';
Conditions(cond_num).Duration       = 3.25;
Conditions(cond_num).Voltage        = 0;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));
for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1; % should be only the two center panels!
    Conditions(cond_num).PanelCfgName   = panel_cfgs{1};
    Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).SpatialFreq    = 'none';    
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
    Conditions(cond_num).PatternLoc     = pattern_loc;
    total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage   =  0;

total_dur = total_ol_dur + numel(Conditions)*Conditions(numel(Conditions)).Duration;
disp(total_dur/60);
end