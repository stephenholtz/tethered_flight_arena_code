function [Conditions] = progressive_regressive_spatial_freq_comparison_v01
% Protocol to find the spatial frequency of a stimulus that has the largest
% contribution to progressive and regressive motion. Matched temporal
% frequencies of both sides (both moving progressively or regressively)
% at a few values will persist during a large sweep through the spatial
% frequency domain.

% get to the correct directory
switch computer
    case 'MACI64'
        dir = '/Users/stephenholtz/tethered_flight_arena_code/';
    otherwise
        dir = 'C:\tethered_flight_arena_code\';        
end

% gather some information
    cf = pwd;
    patterns = what(fullfile(dir,'patterns','l_vs_r_spatial_temp_comparison'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','high_res_tuning_curves_v01');
    %position_functions = what(pos_func_loc);
    %position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
frequency = 50;
duration = 2.25;

% Iterate through the different optomotor stimuli.
%
% repeats full field, left, right for a few different pattern types
% 1 2 3 = 30 degrees, 4 5 6 = 60 degrees, 7 8 9 = 30 rp, 10 11 12 = 60 rp 
for pattern = [1 2 3 4 5 6 10 11 12]
    
    if pattern < 4
        % For the 30 degree patterns (spat wavelength) use 10 different speeds
        for speed = [.25, .5, 2, 4, 8, 12, 25, 50, 75, 100]*8;
            for direction = [1 2]
                
                % This feeds into a switch statement in Run.Utilities.set_panel_com
                Conditions(cond_num).DisplayType = 'panels';
                
                Conditions(cond_num).PatternID = pattern; %#ok<*AGROW>
                Conditions(cond_num).PatternName = patterns{pattern};
                Conditions(cond_num).PatternLoc  = pattern_loc;
                Conditions(cond_num).Mode           = [0 0];
                Conditions(cond_num).InitialPosition= [1 1];
                
                if direction == 1
                    Conditions(cond_num).Gains          = [speed 0 0 0];
                elseif direction == 2
                    Conditions(cond_num).Gains          = [-speed 0 0 0];
                end
                
                Conditions(cond_num).PosFunctionX   = [1 0];
                Conditions(cond_num).PosFunctionY 	= [2 0];
                Conditions(cond_num).FuncFreqY 		= frequency;
                Conditions(cond_num).FuncFreqX 		= frequency;
                Conditions(cond_num).PosFuncLoc     = pos_func_loc;            
                Conditions(cond_num).PosFuncNameX   = 'none';
                Conditions(cond_num).PosFuncNameY   = 'none';
                Conditions(cond_num).Duration = duration;
                total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;
                cond_num = cond_num + 1;
            end
        end
    else
        
        % For the 60 degree normal and reverse phi patterns use only 5 speeds
        for speed = [.5 4 8 25 75]*16
            for direction = [1 2]
                
                % This feeds into a switch statement in Run.Utilities.set_panel_com                
                Conditions(cond_num).DisplayType = 'panels';
                
                Conditions(cond_num).PatternID = pattern; %#ok<*AGROW>
                Conditions(cond_num).PatternName = patterns{pattern};
                Conditions(cond_num).PatternLoc  = pattern_loc;
                Conditions(cond_num).Mode           = [0 0];
                Conditions(cond_num).InitialPosition= [1 1];
                
                if direction == 1
                    Conditions(cond_num).Gains          = [speed 0 0 0];
                elseif direction == 2
                    Conditions(cond_num).Gains          = [-speed 0 0 0];
                end
                
                Conditions(cond_num).PosFunctionX   = [1 0];
                Conditions(cond_num).PosFunctionY 	= [2 0];
                Conditions(cond_num).FuncFreqY 		= frequency;
                Conditions(cond_num).FuncFreqX 		= frequency;
                Conditions(cond_num).PosFuncLoc     = pos_func_loc;            
                Conditions(cond_num).PosFuncNameX   = 'none';
                Conditions(cond_num).PosFuncNameY   = 'none';
                Conditions(cond_num).Duration = duration;
                total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;
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