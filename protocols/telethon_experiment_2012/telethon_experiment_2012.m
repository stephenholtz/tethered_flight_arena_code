function Conditions = telethon_experiment_2012
%TELETHON_EXPERIMENT_2011 johns full telethon protocol all in one function.
% It uses the same patterns and functions as
% short_telethon_experiment_2011. All closed loop interval trial times are
% 3.5 seconds.
%
% All 130 experimental conditions are linearly spaced from .1 to 9.9 volts.
% closed loop portion is set to zero. 
%
% Values less than .1 are used to detect the stimulus timing, the linspace
% CANNOT be anything except .1-X or the detection is unreliable
% get to the correct directory

switch computer
    case 'MACI64'
        dir = '/Users/holtzs/tethered_flight_arena_code/';
    otherwise
        dir = 'C:\tethered_flight_arena_code\';        
end

% gather some information
    cf = pwd;
    patterns = what(fullfile(dir,'protocols','telethon_experiment_2012','patterns_on_SD_card'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'protocols','telethon_experiment_2012','functions_on_SD_card');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);    
    
i = 1;
%% from telethon_vel_nulling_conditions_9_14 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [4 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-4 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [4 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-4 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1;
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [4 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-4 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [16 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-16 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [16 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-16 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [16 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-16 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [64 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-64 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';

Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [64 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-64 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [64 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-64 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [128 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-128 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [128 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-128 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [128 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-128 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [192 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 6;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-192 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [192 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 7;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-192 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [192 -48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 8;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-192 48 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 


%% from telethon_tuning_shorter_conditions_9_14 
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 5];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 

%% from telethon_tuning_conditions_9_14 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 2;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-144 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 3;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 3;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-4 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 3;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 3;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 5];
Conditions(i).Gains = [48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 4;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 5];
Conditions(i).Gains = [-48 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [-72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 5;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [72 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 

%% from telethon_small_field_conditions_9_14 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 7];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 8];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 9];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 10];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 11];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 12];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 7];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 8];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 9];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 10];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 11];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 2];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 12];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 7];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 8];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 9];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 10];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 11];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
i = i + 1; 
%
Conditions(i).PatternID = 10;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [47 3];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 12];
Conditions(i).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
i = i + 1;
%
%% from telethon_optic_flow_condition_9_14 
Conditions(i).PatternID = 16;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_26_lift_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
%
Conditions(i).PatternID = 16;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_26_lift_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 
%
Conditions(i).PatternID = 17;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_27_pitch_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
%
Conditions(i).PatternID = 17;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_27_pitch_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 
%
Conditions(i).PatternID = 18;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_28_roll_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
%
Conditions(i).PatternID = 18;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_28_roll_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 
%
Conditions(i).PatternID = 19;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_29_sideslip_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
%
Conditions(i).PatternID = 19;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_29_sideslip_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 
%
Conditions(i).PatternID = 20;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_30_thrust_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
%
Conditions(i).PatternID = 20;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_30_thrust_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 
%
Conditions(i).PatternID = 21;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 3];
Conditions(i).PatternName = {'Pattern_31_yaw_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
i = i + 1; 
% 
Conditions(i).PatternID = 21;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [0 0 0 0];
Conditions(i).Mode = [4 0];
Conditions(i).PosFunctionX = [1 4];
Conditions(i).PatternName = {'Pattern_31_yaw_gs2.mat'};
Conditions(i).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
i = i + 1; 

%% from telethon_onoff_conditions_9_14 
%
Conditions(i).PatternID = 12;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 13;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_23_expansion_on_foeright_48_RC_telethon.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 14;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 15;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_25_expansion_off_foeright_48_RC_telethon.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [-32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 

%
%% from telethon_bilateral_conditions_9_14 Conditions(i).PatternID = 22;
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-8 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};

Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-24 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [96 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-96 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
%
Conditions(i).PatternID = 23;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [96 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 
% 
Conditions(i).PatternID = 22;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [-96 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(i).PosFuncNameX = 'none';
i = i + 1; 

%% Closed loop condition for interspersing between trials
%
Conditions(i).PatternID = 1;
Conditions(i).Duration = 3.5;
Conditions(i).InitialPosition = [49 1];
Conditions(i).Gains = [-15 0 0 0];
Conditions(i).Mode = [1 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = {'Pattern_11_8wide_bothcontrasts_stripes_c49_telethon.mat'};
Conditions(i).PosFuncNameX = 'none';

%% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));

for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1;
    Conditions(cond_num).PanelCfgName   = 'default_4bus_48panel';
	Conditions(cond_num).PosFuncNameY 	= 'null';
    Conditions(cond_num).PosFuncLoc     = '';
	Conditions(cond_num).FuncFreqY 		= 50;
	Conditions(cond_num).FuncFreqX 		= 50;
	Conditions(cond_num).PosFunctionY 	= [0 0];
	Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage        =  0;

