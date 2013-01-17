function [Conditions] = unilateral_flicker_and_phi_revphi_motion_windowed_v01
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
patterns = what(fullfile(dir,'patterns','unilateral_flicker_and_phi_revphi_motion_windowed_v01'));
pattern_loc = patterns.path;
patterns = patterns.mat;
pos_func_loc = fullfile(dir,'position_functions','unilateral_flicker_and_phi_revphi_motion_windowed_v01');
position_functions = what(pos_func_loc);
position_functions = position_functions.mat;
panel_cfgs_loc = fullfile(dir,'panel_configs');
panel_cfgs = what(panel_cfgs_loc);
panel_cfgs = panel_cfgs.mat;
cd(cf);

% Stim outline:
% (2 directions), 2 speeds, 2 wavelengths, 2 window sizes = 16 types of
% flicker comparison
% 2xflick vs none, 2xflick vs motion, motion vs none, motion vs motion = 16
% types
% 2*8 + 2*16 + 16 + 16  -> 80*2 = 160 conds -> 44 mins

% Start a few variables for below    
cond_num = 1;
total_ol_dur = 0;
default_frequency = 500;
duration = 2.5;

motion_tfs = [2 6];
flicker_speeds = [[2 6]*8 [2 6]*16];

stim_types = {'flick_v_none','motion_v_none','flick_v_motion','motion_v_motion'};

for stim_type = stim_types
    
    % string parsing got confusing:
    % f = full field flicker, #e = lam w/ edge flicker, w = window degs
    % nmf = no motion flicker
    switch stim_type{1}
        case 'flick_v_none'
            pattern_pairs   = {[5,8]    ,[6,9]     ,[7,10]     ,[15,18]  ,[16,19]  ,[17,20]};
            pattern_info    = {'nmfw120','nmf8w120','nmf16w120','nmfw60' ,'nmf8w60','nmf16w60'};
            speeds = flicker_speeds;
            dirs = 1;
        case 'motion_v_none'
            pattern_pairs   = {[1,3]     ,[2,4]       ,[11,13] ,[12,14]};
            pattern_info    = {'mnf_8w120','mnf_16w120','mnf_8w60','mnf_16w60'};
            speeds = motion_tfs;
            dirs = [-1 1];
        case 'flick_v_motion'
            pattern_pairs = {[21,22] ,[24,25]   ,[27,28]  ,[36,37]   ,[39,40] ,[42,43]  ,[45,46] ,[54,55]};
            pattern_info = {'mf_8w120','mf_16w120','me_8w120','me_16w120','mf_8w60','mf_16w60','me_8w60','me_16w60'};
            speeds = motion_tfs;
            dirs = [-1 1];
        case 'motion_v_motion'
            pattern_pairs = {23,26,41,44};
            pattern_info = {'m_8w120','m_16w120','m_8w60','m_16w60'};
            speeds = motion_tfs;
            dirs = [-1 1];
    end
    
    for speed = speeds
        for dir = dirs
            for pat_pair_iter = 1:numel(pattern_pairs)
                
                for sym_cond = 1:numel(pattern_pairs{pat_pair_iter})
                    
                    % Get pattern number
                    pat_num = pattern_pairs{pat_pair_iter}(sym_cond);

                    Conditions(cond_num).PatternID      = pat_num; %#ok<*AGROW>
                    Conditions(cond_num).PatternName    = patterns{pat_num};
                    
                    % Get pattern fps
                    switch stim_type{1}
                        case 'flick_v_none'
                            pat_fps = speed;
                            lam = 0;
                        otherwise
                            lam = regexp(pattern_info{pat_pair_iter},'w','split');
                            lam = regexp(lam{1},'_','split');
                            lam = str2double(lam{2});
                            pat_fps = speed*lam;
                    end
                    
                    Conditions(cond_num).Gains          = [dir*pat_fps 0 dir*pat_fps 0];
                    Conditions(cond_num).Mode           = [0 0];
                    Conditions(cond_num).InitialPosition= [1 1];
                    
                    % Set position function junk (not in use here)
                    Conditions(cond_num).PosFuncLoc     = pos_func_loc;
                    Conditions(cond_num).PosFunctionX   = [1 0];
                    Conditions(cond_num).FuncFreqX 		= default_frequency;
                    Conditions(cond_num).PosFuncNameX   = 'null';
                    Conditions(cond_num).PosFunctionY 	= [2 0];
                    Conditions(cond_num).FuncFreqY 		= default_frequency;
                    Conditions(cond_num).PosFuncNameY   = 'null';
                    
                    Conditions(cond_num).Duration       = duration;
                    Conditions(cond_num).note           = [pattern_info{pat_pair_iter} '_lam_' num2str(lam) '_' num2str(pat_fps) '_fps'];
                    
                    total_ol_dur = total_ol_dur + Conditions(cond_num).Duration + .02;

                    cond_num = cond_num + 1;

                end

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