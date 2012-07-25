function Conditions = reverse_phi_double_check_v01
% This is half john's patterns and half my patterns as a sanity check, the
% conditions get quite confusing.
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
    patterns = what(fullfile(dir,'patterns','reverse_phi_double_check_patterns'));
    pattern_loc = patterns.path;
    patterns = patterns.mat;
    pos_func_loc = fullfile(dir,'position_functions','reverse_phi_double_check_v01_functions');
    position_functions = what(pos_func_loc);
    position_functions = position_functions.mat;
    panel_cfgs_loc = fullfile(dir,'panel_configs');
    panel_cfgs = what(panel_cfgs_loc);
    panel_cfgs = panel_cfgs.mat;
    cd(cf);

% testing them out
holtz = 1;
tuthill = 1;

% generate all the conditions
cond_num = 1;
total_ol_dur = 0;
frequency = 333; % frequency of the position functions is now changed to get to the same offsets
duration = 2;
% The speeds and biases from john's scripts... 100 + 92*2.5 = 330 fps
% BUT FROM THE CONTROLLER CODE:
% X_rate = ((X_val*gain_x)/10 + 5*bias_x)/2
% this is actually okay, because the X_val is * 10 *2... see documentation
open_loop_speed = 100;
open_loop_bias = 92;

% Make john's stimuli:
if tuthill
for pat = 1:8 % all four wide with different phase delays
    % Notes for using john's old stimuli:
    % Here are where the offsets are set, will need to use subsets to get
    % the experiments short enough.
    % The delays are in frames wrt the movement. The gain/bias is constant
    % and the total length of the pattern is stretched out to allow for
    % slower temporal frequencies (i.e. shorter patterns are faster). These
    % patterns do not go all the way to completely out of phase
    %
    % By my calculations each frame is only 3ms apart, John's code seems to
    % show them as being 5+ms each... made space 
    % 
%     if     pat == 1 || pat == 2 % 48 frame pattern before || after (~4 Hz)
%         offset_y_pos = 1:4;     % delays are [0 1 2 3] delays of flicker frames after/before the movement
%     elseif pat == 3 || pat == 4 % 96 frame pattern before || after (~2 Hz)
%         offset_y_pos = 1:6;     % delays are [0 1 2 3 4 6]
%     elseif pat == 5 || pat == 6 % 192 frame pattern before || after (~1 Hz)
%         offset_y_pos = 1:8;     % delays are [0 1 2 3 4 6 8 12]
%     elseif pat == 7 || pat == 8 % 384 frame pattern before || after (~.5 Hz)
%         offset_y_pos = 1:8;     % delays are [0 1 2 3 4 6 8 12]
%     end
    % No need to run the same exact condition twice...
    if     pat == 1             % 48 frame pattern before (~4 Hz)
        offset_y_pos = 1:4;     % delays are [0 1 2 3] delays of flicker frames after/before the movement
                                % 0 3 6 9ms
    elseif pat == 2             % 48 frame pattern after (~4 Hz)
        offset_y_pos = 2:4;     % delays are [0 1 2 3]
                                % 3 6 9ms
    elseif pat == 3             % 96 frame pattern before (~2 Hz)
        offset_y_pos = [1 2 3 5 6];  % delays are [0 1 2 3 4 6]
                                % 0 3 6 12 15 ms
    elseif pat == 4             % 96 frame pattern after (~2 Hz)
        offset_y_pos = [2 3 5 6];     % delays are [0 1 2 3 4 6]
                                % 3 6 12 15 ms
    elseif pat == 5             % 192 frame pattern before (~1 Hz)
        offset_y_pos = [1 3 5 6 7 8];  % delays are [0 1 2 3 4 6 8 12]
                                % 0 6 12 15 18 21 ms
    elseif pat == 6             % 192 frame pattern after (~1 Hz)
        offset_y_pos = [3 5 6 7 8];   % delays are [0 1 2 3 4 6 8 12]
                                % 6 12 15 18 21 ms
    elseif pat == 7             % 384 frame pattern before (~.5 Hz)
        offset_y_pos = [1 3 5 6 7 8];  % delays are [0 1 2 3 4 6 8 12]
                                % 0 6 12 15 18 21 ms
    elseif pat == 8             % 384 frame pattern after (~.5 Hz)
        offset_y_pos = [3 5 6 7 8];     % delays are [0 1 2 3 4 6 8 12]
                                % 6 12 15 18 21 ms
    end
    
    for speed = [1 2] % Both clockwise and counterclockwise
        for y_pos = offset_y_pos
            Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
            Conditions(cond_num).PatternName = patterns{pat};
            Conditions(cond_num).PatternLoc  = pattern_loc;
    
            % Mode = pos func control for x and y, init pos = 1 for both
            Conditions(cond_num).Mode           = [0 0];
            Conditions(cond_num).InitialPosition= [1 y_pos];
            
            % Counter clockwise or clockwise stimuli
            if speed == 1
                Conditions(cond_num).Gains = [open_loop_speed open_loop_bias 0 0];
            else
                Conditions(cond_num).Gains = [-open_loop_speed -open_loop_bias 0 0];
            end
            
            Conditions(cond_num).PosFunctionX   = [1 1];
            Conditions(cond_num).PosFunctionY 	= [2 1];

            Conditions(cond_num).FuncFreqY 		= frequency;
            Conditions(cond_num).FuncFreqX 		= frequency;

            Conditions(cond_num).PosFuncLoc = 'none';
            Conditions(cond_num).PosFuncNameX = 'none';
            Conditions(cond_num).PosFuncNameY = 'none';
            Conditions(cond_num).Duration = duration;

            total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;

            cond_num = cond_num + 1;
        end
    end
