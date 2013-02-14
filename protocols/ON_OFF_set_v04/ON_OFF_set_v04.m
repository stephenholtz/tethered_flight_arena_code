function [Conditions] = ON_OFF_set_v04
% Protocol with the couple of on and off stimuli, an expanded initial set
% for testing. A few subsequent for loops to set them up, easily
% modifiable. At least an extra .05 should be added to all durations
% because of alignement considerations
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
patterns = what(fullfile(dir,'patterns','ON_OFF_set_v04'));
pattern_loc = patterns.path;
patterns = patterns.mat;
pos_func_loc = fullfile(dir,'position_functions','ON_OFF_set_v04');
position_functions = what(pos_func_loc);
position_functions = position_functions.mat;
panel_cfgs_loc = fullfile(dir,'panel_configs');
panel_cfgs = what(panel_cfgs_loc);
panel_cfgs = panel_cfgs.mat;
cd(cf);

% Minimal Motion stimuli - WORKING
default_frequency = 250;
cond_num = 1;
total_ol_dur = 0;

for timing = 1:2 % the position functions
    if timing == 1
        duration = .5;
    elseif timing == 2
        duration = .7;
    end
    
    for pattern = 1:8
        Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
        Conditions(cond_num).PatternName    = patterns{pattern};
        Conditions(cond_num).Gains          = [0 0 0 0];
        Conditions(cond_num).Mode           = [4 0];
        Conditions(cond_num).InitialPosition= [1 1];
        Conditions(cond_num).PosFuncLoc     = pos_func_loc;
        Conditions(cond_num).PosFunctionX   = [1 timing];
        Conditions(cond_num).FuncFreqX 		= default_frequency;
        Conditions(cond_num).PosFuncNameX   = position_functions{Conditions(cond_num).PosFunctionX(2)};
        Conditions(cond_num).PosFunctionY 	= [2 0];
        Conditions(cond_num).FuncFreqY 		= default_frequency;
        Conditions(cond_num).PosFuncNameY   = 'null';
        Conditions(cond_num).Duration       = duration;
        Conditions(cond_num).note           = '';

        total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;
        cond_num = cond_num + 1;
        
    end
end

% ON and OFF Edges
for dps = round([100 220]/3.75) % 78 and 234 dps of the bar
    for pattern = 9:10 % converging vs diverging
        for on_off = 3:4 % y position has symm versions (8 px wide)
            
            Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
            Conditions(cond_num).PatternName    = patterns{pattern};
            Conditions(cond_num).Gains          = [dps 0 0 0];
            Conditions(cond_num).Mode           = [0 0];
            Conditions(cond_num).InitialPosition= [1 on_off];
            Conditions(cond_num).PosFuncLoc     = pos_func_loc;
            Conditions(cond_num).PosFunctionX   = [1 0];
            Conditions(cond_num).FuncFreqX 		= default_frequency;
            Conditions(cond_num).PosFuncNameX   = 'null'; % position_functions{dps};
            Conditions(cond_num).PosFunctionY 	= [2 0];
            Conditions(cond_num).FuncFreqY 		= default_frequency;
            Conditions(cond_num).PosFuncNameY   = 'null';
            Conditions(cond_num).Duration       = 97/dps;
            Conditions(cond_num).note           = '';

            total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;
            cond_num = cond_num + 1;
        end
    end
end

% Sweeping bar
for dps = round([100 220]/3.75)%4:5 % 78 and 234 dps of the bar
    for on_off = 1:2 % y position has on vs off, 4px wide
        for pattern = 11:12 % CW CCW
            Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
            Conditions(cond_num).PatternName    = patterns{pattern};
            Conditions(cond_num).Gains          = [dps 0 0 0];
            Conditions(cond_num).Mode           = [0 0];
            Conditions(cond_num).InitialPosition= [1 on_off];
            Conditions(cond_num).PosFuncLoc     = pos_func_loc;
            Conditions(cond_num).PosFunctionX   = [1 0];
            Conditions(cond_num).FuncFreqX 		= default_frequency;
            Conditions(cond_num).PosFuncNameX   = 'null';%position_functions{dps};
            Conditions(cond_num).PosFunctionY 	= [2 0];
            Conditions(cond_num).FuncFreqY 		= default_frequency;
            Conditions(cond_num).PosFuncNameY   = 'null';
            Conditions(cond_num).Duration       = 97/dps;
            Conditions(cond_num).note           = '';

            total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;
            cond_num = cond_num + 1;
        end
    end
