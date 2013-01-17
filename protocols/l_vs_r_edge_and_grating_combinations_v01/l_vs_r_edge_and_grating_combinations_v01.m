function [Conditions] = l_vs_r_edge_and_grating_combinations_v01
% Protocol to bettern compare flicker contributions, this time including
% windowed stimuli. These do not require position functions
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
patterns = what(fullfile(dir,'patterns','l_vs_r_edge_and_grating_combinations_v01'));
pattern_loc = patterns.path;
patterns = patterns.mat;
pos_func_loc = fullfile(dir,'position_functions','l_vs_r_edge_and_grating_combinations_for_pfuncs_v01');
position_functions = what(pos_func_loc);
position_functions = position_functions.mat;
panel_cfgs_loc = fullfile(dir,'panel_configs');
panel_cfgs = what(panel_cfgs_loc);
panel_cfgs = panel_cfgs.mat;
cd(cf);

% Stim outline:
% - edges vs gratings: 3 speeds, 2 directions, 1 motion type
% - 4 edge types, and 4 grating types -> n combos 16
% - now need symmetric conditions too 
% [16*(3*2*1)*2]*3*5.5/60 = 53
% should be 192 conditions ~ meh

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 500;
duration = 2.5;

iter = 1;

for edge = [2 4 8 12]
    for grat = [2 4 8 12]
        combo_list{iter} = [edge grat];
        iter = iter + 1;
    end
end

directions = {'progressive','regressive'};
speeds = {'0pt5Hz','4Hz','8Hz'};

for motion_direction = directions
    
    for combo = combo_list
        
        barstr_1 = ['barsize_' num2str(combo{1}(1))];
        barstr_2 = ['barsize_' num2str(combo{1}(2))];
        
        for speed = speeds
            
            for sym_cond = 1:2
                
                % Find pattern number
                for i = 1:numel(patterns)
                    
                    if sym_cond == 1

                        if sum(strfind(patterns{i},['edge_L' barstr_1])) && sum(strfind(patterns{i},['grating_R' barstr_2])) && sum(strfind(patterns{i},motion_direction{1}))
                            pat_num = i;
                        end
                    
                    elseif sym_cond == 2
                        
                        if sum(strfind(patterns{i},['edge_R' barstr_1])) && sum(strfind(patterns{i},['grating_L' barstr_2])) && sum(strfind(patterns{i},motion_direction{1}))
                            pat_num = i;
                        end
                    end
                end
                
                Conditions(cond_num).PatternID      = pat_num; %#ok<*AGROW>
                Conditions(cond_num).PatternName    = patterns{pat_num};
                
                Conditions(cond_num).Gains          = [0 0 0 0];
                Conditions(cond_num).Mode           = [4 4];
                Conditions(cond_num).InitialPosition= [1 1];
                Conditions(cond_num).PosFuncLoc     = pos_func_loc;
                
                % Determine correct left sitmulus portion
                
                switch motion_direction{1}
                    case 'progressive'
                        left_dir = '_ccw';
                        right_dir = '_cw';
                    case 'regressive'
                        left_dir = '_cw';
                        right_dir = '_ccw';
                end
                
                % good lord
                for i = 1:numel(position_functions)
                    
                    if sum(strfind(position_functions{i},speed{1})) && sum(strfind(position_functions{i},left_dir))
                        if (sym_cond == 1 && sum(strfind(position_functions{i},['edge_' barstr_1]))) || (sym_cond == 2 && sum(strfind(position_functions{i},['grat_' barstr_2])))
                            pos_func_left = i;
                        end
                    end
                    
                    if sum(strfind(position_functions{i},speed{1})) && sum(strfind(position_functions{i},left_dir)) % left_dir on purpose!
                        if (sym_cond == 1 && sum(strfind(position_functions{i},['grat_' barstr_2]))) || (sym_cond == 2 && sum(strfind(position_functions{i},['edge_' barstr_1])))
                            pos_func_right = i;
                        end
                    end
                    
                end
                
                lf_inds = strfind(position_functions{pos_func_left},'SAMP_RATE_');
                left_frequency = str2double(position_functions{pos_func_left}(lf_inds+10:lf_inds+12));
                
                rf_inds = strfind(position_functions{pos_func_right},'SAMP_RATE_');
                right_frequency = str2double(position_functions{pos_func_right}(rf_inds+10:rf_inds+12));
                
                Conditions(cond_num).PosFunctionX   = [1 pos_func_left];
                Conditions(cond_num).FuncFreqX 		= left_frequency;
                Conditions(cond_num).PosFuncNameX   = position_functions{pos_func_left};
                
                % Determine correct right stmulus portion
                Conditions(cond_num).PosFunctionY 	= [2 pos_func_right];
                Conditions(cond_num).FuncFreqY 		= right_frequency;
                Conditions(cond_num).PosFuncNameY   = position_functions{pos_func_right};
                
                Conditions(cond_num).Duration       = duration;
                Conditions(cond_num).note           = '';

                total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;
                cond_num = cond_num + 1;
                
                clear pos_func_right pos_func_left left_frequency right_frequency
                
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