end
end

% Make my stimuli:
if holtz
for pat = 11; % 4 wide full field
    % the different temporal frequency position functions
    % [1 2  88 89 133 134 156 157] %[.5 .5 1 1 2 2 4 4] Hz in cw and ccw
    for pos_funcX = [1 2  88 89 133 134 156 157] %
    % Sym conds will be sequential except for the last, which is the closed
    % loop condition
    
        for flick = 1:2; % for both before and after the movement
            if flick == 1;
                switch pos_funcX
                    % different delays in ms for each flicker before movement
                    % This side of flicker has the 'no phase delay'
                    % conditions as well as before movement flickers
                    case {1, 2} % tf .5
                        delay_funcs_y = [3 6 10 12 14 16]; % 0 6 12 15 18 21 ms
                        %delay_funcs_y = fliplr(delay_funcs_y);
                    case {88, 89} % tf  1
                        delay_funcs_y = [90 93 97 99 101 103]; % 0 6 12 15 18 21 ms
                        %delay_funcs_y = fliplr(delay_funcs_y);
                    case {133, 134} % tf  2
                        delay_funcs_y = [135 136 138 142 144]; % 0 3 6 12 15 ms
                        %delay_funcs_y = fliplr(delay_funcs_y);
                    case {156, 157} % tf  4
                        delay_funcs_y = [158 159 161 163]; % 0 3 6 9ms
                        %delay_funcs_y = fliplr(delay_funcs_y);                  
                end
            else
                switch pos_funcX
                    % different delays in ms for each flicker after movement
                    % This side of flicker has only before movement conditions
                    case {1, 2} % tf .5
                        delay_funcs_y = [7 11 13 15 17]; % 6 12 15 18 21 ms
                    case {88, 89} % tf  1
                        delay_funcs_y = [94 98 100 102 104]; % 6 12 15 18 21 ms
                    case {133, 134} % tf  2
                        delay_funcs_y = [137 139 143 145]; % 3 6 12 15 ms
                    case {156, 157} % tf  4
                        delay_funcs_y = [160 162 164]; % 3 6 9ms
                end
            end
            
            for pos_funcY = delay_funcs_y; % temporal freq sepecific delays pos function numbers
                Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
                Conditions(cond_num).PatternName = patterns{pat};
                Conditions(cond_num).PatternLoc  = pattern_loc;
                
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
                Conditions(cond_num).Duration = duration;
                total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;
                
                cond_num = cond_num + 1;
            end
        end
        
%         % Add in motion without the flicker for both stages of the
%         % pattern's contrast
%         for y_chan = [1 2]; % either 'dark' or 'light' rotation
%             Conditions(cond_num).PatternID = pat; %#ok<*AGROW>
%             Conditions(cond_num).PatternName = patterns{pat};
%             Conditions(cond_num).PatternLoc  = pattern_loc;
%             
%             % Mode = pos func control for x and y, init pos = 1 for both
%             Conditions(cond_num).Mode           = [4 0];
%             Conditions(cond_num).InitialPosition= [1 y_chan];
%             Conditions(cond_num).Gains          = [0 0 0 0];
%             
%             Conditions(cond_num).PosFunctionX   = [1 pos_funcX];
%         	Conditions(cond_num).PosFunctionY 	= [2 1];
%             
%             Conditions(cond_num).FuncFreqY 		= frequency; % all the pos funcs need to be made to work with this
%             Conditions(cond_num).FuncFreqX 		= frequency;
%             
%             Conditions(cond_num).PosFuncLoc = pos_func_loc;            
%             Conditions(cond_num).PosFuncNameX = position_functions{pos_funcX};
%             Conditions(cond_num).PosFuncNameY = 'none';
%             Conditions(cond_num).Duration = 2;
%             total_ol_dur = total_ol_dur + Conditions(cond_num).Duration;
%             
%             cond_num = cond_num + 1;
%         end
    end
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