end

% steady state interruption stimulus -- 
for dps = round([100 220]/3.75)%4:5 % 78 and 234 dps of the bar
    for pattern = 13:20
        
        Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
        Conditions(cond_num).PatternName    = patterns{pattern};
        Conditions(cond_num).Gains          = [dps 0 0 0];
        Conditions(cond_num).Mode           = [0 0];
        Conditions(cond_num).InitialPosition= [1 1];
        Conditions(cond_num).PosFuncLoc     = pos_func_loc;
        Conditions(cond_num).PosFunctionX   = [1 0];
        Conditions(cond_num).FuncFreqX 		= default_frequency;
        Conditions(cond_num).PosFuncNameX   = 'null';
        Conditions(cond_num).PosFunctionY 	= [2 0];
        Conditions(cond_num).FuncFreqY 		= default_frequency;
        Conditions(cond_num).PosFuncNameY   = 'null';
        Conditions(cond_num).Duration       = 41/dps;
        Conditions(cond_num).note           = '';
        
        total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;
        cond_num = cond_num + 1;
        
    end
end


% Telethon-like on/off pattern that john made to mimic dc's
cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 29;
Conditions(cond_num).Duration = 2;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [4 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 29;
Conditions(cond_num).Duration = 2;
Conditions(cond_num).InitialPosition = [1 2];
Conditions(cond_num).Gains = [4 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 29;
Conditions(cond_num).Duration = 2;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [8 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 29;
Conditions(cond_num).Duration = 2;
Conditions(cond_num).InitialPosition = [1 2];
Conditions(cond_num).Gains = [8 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

% Telethon ON-OFF stimuli
Conditions(cond_num).PatternID = 22;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [3 0 3 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14';
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 23;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [3 0 3 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_23_expansion_on_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 24;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [3 0 3 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 25;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [3 0 3 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_25_expansion_off_foeright_48_RC_telethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 21;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 1];
Conditions(cond_num).Gains = [32 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 21;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 2];
Conditions(cond_num).Gains = [-32 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 21;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 3];
Conditions(cond_num).Gains = [32 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_21_on_off_motion_telethon_patterntelethon.mat';
Conditions(cond_num).SpatialFreq = 30;
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

cond_num = cond_num + 1;
Conditions(cond_num).PatternID = 21;
Conditions(cond_num).Duration = 3;
Conditions(cond_num).InitialPosition = [1 4];
Conditions(cond_num).Gains = [-32 0 0 0];
Conditions(cond_num).Mode = [0 0];
Conditions(cond_num).PosFunctionX = [1 0];
Conditions(cond_num).PatternName = patterns{Conditions(cond_num).PatternID};%'Pattern_21_on_off_motion_telethon_pattern_8wide.mat';
Conditions(cond_num).PatternLoc = '/Users/stephenholtz/tethered_flight_arena_code/patterns/telethon_experiment_2012_patterns';
Conditions(cond_num).PosFuncNameX = 'none';
Conditions(cond_num).PosFuncNameY 	= 'null';
Conditions(cond_num).FuncFreqY 		= 50;
Conditions(cond_num).FuncFreqX 		= 50;
Conditions(cond_num).PosFunctionY 	= [2 0];
total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .12;

% closed loop inter-trial stimulus
cond_num = cond_num + 1;
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
Conditions(cond_num).Duration       = 3;
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
    Conditions(cond_num).Voltage        = encoded_vals(cond_num);
    Conditions(cond_num).PatternLoc     = pattern_loc;
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage   =  0;

total_dur = total_ol_dur + numel(Conditions)*Conditions(numel(Conditions)).Duration;
disp(total_dur/60);
end