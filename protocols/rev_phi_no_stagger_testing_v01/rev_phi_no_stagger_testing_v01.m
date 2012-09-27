function Conditions = rev_phi_no_stagger_testing_v01
% rev_phi_no_stagger_testing_v01 
%
% New way of doing reverse phi stimuli (again!) for testing:
% The x channel has both the flicker and the movement in each pattern, in
% either the order: flicker then move, or move then flicker, or both at the
% same time. The position function will have built in delays to use the
% same patterns for each -- advantage is there is no initial flicker with
% the stimulus and there is now a much lower chance of flickering between
% polarities as when using a position function for the movement and a
% position function for the flicker. The functions are also slightly more
% straightforward, and the same exact one can be used for flicker before
% delay and flicker after delay. 
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
    patterns = what(fullfile(dir,'patterns','reverse_phi_no_stagger'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','rev_phi_no_stagger_testing_v01');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% generate all the conditions
cond_num = 1;
total_ol_dur = 0;
frequency = 200;
duration = 2;

%    
for pos_funcX = 1:13; % for all of the different delay position functions
    for pat = [1 2 3 4]; % flkr_then_move_cw, flkr_then_move_ccw, move_then_flkr_cw, move_then_flkr_ccw

            Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
            Conditions(cond_num).PatternName = patterns{pat};
            Conditions(cond_num).PatternLoc  = pattern_loc;
            
            % Mode = pos func control for x
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

for pos_funcX = 14; % the 'standard' position function

    for pat = [5 6 7 8 9 10]; %flkr_and_move ,and plain cw and ccw of some standard gratings for baseline
    
            Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
            Conditions(cond_num).PatternName = patterns{pat};
            Conditions(cond_num).PatternLoc  = pattern_loc;

            % Mode = pos func control for x
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
Conditions(cond_num).Gains          = [-12 0 0 0]; % seems to work pretty well, 42-48 is another regime that looks nice
Conditions(cond_num).PosFunctionX   = [1 0];
Conditions(cond_num).PosFunctionY 	= [2 0];
Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
Conditions(cond_num).FuncFreqX 		= frequency;
Conditions(cond_num).PosFuncLoc     = 'none';            
Conditions(cond_num).PosFuncNameX   = 'none';
Conditions(cond_num).PosFuncNameY   = 'none';
Conditions(cond_num).Duration       = 3;
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