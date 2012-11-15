function [Conditions] = huston_head_bob_v01
% only expansion and stripe tracking

% get to the correct directory
switch computer
    case 'MACI64'
        dir = '/Users/stephenholtz/tethered_flight_arena_code/';
    otherwise
        dir = 'C:\tethered_flight_arena_code\';        
end

% gather some information
    cf = pwd;
    patterns = what(fullfile(dir,'patterns','telethon_experiment_2012_patterns'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','telethon_2012_position_funcs');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% Initialize iterators
cond_num = 1;
total_ol_dur = 0; 

% Values for stimuli
frequency = 50;
ol_duration = 10;
cl_duration = 6;

pos_funcX = 1;

% Relevant stimuli:
%
% Position functions (location in the telethon list)
% 3 - 'negative' position_function_sine_1Hz_20_pp_48wide_negative
% 4 - 'positive' position_function_sine_1Hz_20_pp_48wide_positive
%
% Patterns (location in the telethon list)
% 16 - lift
% 17 - pitch
% 18 - roll*
% 19 - sideslip*
% 20 - thrust
% 21 - yaw*

% Make the open loop stimuli in this loop

% Each of the motion stimuli
for pattern_num = [18 19 21]
    
    % Both 'negative and positive' versions of the yaw etc.,
    for position_function_x = [3 4]
        
        Conditions(cond_num).PatternID = pattern_num; %#ok<*AGROW>
        Conditions(cond_num).PatternName = patterns{pattern_num};
        Conditions(cond_num).PatternLoc  = pattern_loc;

        Conditions(cond_num).Mode           = [4 0];
        Conditions(cond_num).InitialPosition= [1 1];
        Conditions(cond_num).Gains          = [0 0 0 0];
        
        Conditions(cond_num).PosFunctionX   = [1 position_function_x];
        Conditions(cond_num).PosFunctionY 	= [2 1];

        Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
        Conditions(cond_num).FuncFreqX 		= frequency;
        Conditions(cond_num).PosFuncLoc     = pos_func_loc;            
        Conditions(cond_num).PosFuncNameX   = position_functions{pos_funcX};
        Conditions(cond_num).PosFuncNameY   = 'none';
        Conditions(cond_num).Duration       = ol_duration;
        total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;

        cond_num = cond_num + 1;
    end

end

% closed loop inter trial stimulus
Conditions(cond_num).PatternID      = numel(patterns); % single stripe 8 wide, same contrast as rev phi stims
Conditions(cond_num).PatternName    = patterns(numel(patterns));
Conditions(cond_num).PatternLoc     = pattern_loc;
Conditions(cond_num).Mode           = [1 0];
Conditions(cond_num).InitialPosition= [49 1];
Conditions(cond_num).Gains          = [-12 0 0 0]; % seems to work pretty well, 42-48 is another regime that looks nice
Conditions(cond_num).PosFunctionX   = [1 0];
Conditions(cond_num).PosFunctionY 	= [2 0];
Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
Conditions(cond_num).FuncFreqX 		= frequency;
Conditions(cond_num).PosFuncLoc     = 'none';            
Conditions(cond_num).PosFuncNameX   = 'none';
Conditions(cond_num).PosFuncNameY   = 'none';
Conditions(cond_num).Duration       = cl_duration;
Conditions(cond_num).Voltage        = 0;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));
for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1; % should be only the two center panels!
    Conditions(cond_num).PanelCfgName   = panel_cfgs(1);
    Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).SpatialFreq    = 'none';    
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage   =  0;

total_dur = total_ol_dur + numel(Conditions)*Conditions(numel(Conditions)).Duration;
disp(total_dur/60);
end