function Conditions = ir_blast_v01
% This is just a few conditions to compare across segments of an experiment
% In this case I will let the fly go for a few seconds, then blast it with
% IR and see if the response before and after changes -- a great test
% before trying the ShiTS stuff.
%
% All experimental conditions are linearly spaced from .1 to 9.9 volts.
% closed loop portion is set to zero, and is the last condition.
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
    patterns = what(fullfile(dir,'patterns','ir_blast_patterns'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','ir_blast_v01_functions');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

    cond_num = 1;
    total_ol_dur = 0;
    frequency = 400;
    duration = 15.800;
    ol_duration = 6;


% Hard expansion left right 4 times at a medium contrast.


for pat = 1; % 4 wide medium contrast expansion
    for pos_funcX = 1; % left then right expansion repeating at 200 Hz
        Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
        Conditions(cond_num).PatternName = patterns{pat};
        Conditions(cond_num).PatternLoc  = pattern_loc;

        % Mode = pos func control for x and y, init pos = 1 for both
        Conditions(cond_num).Mode           = [4 0];
        Conditions(cond_num).InitialPosition= [1 1];
        Conditions(cond_num).Gains          = [0 0 0 0];
        
        Conditions(cond_num).PosFunctionX   = [1 pos_funcX];
        Conditions(cond_num).PosFunctionY 	= [2 1];

        Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
        Conditions(cond_num).FuncFreqX 		= frequency;
        
        Conditions(cond_num).PosFuncLoc = pos_func_loc;            
        Conditions(cond_num).PosFuncNameX = position_functions{pos_funcX};
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
Conditions(cond_num).Gains          = [-8 0 0 0];
Conditions(cond_num).PosFunctionX   = [1 0];
Conditions(cond_num).PosFunctionY 	= [2 0];
Conditions(cond_num).FuncFreqY 		= frequency;
Conditions(cond_num).FuncFreqX 		= frequency;
Conditions(cond_num).PosFuncLoc     = 'none';            
Conditions(cond_num).PosFuncNameX   = 'none';
Conditions(cond_num).PosFuncNameY   = 'none';
Conditions(cond_num).Duration       = ol_duration;
Conditions(cond_num).Voltage        = 0;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));
for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1; % Full pattern
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
