function [Conditions] = unilateral_flicker_contribution_phi_and_rev_phi_v01
% Protocol to see how a few types of flicker contribute to unilateral
% progressive and regressive motion and reverse phi motion. 
%
% SLH - 2012

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

% spatial frequencies of 8, 16 pixels (30, 60 degrees)
for spatial_freq = [8 16];
    for pattern_class_set = {'normal','full-flick','fick-bars'}
        for phi_type = [1 2] % phi and reverse phi
            for motion_type = [1 2] % progressive and regressive motion
                switch pattern_class_set{1}
                    % all of these are in format [R-motion L-flicker]
                    case {'normal'} % patterns with both sides

                        if spatial_freq == 8
                            if phi_type == 1
                                % i.e. [right_8_wide_phi_no_flicker, left_8_wide_phi_no_flicker]
                                symmetric_patterns = [22 22];
                            else
                                symmetric_patterns = [94 94];
                            end
                        elseif spatial_freq == 16
                            if phi_type == 1
                                symmetric_patterns = [27 27];
                            else
                                symmetric_patterns = [99 99];
                            end
                        end
                        
                    case {'full-flick'} % patterns with the full flicker half
                        
                        if spatial_freq == 8
                            if phi_type == 1
                                symmetric_patterns = [34 38];
                            else
                                symmetric_patterns = [106 110];
                            end
                        elseif spatial_freq == 16
                            if phi_type == 1
                                symmetric_patterns = [35 39];
                            else
                                symmetric_patterns = [107 111];
                            end
                        end
                        
                    case {'flick-bars'} % patterns with the flickering bars

                        if spatial_freq == 8
                            if phi_type == 1
                                symmetric_patterns = [42 46];
                            else
                                symmetric_patterns = [114 118];
                            end
                        elseif spatial_freq == 16
                            if phi_type == 1
                                symmetric_patterns = [43 47];
                            else
                                symmetric_patterns = [115 119];
                            end
                        end
                end % switch
                
                % Generate the actual Condition struct values
                for speed = [.5 4 8]*spatial_freq
                    for pattern_iter = 1:2

                        if motion_type == 1 % Progressive motion (CW Right first, CCW Left second) --> don't change the order from RL
                            % prog/rp-prog
                            pattern = symmetric_patterns(pattern_iter);
                            Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
                            Conditions(cond_num).PatternName    = patterns{pattern};                        
                        elseif motion_type == 2 % Regressive motion (CW Left first, CCW Right second) --> change the order from RL to LR
                            % reg/rp-reg
                            pattern = fliplr(symmetric_patterns);
                            Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
                            Conditions(cond_num).PatternName    = patterns{pattern};
                        end
                        
                        % The second pattern should go counterclockwise
                        if pattern_iter == 1
                            Conditions(cond_num).Gains          = [speed 0 0 0];
                        elseif pattern_iter == 2
                            Conditions(cond_num).Gains          = [-speed 0 0 0];
                        end
                        
                        Conditions(cond_num).Mode           = [0 0];
                        Conditions(cond_num).InitialPosition= [1 1];
                        Conditions(cond_num).PosFunctionX   = [1 1];
                        Conditions(cond_num).PosFunctionY 	= [2 1];
                        Conditions(cond_num).FuncFreqY 		= frequency;
                        Conditions(cond_num).FuncFreqX 		= frequency;
                        Conditions(cond_num).PosFuncLoc     = pos_func_loc;            
                        Conditions(cond_num).PosFuncNameX   = 'none';
                        Conditions(cond_num).PosFuncNameY   = 'none';
                        Conditions(cond_num).Duration = duration;

                        total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;

                        cond_num = cond_num + 1;
                    end
                end
            end
        end % phi_type
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