function [Conditions] = card_lab_expansion_v01
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
    patterns = what(fullfile(dir,'patterns','basic_expansion_v01'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','basic_expansion_v01');
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% generate all the conditions
cond_num = 1;
total_ol_dur = 0;
frequency = 200;
duration = 3;

%    
for speed = [12 24 48 80 128];% A few speeds tf: .75 1.5 3 5 8 ([12 24 48 80 128]*3.75)/60
for dir = [1 -1]
            % Pattern 1 is 4px wide expansion stimulus
            Conditions(cond_num).PatternID = 1; %#ok<*AGROW>
            Conditions(cond_num).PatternName = patterns{1};
            Conditions(cond_num).PatternLoc  = pattern_loc;
            
            % Mode = pos func control for x
            Conditions(cond_num).Mode           = [0 0];
            Conditions(cond_num).InitialPosition= [1 1];
            Conditions(cond_num).Gains          = [dir*speed 0 0 0];
            Conditions(cond_num).PosFunctionX   = [1 1];
            Conditions(cond_num).PosFunctionY 	= [2 1];
            Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
            Conditions(cond_num).FuncFreqX 		= frequency;
            Conditions(cond_num).PosFuncLoc = pos_func_loc;            
            Conditions(cond_num).PosFuncNameX = 'none';
            Conditions(cond_num).PosFuncNameY = 'none';
            Conditions(cond_num).Duration = duration;
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
Conditions(cond_num).Duration       = 6;
Conditions(cond_num).Voltage        = 0;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));
for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 2; % should be only the two center panels!
    Conditions(cond_num).PanelCfgName   = panel_cfgs(2);
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
