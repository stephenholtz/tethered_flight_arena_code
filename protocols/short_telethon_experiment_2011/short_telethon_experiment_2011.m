function [Conditions] = short_telethon_experiment_2011
% 16 conditions + a closed loop that is the 17th condition
% strs = [];
% for g = 1:numel(Conditions)
%     for i = 1:numel(fieldnames(Conditions))
%         a = fieldnames(Conditions);
%         out = getfield(Conditions(g),a{i});
%         if ischar (out)
%             out = [' ''' ,out, ''' ']; 
%         elseif isnumeric(out)
%             out = ['[', num2str(out), ']'];
%         end
%         str = [ 'Conditions(',num2str(g),').', a{i}, ' = ', out '; wwwww '];
%         strs = [strs str] ;
%     end
% end
% 
% (strs)

% Conditions for John's short telethon - updated 2012

%% Bilateral Motion
% Back to front 9 Hz LEFT SIDE
Conditions(1).PatternID = [22]; 
Conditions(1).Duration = [3];
Conditions(1).InitialPosition = [1  3]; 
Conditions(1).Gains = [96   0   0   0];
Conditions(1).Mode = [0  0];
Conditions(1).PosFunctionX = [1  0];
Conditions(1).PatternName =  'Pattern_32_rotation_left_half_gs3.mat' ; 
Conditions(1).SpatialFreq = [30];
Conditions(1).VelFunction = [1  0];
Conditions(1).PosFuncNameX =  'null' ; 
Conditions(1).VelFuncName =  'none' ;
Conditions(1).NumConditions = [16];
Conditions(1).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(1).FuncFreqX = [50];
Conditions(1).PosFunctionY = [0  0];
Conditions(1).FuncFreqY = [50];
Conditions(1).Voltage = [0.05];
Conditions(1).PosFuncNameY =  'null';

% Back to front 9 Hz RIGHT SIDE
Conditions(2).PatternID = [23];
Conditions(2).Duration = [3]; 
Conditions(2).InitialPosition = [1  3];
Conditions(2).Gains = [-96   0   0   0];
Conditions(2).Mode = [0  0];
Conditions(2).PosFunctionX = [1  0];
Conditions(2).PatternName =  'Pattern_33_rotation_right_half_gs3.mat';
Conditions(2).SpatialFreq = [30];
Conditions(2).VelFunction = [1  0]; 
Conditions(2).PosFuncNameX =  'none' ; 
Conditions(2).VelFuncName =  'none' ; 
Conditions(2).NumConditions = [16]; 
Conditions(2).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(2).FuncFreqX = [50]; 
Conditions(2).PosFunctionY = [0  0]; 
Conditions(2).FuncFreqY = [50]; 
Conditions(2).Voltage = [0.14063]; 
Conditions(2).PosFuncNameY =  'null' ; 

% Front to back 9 Hz RIGHT SIDE
Conditions(3).PatternID = [23]; 
Conditions(3).Duration = [3]; 
Conditions(3).InitialPosition = [1  3]; 
Conditions(3).Gains = [96   0   0   0]; 
Conditions(3).Mode = [0  0]; 
Conditions(3).PosFunctionX = [1  0]; 
Conditions(3).PatternName =  'Pattern_33_rotation_right_half_gs3.mat' ; 
Conditions(3).SpatialFreq = [30]; 
Conditions(3).VelFunction = [1  0]; 
Conditions(3).PosFuncNameX =  'none' ; 
Conditions(3).VelFuncName =  'none' ; 
Conditions(3).NumConditions = [16]; 
Conditions(3).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(3).FuncFreqX = [50]; 
Conditions(3).PosFunctionY = [0  0]; 
Conditions(3).FuncFreqY = [50]; 
Conditions(3).Voltage = [0.23125]; 
Conditions(3).PosFuncNameY =  'null' ; 

% Front to back 9 Hz LEFT SIDE
Conditions(4).PatternID = [22]; 
Conditions(4).Duration = [3]; 
Conditions(4).InitialPosition = [1  3]; 
Conditions(4).Gains = [-96   0   0   0]; 
Conditions(4).Mode = [0  0]; 
Conditions(4).PosFunctionX = [1  0]; 
Conditions(4).PatternName =  'Pattern_32_rotation_left_half_gs3.mat' ; 
Conditions(4).SpatialFreq = [30]; 
Conditions(4).VelFunction = [1  0]; 
Conditions(4).PosFuncNameX =  'none' ; 
Conditions(4).VelFuncName =  'none' ; 
Conditions(4).NumConditions = [16]; 
Conditions(4).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(4).FuncFreqX = [50]; 
Conditions(4).PosFunctionY = [0  0]; 
Conditions(4).FuncFreqY = [50]; 
Conditions(4).Voltage = [0.32187]; 
Conditions(4).PosFuncNameY =  'null' ; 

%% Low Contrast Rotation

% 
Conditions(5).PatternID = [4]; 
Conditions(5).Duration = [3]; 
Conditions(5).InitialPosition = [1  4]; 
Conditions(5).Gains = [48   0   0   0]; 
Conditions(5).Mode = [0  0]; 
Conditions(5).PosFunctionX = [1  0]; 
Conditions(5).PatternName =  'Pattern_14_rotation_contrasts_48P_RC.mat' ; 
Conditions(5).SpatialFreq = [22.5]; 
Conditions(5).VelFunction = [1  0]; 
Conditions(5).PosFuncNameX =  'none' ;
Conditions(5).VelFuncName =  'none' ; 
Conditions(5).NumConditions = [16]; 
Conditions(5).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(5).FuncFreqX = [50]; 
Conditions(5).PosFunctionY = [0  0]; 
Conditions(5).FuncFreqY = [50]; 
Conditions(5).Voltage = [0.4125]; 
Conditions(5).PosFuncNameY =  'null' ; 

%
Conditions(6).PatternID = [4]; 
Conditions(6).Duration = [3]; 
Conditions(6).InitialPosition = [1  4]; 
Conditions(6).Gains = [-48   0   0   0]; 
Conditions(6).Mode = [0  0]; 
Conditions(6).PosFunctionX = [1  0]; 
Conditions(6).PatternName =  'Pattern_14_rotation_contrasts_48P_RC.mat' ; 
Conditions(6).SpatialFreq = [22.5]; 
Conditions(6).VelFunction = [1  0]; 
Conditions(6).PosFuncNameX =  'none' ; 
Conditions(6).VelFuncName =  'none' ; 
Conditions(6).NumConditions = [16]; 
Conditions(6).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(6).FuncFreqX = [50]; 
Conditions(6).PosFunctionY = [0  0]; 
Conditions(6).FuncFreqY = [50]; 
Conditions(6).Voltage = [0.50313]; 
Conditions(6).PosFuncNameY =  'null' ; 

%
Conditions(7).PatternID = [4]; 
Conditions(7).Duration = [3]; 
Conditions(7).InitialPosition = [1  5]; 
Conditions(7).Gains = [48   0   0   0]; 
Conditions(7).Mode = [0  0]; 
Conditions(7).PosFunctionX = [1  0]; 
Conditions(7).PatternName =  'Pattern_14_rotation_contrasts_48P_RC.mat' ; 
Conditions(7).SpatialFreq = [22.5]; 
Conditions(7).VelFunction = [1  0]; 
Conditions(7).PosFuncNameX =  'none' ; 
Conditions(7).VelFuncName =  'none' ; 
Conditions(7).NumConditions = [16]; 
Conditions(7).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(7).FuncFreqX = [50]; 
Conditions(7).PosFunctionY = [0  0]; 
Conditions(7).FuncFreqY = [50]; 
Conditions(7).Voltage = [0.59375]; 
Conditions(7).PosFuncNameY =  'null' ; 

%
Conditions(8).PatternID = [4]; 
Conditions(8).Duration = [3]; 
Conditions(8).InitialPosition = [1  5]; 
Conditions(8).Gains = [-48   0   0   0]; 
Conditions(8).Mode = [0  0]; 
Conditions(8).PosFunctionX = [1  0]; 
Conditions(8).PatternName =  'Pattern_14_rotation_contrasts_48P_RC.mat' ; 
Conditions(8).SpatialFreq = [22.5]; 
Conditions(8).VelFunction = [1  0]; 
Conditions(8).PosFuncNameX =  'none' ; 
Conditions(8).VelFuncName =  'none' ; 
Conditions(8).NumConditions = [16]; 
Conditions(8).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(8).FuncFreqX = [50]; 
Conditions(8).PosFunctionY = [0  0]; 
Conditions(8).FuncFreqY = [50]; 
Conditions(8).Voltage = [0.68438]; 
Conditions(8).PosFuncNameY =  'null' ; 

%% Reverse Phi stims.

Conditions(9).PatternID = [5]; 
Conditions(9).Duration = [3]; 
Conditions(9).InitialPosition = [1  1]; 
Conditions(9).Gains = [24   0   0   0]; 
Conditions(9).Mode = [0  0]; 
Conditions(9).PosFunctionX = [1  0]; 
Conditions(9).PatternName =  'Pattern_15_rp_rotation_sf_48P_RC.mat' ; 
Conditions(9).SpatialFreq = [30]; 
Conditions(9).VelFunction = [1  0]; 
Conditions(9).PosFuncNameX =  'none' ; 
Conditions(9).VelFuncName =  'none' ; 
Conditions(9).NumConditions = [16]; 
Conditions(9).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(9).FuncFreqX = [50]; 
Conditions(9).PosFunctionY = [0  0]; 
Conditions(9).FuncFreqY = [50]; 
Conditions(9).Voltage = [0.775]; 
Conditions(9).PosFuncNameY =  'null' ; 

Conditions(10).PatternID = [5]; 
Conditions(10).Duration = [3]; 
Conditions(10).InitialPosition = [1  1]; 
Conditions(10).Gains = [-24   0   0   0]; 
Conditions(10).Mode = [0  0]; 
Conditions(10).PosFunctionX = [1  0]; 
Conditions(10).PatternName =  'Pattern_15_rp_rotation_sf_48P_RC.mat' ; 
Conditions(10).SpatialFreq = [30]; 
Conditions(10).VelFunction = [1  0]; 
Conditions(10).PosFuncNameX =  'none' ; 
Conditions(10).VelFuncName =  'none' ; 
Conditions(10).NumConditions = [16]; 
Conditions(10).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(10).FuncFreqX = [50]; 
Conditions(10).PosFunctionY = [0  0]; 
Conditions(10).FuncFreqY = [50]; 
Conditions(10).Voltage = [0.86562]; 
Conditions(10).PosFuncNameY =  'null' ; 

%% Stripe tracking

Conditions(11).PatternID = [10]; 
Conditions(11).Duration = [3]; 
Conditions(11).InitialPosition = [47   1]; 
Conditions(11).Gains = [0  0  0  0]; 
Conditions(11).Mode = [4  0]; 
Conditions(11).PosFunctionX = [1  9]; 
Conditions(11).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(11).SpatialFreq = [0]; 
Conditions(11).VelFunction = [1  0]; 
Conditions(11).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_1.mat' ; 
Conditions(11).VelFuncName =  'none' ; 
Conditions(11).NumConditions = [16]; 
Conditions(11).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(11).FuncFreqX = [50]; 
Conditions(11).PosFunctionY = [0  0]; 
Conditions(11).FuncFreqY = [50]; 
Conditions(11).Voltage = [0.95625]; 
Conditions(11).PosFuncNameY =  'null' ; 

Conditions(12).PatternID = [10]; 
Conditions(12).Duration = [3]; 
Conditions(12).InitialPosition = [47   1]; 
Conditions(12).Gains = [0  0  0  0]; 
Conditions(12).Mode = [4  0]; 
Conditions(12).PosFunctionX = [1  10]; 
Conditions(12).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(12).SpatialFreq = [0]; 
Conditions(12).VelFunction = [1  0]; 
Conditions(12).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_2.mat' ; 
Conditions(12).VelFuncName =  'none' ; 
Conditions(12).NumConditions = [16]; 
Conditions(12).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(12).FuncFreqX = [50]; 
Conditions(12).PosFunctionY = [0  0]; 
Conditions(12).FuncFreqY = [50]; 
Conditions(12).Voltage = [1.0469]; 
Conditions(12).PosFuncNameY =  'null' ; 

Conditions(13).PatternID = [10]; 
Conditions(13).Duration = [3]; 
Conditions(13).InitialPosition = [47   2]; 
Conditions(13).Gains = [0  0  0  0]; 
Conditions(13).Mode = [4  0]; 
Conditions(13).PosFunctionX = [1  9]; 
Conditions(13).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(13).SpatialFreq = [0]; 
Conditions(13).VelFunction = [1  0]; 
Conditions(13).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_1.mat' ; 
Conditions(13).VelFuncName =  'none' ; 
Conditions(13).NumConditions = [16]; 
Conditions(13).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(13).FuncFreqX = [50]; 
Conditions(13).PosFunctionY = [0  0]; 
Conditions(13).FuncFreqY = [50]; 
Conditions(13).Voltage = [1.1375]; 
Conditions(13).PosFuncNameY =  'null' ; 

Conditions(14).PatternID = [10]; 
Conditions(14).Duration = [3]; 
Conditions(14).InitialPosition = [47   2]; 
Conditions(14).Gains = [0  0  0  0]; 
Conditions(14).Mode = [4  0]; 
Conditions(14).PosFunctionX = [1  10]; 
Conditions(14).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(14).SpatialFreq = [0]; 
Conditions(14).VelFunction = [1  0]; 
Conditions(14).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_2.mat' ; 
Conditions(14).VelFuncName =  'none' ; 
Conditions(14).NumConditions = [16]; 
Conditions(14).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(14).FuncFreqX = [50]; 
Conditions(14).PosFunctionY = [0  0]; 
Conditions(14).FuncFreqY = [50]; 
Conditions(14).Voltage = [1.2281]; 
Conditions(14).PosFuncNameY =  'null' ; 

Conditions(15).PatternID = [10]; 
Conditions(15).Duration = [3]; 
Conditions(15).InitialPosition = [47   3]; 
Conditions(15).Gains = [0  0  0  0]; 
Conditions(15).Mode = [4  0]; 
Conditions(15).PosFunctionX = [1  9]; 
Conditions(15).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(15).SpatialFreq = [0]; 
Conditions(15).VelFunction = [1  0]; 
Conditions(15).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_1.mat' ; 
Conditions(15).VelFuncName =  'none' ; 
Conditions(15).NumConditions = [16]; 
Conditions(15).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(15).FuncFreqX = [50]; 
Conditions(15).PosFunctionY = [0  0]; 
Conditions(15).FuncFreqY = [50]; 
Conditions(15).Voltage = [1.3188]; 
Conditions(15).PosFuncNameY =  'null' ; 

Conditions(16).PatternID = [10]; 
Conditions(16).Duration = [3]; 
Conditions(16).InitialPosition = [47   3]; 
Conditions(16).Gains = [0  0  0  0]; 
Conditions(16).Mode = [4  0]; 
Conditions(16).PosFunctionX = [1  10]; 
Conditions(16).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat' ; 
Conditions(16).SpatialFreq = [0]; 
Conditions(16).VelFunction = [1  0]; 
Conditions(16).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_2.mat' ; 
Conditions(16).VelFuncName =  'none' ; 
Conditions(16).NumConditions = [16]; 
Conditions(16).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14' ; 
Conditions(16).FuncFreqX = [50]; 
Conditions(16).PosFunctionY = [0  0]; 
Conditions(16).FuncFreqY = [50]; 
Conditions(16).Voltage = [1.4094]; 
Conditions(16).PosFuncNameY =  'null' ; 

Conditions(17).PatternID = [10];
Conditions(17).Duration = [3];
Conditions(17).InitialPosition = [47   3]; 
Conditions(17).Gains = [0  0  0  0];
Conditions(17).Mode = [4  0];
Conditions(17).PosFunctionX = [1  10];
Conditions(17).PatternName =  'Pattern_20_4wide_stripes_48P_RC.mat';
Conditions(17).SpatialFreq = [0];
Conditions(17).VelFunction = [1  0];
Conditions(17).PosFuncNameX =  'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
Conditions(17).VelFuncName =  'none';
Conditions(17).NumConditions = [16];
Conditions(17).PosFuncLoc =  'R:\Telethon_Database\functions\telethon_pos_funcs_09_14';
Conditions(17).FuncFreqX = [50];
Conditions(17).PosFunctionY = [0  0];
Conditions(17).FuncFreqY = [50];
Conditions(17).Voltage = [1.52];
Conditions(17).PosFuncNameY =  'null';
