function Conditions = rev_phi_phase_delay_4_wide_v01
% Right now this is full field reverse phi phase delay 
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
    patterns = what(fullfile(dir,'patterns','reverse_phi'));
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','rev_phi_phase_delay_4_wide_v01');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;    
    cd(cf);

% generate all the conditions
cond_num = 1;
total_ol_dur = 0;
frequency = 400;

for pat = 2; % 4 Wide, full field
    % the different temporal frequency position functions
    for pos_funcX = [1 2 54 55 83 84]; % [1cc 1cw 2cc 2cw 3cc 3cw]
    % Sym conds will be sequential except for the last, which is the closed
    % loop condition       
    
        for flick = 1:2; % for both before and after the movement
            if flick == 1;
                switch pos_funcX
                    % different delays in ms for each flicker before movement
                    % This side of flicker has the 'no phase delay'
                    % conditions as well as before movement flickers
                    case {1, 2} % tf 1
                        delay_funcs_y = [3 4 11 18 25 31 38 45 52]; % [0]
                        delay_funcs_y = fliplr(delay_funcs_y);
                    case {54, 55} % tf 2
                        delay_funcs_y = [56 57 60 64 67 71 74 78 81]; % [0]
                        delay_funcs_y = fliplr(delay_funcs_y);                        
                    case {83, 84} % tf 3
                        delay_funcs_y = [85 86 88 90 92 94 96 98 100]; % [0]
                        delay_funcs_y = fliplr(delay_funcs_y);                        
                end
            else
                switch pos_funcX
                    % different delays in ms for each flicker after movement
                    % This side of flicker has only before movement conditions
                    case {1, 2} % tf 1
                        delay_funcs_y = [4 11 18 25 31 38 45 52] + 1; % []           
                    case {54, 55} % tf 2
                        delay_funcs_y = [57 60 64 67 71 74 78 81] + 1; % []
                    case {83, 84} % tf 3
                        delay_funcs_y = [86 88 90 92 94 96 98 100] + 1; % []        
                end
            end
        
        for pos_funcY = delay_funcs_y; % temporal freq sepecific delays pos function numbers
            Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
            Conditions(cond_num).PatternName = patterns{pat};
            
            % Mode = pos func control for x and y, init pos = 1 for both
            Conditions(cond_num).Mode           = [4 4];
            Conditions(cond_num).InitialPosition= [1 1];
            Conditions(cond_num).Gains          = [0 0 0 0];
            
            Conditions(cond_num).PosFunctionX   = [1 pos_funcX];
        	Conditions(cond_num).PosFunctionY 	= [2 pos_funcY];
            
            Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
            Conditions(cond_num).FuncFreqX 		= frequency;
            
            Conditions(cond_num).PosFuncLoc = pos_func_loc;            
            Conditions(cond_num).PosFuncNameX = position_functions{pos_funcX};
            Conditions(cond_num).PosFuncNameY = position_functions{pos_funcY};
            Conditions(cond_num).Duration = 2;
            total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;
            
            cond_num = cond_num + 1;
        end
        end
    end
end

% closed loop inter trial stimulus
Conditions(cond_num).PatternID      = numel(patterns); % single stripe 8 wide, same contrast as rev phi stims
Conditions(cond_num).PatternName    = patterns(numel(patterns));
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
Conditions(cond_num).Duration       = 2.85;
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
