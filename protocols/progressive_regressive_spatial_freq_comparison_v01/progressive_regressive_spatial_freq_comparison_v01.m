function [Conditions] = progressive_regressive_spatial_freq_comparison_v01
% Protocol to find the spatial frequency of a stimulus that has the largest
% contribution to progressive and regressive motion. Matched temporal
% frequencies of both sides (both moving progressively or regressively)
% at a few values will persist during a large sweep through the spatial
% frequency domain.
% 
% Note: this will be incredibly difficult to follow
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
    pos_func_loc = fullfile(dir,'position_functions','l_vs_r_position_functions');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 50;
duration = 2.25;
%'PROGRESSIVE L: ccw and R: cw'
%'REGRESSIVE L: cw and R: ccw'
true_func = @(x)~~(~isempty(x));
% %                     Right:  4  8 16 24    Left \/ 
% symmetric_pattern_matrix = [ 17,18,19,20;...     4
%                              21,22,23,24;...     8
%                              25,26,27,28;...     16
%                              29,30,31,32];%      24

%                     Right:  4  8 16 24    Left \/ 
symmetric_pattern_matrix = [ 17,18,19,20;...     4
                             21,22,23,24;...     8
                             25,26,27,28;...     16
                             29,30,31,32];%      24

right_spatial_freq_list = [4 8 16 24];
left_spatial_freq_list = [4 8 16 24];

for motion_type = [1 2] % progressive and regressive motion
    for temp_freq = [.5 4 8] % speeds of both arena halves will be temporal frequency matched, right?!?!
        % spatial frequencies of 4, 8, 16, 24 pixels (15, 30, 60, 90 degrees)
        for right_spatial_freq = right_spatial_freq_list;
            for left_spatial_freq = left_spatial_freq_list;
                
                %symmetric_pattern_matrix
                
                left_ind = (left_spatial_freq == left_spatial_freq_list);
                
                right_ind = (right_spatial_freq == right_spatial_freq_list);
                
                pattern = symmetric_pattern_matrix(left_ind,right_ind);

                % for getting the right temporal frequencies
                left_speed = temp_freq*left_spatial_freq_list(left_ind);
                right_speed = temp_freq*right_spatial_freq_list(right_ind);
                    
                    if motion_type == 1 % Progressive motion (CW Right first, CCW Left second) --> don't change the order from RL
                        % prog
                        Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
                        Conditions(cond_num).PatternName    = patterns{pattern};   
                        %Conditions(cond_num).Gains          = [left_speed 0 -right_speed 0];
                    elseif motion_type == 2 % Regressive motion (CW Left first, CCW Right second) --> change the order from RL to LR
                        % reg
                        Conditions(cond_num).PatternID      = pattern; %#ok<*AGROW>
                        Conditions(cond_num).PatternName    = patterns{pattern};
                        %Conditions(cond_num).Gains          = [-left_speed 0 right_speed 0];
                    end
                    Conditions(cond_num).Gains          = [0 0 0 0];
                    Conditions(cond_num).Mode           = [4 4];
                    Conditions(cond_num).InitialPosition= [1 1];
                    
                    Conditions(cond_num).PosFuncLoc     = pos_func_loc;
                    
                    % determine the left side position function and
                    % frequency
                    
                    %found_temp_freq = cellfun(true_func,(strfind(position_functions,'temp_freq_0pt5')));
                    if temp_freq < 1
                        temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
                    else
                        temp_freq_name = num2str(temp_freq);
                    end
                    
                    if left_spatial_freq < 1
                        spat_freq_name = regexprep(num2str(left_spatial_freq),'\.','pt');
                    else
                        spat_freq_name = num2str(left_spatial_freq);
                    end
                    
                    if motion_type == 1
                        dir = 'cw';
                    else
                        dir = 'ccw';
                    end
                    
                    function_ind = find(cellfun(true_func,(strfind(position_functions,['temp_freq_' temp_freq_name]))) & cellfun(true_func,(strfind(position_functions,['spat_freq_' spat_freq_name]))) & cellfun(true_func,(strfind(position_functions,['_dir_' dir]))));
                    pos_func_name = position_functions{function_ind};
                    freq_inds = (strfind(pos_func_name,'at_SAMP_RATE_'));
                    
                    frequency = str2double(pos_func_name((freq_inds+13):(freq_inds+15)));
                    
                    Conditions(cond_num).PosFunctionX   = [1 function_ind];
                    Conditions(cond_num).FuncFreqX 		= frequency;
                    Conditions(cond_num).PosFuncNameX   = pos_func_name;
                    
                    clear pos_func_ind frequency
                    
                    % determine the right side position function and
                    % frequency
                    
                    %found_temp_freq = cellfun(true_func,(strfind(position_functions,'temp_freq_0pt5')));
                    if temp_freq < 1
                        temp_freq_name = regexprep(num2str(temp_freq),'\.','pt');
                    else
                        temp_freq_name = num2str(temp_freq);
                    end
                    
                    if right_spatial_freq < 1
                        spat_freq_name = regexprep(num2str(right_spatial_freq),'\.','pt');
                    else
                        spat_freq_name = num2str(right_spatial_freq);
                    end
                    
                    if motion_type == 1
                        dir = 'ccw';
                    else
                        dir = 'cw';
                    end
                    
                    function_ind = find(cellfun(true_func,(strfind(position_functions,['temp_freq_' temp_freq_name]))) & cellfun(true_func,(strfind(position_functions,['spat_freq_' spat_freq_name]))) & cellfun(true_func,(strfind(position_functions,['_dir_' dir]))));
                    pos_func_name = position_functions{function_ind};
                    freq_inds = (strfind(pos_func_name,'at_SAMP_RATE_'));
                    
                    frequency = str2double(pos_func_name((freq_inds+13):(freq_inds+15)));
                    
                    
                    Conditions(cond_num).PosFunctionY 	= [2 function_ind];
                    Conditions(cond_num).FuncFreqY 		= frequency;
                    Conditions(cond_num).PosFuncNameY   = pos_func_name;
                    
                    clear pos_func_ind frequency
                    
                    Conditions(cond_num).Duration       = duration;
                    Conditions(cond_num).note           = ['Both_tf_' num2str(temp_freq) ' L_sf_' num2str(3.75*left_spatial_freq_list(left_ind)) ' R_sf_' num2str(3.75*right_spatial_freq_list(right_ind)) ];
                    
                    total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;
                    
                    %disp(Conditions(cond_num).PatternName)
                    
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