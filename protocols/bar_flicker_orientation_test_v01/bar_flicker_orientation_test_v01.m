function [Conditions] = bar_flicker_orientation_test_v01
% Protocol to check for bar orientation behavior
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
    patterns = what(fullfile(dir,'patterns','bar_flicker_orientation_test_v01'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','bar_flicker_orientation_test_v01');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 500;
duration = 1.5;

for bar_lum = 1:2

    for flicker_type = 1:2

        for arena_loc = [1 2 3 4 4 5 6 7];

            for bar_type = [1 3 4 6]

                Conditions(cond_num).PatternID      = bar_lum; %#ok<*AGROW>
                Conditions(cond_num).PatternName    = patterns{bar_lum};
                Conditions(cond_num).Gains          = [0 0 0 0];
                Conditions(cond_num).Mode           = [4 0];
                Conditions(cond_num).InitialPosition= [1 bar_type];
                Conditions(cond_num).PosFuncLoc     = pos_func_loc;

                switch flicker_type
                    case 1
                        x_pos_func = arena_loc + 0;
                    case 2
                        x_pos_func = arena_loc + 7;
                    case 3
                        error('I TOOK THIS OUT!')
                        x_pos_func = arena_loc + 14;
                end

                Conditions(cond_num).PosFunctionX   = [1 x_pos_func];
                Conditions(cond_num).FuncFreqX 		= default_frequency;
                Conditions(cond_num).PosFuncNameX   = position_functions{x_pos_func};

                Conditions(cond_num).PosFunctionY 	= [2 0];
                Conditions(cond_num).FuncFreqY 		= default_frequency;
                Conditions(cond_num).PosFuncNameY   = 'null';

                Conditions(cond_num).Duration       = duration;
                Conditions(cond_num).note           = '';

                total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;

                cond_num = cond_num + 1;

            end
        end
    end
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
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
    Conditions(cond_num).PatternLoc     = pattern_loc;
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage   =  0;

total_dur = total_ol_dur + numel(Conditions)*Conditions(numel(Conditions)).Duration;
disp(total_dur/60);
end