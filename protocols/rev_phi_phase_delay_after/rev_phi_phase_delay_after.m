function Conditions = rev_phi_phase_delay_after
% All experimental conditions are linearly spaced from .1 to 9.9 volts.
% closed loop portion is set to zero, and is the last condition.

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
    pos_func_loc = fullfile(dir,'position_functions','rev_phi_phase_delay');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% generate all the conditions
cond_num = 1;

for pat = 2; % 8 Wide, full field
    % the different temporal frequency position functions
    for pos_funcX = [1 2 20 21 35 36 44 45]; % [.5 hz CW .5 hz CCW 1 hz cw 1 hz ccw 2 hz cw 2 hz ccw 3 hz cw 3 hz ccw]
        switch pos_funcX
            % different delays in ms for each flicker after movement
            case {1, 2} % tf 0.5
                delay_funcs_y = [3 4:2:19]; % []
            case {20, 21} % tf 1
                delay_funcs_y = [22 23:2:34]; % []           
            case {35, 36} % tf 2
                delay_funcs_y = [37 38:2:43]; % []           
            case {44, 45} % tf 3
                delay_funcs_y = [46 47:2:50]; % []           
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
            
            Conditions(cond_num).FuncFreqY 		= 200; % all the pos funcs need to be made to work with this
            Conditions(cond_num).FuncFreqX 		= 200;
            
            Conditions(cond_num).PosFuncLoc = pos_func_loc;            
            Conditions(cond_num).PosFuncNameX = position_functions{pos_funcX};
            Conditions(cond_num).PosFuncNameY = position_functions{pos_funcY};    
            
            Conditions(cond_num).Duration = 3;
            
            cond_num = cond_num + 1;
        end
    end
end

% closed loop inter trial stimulus
Conditions(cond_num).PatternID      = numel(patterns); % single stripe 8 wide, same contrast as rev phi stims
Conditions(cond_num).PatternName    = patterns(numel(patterns));
Conditions(cond_num).Mode           = [1 0];
Conditions(cond_num).InitialPosition= [49 1];
Conditions(cond_num).Gains          = [-11 0 0 0];
Conditions(cond_num).PosFunctionX   = [1 0];
Conditions(cond_num).PosFunctionY 	= [2 0];
Conditions(cond_num).FuncFreqY 		= 200; % all the pos funcs need to be made to work with this
Conditions(cond_num).FuncFreqX 		= 200;
Conditions(cond_num).PosFuncLoc     = 'none';            
Conditions(cond_num).PosFuncNameX   = 'none';
Conditions(cond_num).PosFuncNameY   = 'none';
Conditions(cond_num).Duration       = 3.5;
Conditions(cond_num).Voltage        = 0;

% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));
for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 2; % should be the default 48 4 bus
    Conditions(cond_num).PanelCfgName   = panel_cfgs(1);
    Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).SpatialFreq    = 'none';    
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
    
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage   =  0;

