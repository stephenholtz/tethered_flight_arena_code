function Conditions = telethon_ON_OFF_v01
%TELETHON_EXPERIMENT_2011 john's full telethon protocol all in one function.
% It uses the same patterns and functions as
% short_telethon_experiment_2011. All closed loop interval trial times are
% 3.5 seconds.
%
% All 130 experimental conditions are linearly spaced from .1 to 9.9 volts.
% closed loop portion is set to zero. 
%
% Values less than .1 are used to detect the stimulus timing, the linspace
% CANNOT be anything except .1-X or the detection is unreliable

%% from telethon_onoff_conditions_9_14 
i = 1;
Conditions(i).PatternID = 12;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14';
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';

i = i + 1;
Conditions(i).PatternID = 13;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 14;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 15;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [1 0 1 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_25_expansion_off_foeright_48_RC_telethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 1];
Conditions(i).Gains = [32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 2];
Conditions(i).Gains = [-32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 3];
Conditions(i).Gains = [32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(i).SpatialFreq = 30;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
i = i + 1;
Conditions(i).PatternID = 11;
Conditions(i).Duration = 3;
Conditions(i).InitialPosition = [1 4];
Conditions(i).Gains = [-32 0 0 0];
Conditions(i).Mode = [0 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(i).PosFuncNameX = 'none';

%% Closed loop condition for interspersing between trials
i = i + 1;
Conditions(i).PatternID = 1;
Conditions(i).Duration = 3.5;
Conditions(i).InitialPosition = [49 1];
Conditions(i).Gains = [-15 0 0 0];
Conditions(i).Mode = [1 0];
Conditions(i).PosFunctionX = [1 0];
Conditions(i).PatternName = 'Pattern_11_8wide_bothcontrasts_stripes_c49_telethon.mat';
Conditions(i).SpatialFreq = 0;
Conditions(i).PosFuncNameX = 'none';
Conditions(i).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11';
Conditions(i).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';

%% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));

for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1;
    Conditions(cond_num).PanelCfgName   = 'default_4bus_48panel';
	Conditions(cond_num).PosFuncNameY 	= 'null';
	Conditions(cond_num).FuncFreqY 		= 50;
	Conditions(cond_num).FuncFreqX 		= 50;
	Conditions(cond_num).PosFunctionY 	= [2 0];
	Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
    Conditions(cond_num).PatternLoc     = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage        =  0;

