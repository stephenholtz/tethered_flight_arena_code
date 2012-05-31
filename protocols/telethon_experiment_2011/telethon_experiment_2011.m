function Conditions = telethon_experiment_2011
%TELETHON_EXPERIMENT_2011 johns full telethon protocol all in one function.
% It uses the same patterns and functions as
% short_telethon_experiment_2011. All closed loop interval trial times are
% 3.5 seconds. (This also accounts for the extra conditions in the google
% doc not 'listed' here).
% All 130 experimental conditions are linearly spaced from .1 to 9.9 volts.
% closed loop portion is set to zero. 

%% from telethon_vel_nulling_conditions_9_14 
Conditions(1).PatternID = 6;
Conditions(1).Duration = 3;
Conditions(1).InitialPosition = [1 1];
Conditions(1).Gains = [4 -48 0 0];
Conditions(1).Mode = [0 0];
Conditions(1).PosFunctionX = [1 0];
Conditions(1).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(1).SpatialFreq = 22.5000;
Conditions(1).PosFuncNameX = 'none';
Conditions(1).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(2).PatternID = 6;
Conditions(2).Duration = 3;
Conditions(2).InitialPosition = [1 1];
Conditions(2).Gains = [-4 48 0 0];
Conditions(2).Mode = [0 0];
Conditions(2).PosFunctionX = [1 0];
Conditions(2).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(2).SpatialFreq = 22.5000;
Conditions(2).PosFuncNameX = 'none';
Conditions(2).PosFuncLoc = 'R:\Telehon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(3).PatternID = 7;
Conditions(3).Duration = 3;
Conditions(3).InitialPosition = [1 1];
Conditions(3).Gains = [4 -48 0 0];
Conditions(3).Mode = [0 0];
Conditions(3).PosFunctionX = [1 0];
Conditions(3).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(3).SpatialFreq = 22.5000;
Conditions(3).PosFuncNameX = 'none';
Conditions(3).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(4).PatternID = 7;
Conditions(4).Duration = 3;
Conditions(4).InitialPosition = [1 1];
Conditions(4).Gains = [-4 48 0 0];
Conditions(4).Mode = [0 0];
Conditions(4).PosFunctionX = [1 0];
Conditions(4).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(4).SpatialFreq = 22.5000;
Conditions(4).PosFuncNameX = 'none';
Conditions(4).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14';
%
Conditions(5).PatternID = 8;
Conditions(5).Duration = 3;
Conditions(5).InitialPosition = [1 1];
Conditions(5).Gains = [4 -48 0 0];
Conditions(5).Mode = [0 0];
Conditions(5).PosFunctionX = [1 0];
Conditions(5).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(5).SpatialFreq = 22.5000;
Conditions(5).PosFuncNameX = 'none';
Conditions(5).PosFuncLoc = 'R:\Telehon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(6).PatternID = 8;
Conditions(6).Duration = 3;
Conditions(6).InitialPosition = [1 1];
Conditions(6).Gains = [-4 48 0 0];
Conditions(6).Mode = [0 0];
Conditions(6).PosFunctionX = [1 0];
Conditions(6).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(6).SpatialFreq = 22.5000;
Conditions(6).PosFuncNameX = 'none';
Conditions(6).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(7).PatternID = 6;
Conditions(7).Duration = 3;
Conditions(7).InitialPosition = [1 1];
Conditions(7).Gains = [16 -48 0 0];
Conditions(7).Mode = [0 0];
Conditions(7).PosFunctionX = [1 0];
Conditions(7).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(7).SpatialFreq = 22.5000;
Conditions(7).PosFuncNameX = 'none';
Conditions(7).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(8).PatternID = 6;
Conditions(8).Duration = 3;
Conditions(8).InitialPosition = [1 1];
Conditions(8).Gains = [-16 48 0 0];
Conditions(8).Mode = [0 0];
Conditions(8).PosFunctionX = [1 0];
Conditions(8).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(8).SpatialFreq = 22.5000;
Conditions(8).PosFuncNameX = 'none';
Conditions(8).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(9).PatternID = 7;
Conditions(9).Duration = 3;
Conditions(9).InitialPosition = [1 1];
Conditions(9).Gains = [16 -48 0 0];
Conditions(9).Mode = [0 0];
Conditions(9).PosFunctionX = [1 0];
Conditions(9).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(9).SpatialFreq = 22.5000;
Conditions(9).PosFuncNameX = 'none';
Conditions(9).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(10).PatternID = 7;
Conditions(10).Duration = 3;
Conditions(10).InitialPosition = [1 1];
Conditions(10).Gains = [-16 48 0 0];
Conditions(10).Mode = [0 0];
Conditions(10).PosFunctionX = [1 0];
Conditions(10).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(10).SpatialFreq = 22.5000;
Conditions(10).PosFuncNameX = 'none';
Conditions(10).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(11).PatternID = 8;
Conditions(11).Duration = 3;
Conditions(11).InitialPosition = [1 1];
Conditions(11).Gains = [16 -48 0 0];
Conditions(11).Mode = [0 0];
Conditions(11).PosFunctionX = [1 0];
Conditions(11).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(11).SpatialFreq = 22.5000;
Conditions(11).PosFuncNameX = 'none';
Conditions(11).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(12).PatternID = 8;
Conditions(12).Duration = 3;
Conditions(12).InitialPosition = [1 1];
Conditions(12).Gains = [-16 48 0 0];
Conditions(12).Mode = [0 0];
Conditions(12).PosFunctionX = [1 0];
Conditions(12).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(12).SpatialFreq = 22.5000;
Conditions(12).PosFuncNameX = 'none';
Conditions(12).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(13).PatternID = 6;
Conditions(13).Duration = 3;
Conditions(13).InitialPosition = [1 1];
Conditions(13).Gains = [64 -48 0 0];
Conditions(13).Mode = [0 0];
Conditions(13).PosFunctionX = [1 0];
Conditions(13).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(13).SpatialFreq = 22.5000;
Conditions(13).PosFuncNameX = 'none';
Conditions(13).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(14).PatternID = 6;
Conditions(14).Duration = 3;
Conditions(14).InitialPosition = [1 1];
Conditions(14).Gains = [-64 48 0 0];
Conditions(14).Mode = [0 0];
Conditions(14).PosFunctionX = [1 0];
Conditions(14).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(14).SpatialFreq = 22.5000;
Conditions(14).PosFuncNameX = 'none';
Conditions(14).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(15).PatternID = 7;
Conditions(15).Duration = 3;
Conditions(15).InitialPosition = [1 1];
Conditions(15).Gains = [64 -48 0 0];
Conditions(15).Mode = [0 0];
Conditions(15).PosFunctionX = [1 0];
Conditions(15).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(15).SpatialFreq = 22.5000;
Conditions(15).PosFuncNameX = 'none';
Conditions(15).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(16).PatternID = 7;
Conditions(16).Duration = 3;
Conditions(16).InitialPosition = [1 1];
Conditions(16).Gains = [-64 48 0 0];
Conditions(16).Mode = [0 0];
Conditions(16).PosFunctionX = [1 0];
Conditions(16).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(16).SpatialFreq = 22.5000;
Conditions(16).PosFuncNameX = 'none';
Conditions(16).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(17).PatternID = 8;
Conditions(17).Duration = 3;
Conditions(17).InitialPosition = [1 1];
Conditions(17).Gains = [64 -48 0 0];
Conditions(17).Mode = [0 0];
Conditions(17).PosFunctionX = [1 0];
Conditions(17).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(17).SpatialFreq = 22.5000;
Conditions(17).PosFuncNameX = 'none';
Conditions(17).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(18).PatternID = 8;
Conditions(18).Duration = 3;
Conditions(18).InitialPosition = [1 1];
Conditions(18).Gains = [-64 48 0 0];
Conditions(18).Mode = [0 0];
Conditions(18).PosFunctionX = [1 0];
Conditions(18).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(18).SpatialFreq = 22.5000;
Conditions(18).PosFuncNameX = 'none';
Conditions(18).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(19).PatternID = 6;
Conditions(19).Duration = 3;
Conditions(19).InitialPosition = [1 1];
Conditions(19).Gains = [128 -48 0 0];
Conditions(19).Mode = [0 0];
Conditions(19).PosFunctionX = [1 0];
Conditions(19).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(19).SpatialFreq = 22.5000;
Conditions(19).PosFuncNameX = 'none';
Conditions(19).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(20).PatternID = 6;
Conditions(20).Duration = 3;
Conditions(20).InitialPosition = [1 1];
Conditions(20).Gains = [-128 48 0 0];
Conditions(20).Mode = [0 0];
Conditions(20).PosFunctionX = [1 0];
Conditions(20).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(20).SpatialFreq = 22.5000;
Conditions(20).PosFuncNameX = 'none';
Conditions(20).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(21).PatternID = 7;
Conditions(21).Duration = 3;
Conditions(21).InitialPosition = [1 1];
Conditions(21).Gains = [128 -48 0 0];
Conditions(21).Mode = [0 0];
Conditions(21).PosFunctionX = [1 0];
Conditions(21).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(21).SpatialFreq = 22.5000;
Conditions(21).PosFuncNameX = 'none';
Conditions(21).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(22).PatternID = 7;
Conditions(22).Duration = 3;
Conditions(22).InitialPosition = [1 1];
Conditions(22).Gains = [-128 48 0 0];
Conditions(22).Mode = [0 0];
Conditions(22).PosFunctionX = [1 0];
Conditions(22).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(22).SpatialFreq = 22.5000;
Conditions(22).PosFuncNameX = 'none';
Conditions(22).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(23).PatternID = 8;
Conditions(23).Duration = 3;
Conditions(23).InitialPosition = [1 1];
Conditions(23).Gains = [128 -48 0 0];
Conditions(23).Mode = [0 0];
Conditions(23).PosFunctionX = [1 0];
Conditions(23).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(23).SpatialFreq = 22.5000;
Conditions(23).PosFuncNameX = 'none';
Conditions(23).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(24).PatternID = 8;
Conditions(24).Duration = 3;
Conditions(24).InitialPosition = [1 1];
Conditions(24).Gains = [-128 48 0 0];
Conditions(24).Mode = [0 0];
Conditions(24).PosFunctionX = [1 0];
Conditions(24).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(24).SpatialFreq = 22.5000;
Conditions(24).PosFuncNameX = 'none';
Conditions(24).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(25).PatternID = 6;
Conditions(25).Duration = 3;
Conditions(25).InitialPosition = [1 1];
Conditions(25).Gains = [192 -48 0 0];
Conditions(25).Mode = [0 0];
Conditions(25).PosFunctionX = [1 0];
Conditions(25).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(25).SpatialFreq = 22.5000;
Conditions(25).PosFuncNameX = 'none';
Conditions(25).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(26).PatternID = 6;
Conditions(26).Duration = 3;
Conditions(26).InitialPosition = [1 1];
Conditions(26).Gains = [-192 48 0 0];
Conditions(26).Mode = [0 0];
Conditions(26).PosFunctionX = [1 0];
Conditions(26).PatternName = 'Pattern_16_nulling_6wide_rotation_74_65.mat';
Conditions(26).SpatialFreq = 22.5000;
Conditions(26).PosFuncNameX = 'none';
Conditions(26).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(27).PatternID = 7;
Conditions(27).Duration = 3;
Conditions(27).InitialPosition = [1 1];
Conditions(27).Gains = [192 -48 0 0];
Conditions(27).Mode = [0 0];
Conditions(27).PosFunctionX = [1 0];
Conditions(27).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(27).SpatialFreq = 22.5000;
Conditions(27).PosFuncNameX = 'none';
Conditions(27).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(28).PatternID = 7;
Conditions(28).Duration = 3;
Conditions(28).InitialPosition = [1 1];
Conditions(28).Gains = [-192 48 0 0];
Conditions(28).Mode = [0 0];
Conditions(28).PosFunctionX = [1 0];
Conditions(28).PatternName = 'Pattern_17_nulling_6wide_rotation_74_74.mat';
Conditions(28).SpatialFreq = 22.5000;
Conditions(28).PosFuncNameX = 'none';
Conditions(28).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(29).PatternID = 8;
Conditions(29).Duration = 3;
Conditions(29).InitialPosition = [1 1];
Conditions(29).Gains = [192 -48 0 0];
Conditions(29).Mode = [0 0];
Conditions(29).PosFunctionX = [1 0];
Conditions(29).PatternName = 'Pattern_18_nulling_6wide_rotation_74_83.mat';
Conditions(29).SpatialFreq = 22.5000;
Conditions(29).PosFuncNameX = 'none';
Conditions(29).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 

%% from telethon_tuning_shorter_conditions_9_14 
Conditions(30).PatternID = 2;
Conditions(30).Duration = 3;
Conditions(30).InitialPosition = [1 2];
Conditions(30).Gains = [4 0 0 0];
Conditions(30).Mode = [0 0];
Conditions(30).PosFunctionX = [1 0];
Conditions(30).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(30).SpatialFreq = 30;
Conditions(30).PosFuncNameX = 'none';
Conditions(30).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(31).PatternID = 2;
Conditions(31).Duration = 3;
Conditions(31).InitialPosition = [1 2];
Conditions(31).Gains = [-4 0 0 0];
Conditions(31).Mode = [0 0];
Conditions(31).PosFunctionX = [1 0];
Conditions(31).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(31).SpatialFreq = 30;
Conditions(31).PosFuncNameX = 'none';
Conditions(31).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(32).PatternID = 2;
Conditions(32).Duration = 3;
Conditions(32).InitialPosition = [1 2];
Conditions(32).Gains = [24 0 0 0];
Conditions(32).Mode = [0 0];
Conditions(32).PosFunctionX = [1 0];
Conditions(32).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(32).SpatialFreq = 30;
Conditions(32).PosFuncNameX = 'none';
Conditions(32).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(33).PatternID = 2;
Conditions(33).Duration = 3;
Conditions(33).InitialPosition = [1 2];
Conditions(33).Gains = [-24 0 0 0];
Conditions(33).Mode = [0 0];
Conditions(33).PosFunctionX = [1 0];
Conditions(33).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(33).SpatialFreq = 30;
Conditions(33).PosFuncNameX = 'none';
Conditions(33).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(34).PatternID = 2;
Conditions(34).Duration = 3;
Conditions(34).InitialPosition = [1 2];
Conditions(34).Gains = [72 0 0 0];
Conditions(34).Mode = [0 0];
Conditions(34).PosFunctionX = [1 0];
Conditions(34).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(34).SpatialFreq = 30;
Conditions(34).PosFuncNameX = 'none';
Conditions(34).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(35).PatternID = 2;
Conditions(35).Duration = 3;
Conditions(35).InitialPosition = [1 2];
Conditions(35).Gains = [-72 0 0 0];
Conditions(35).Mode = [0 0];
Conditions(35).PosFunctionX = [1 0];
Conditions(35).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(35).SpatialFreq = 30;
Conditions(35).PosFuncNameX = 'none';
Conditions(35).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(36).PatternID = 2;
Conditions(36).Duration = 3;
Conditions(36).InitialPosition = [1 2];
Conditions(36).Gains = [144 0 0 0];
Conditions(36).Mode = [0 0];
Conditions(36).PosFunctionX = [1 0];
Conditions(36).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(36).SpatialFreq = 30;
Conditions(36).PosFuncNameX = 'none';
Conditions(36).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(37).PatternID = 2;
Conditions(37).Duration = 3;
Conditions(37).InitialPosition = [1 2];
Conditions(37).Gains = [-144 0 0 0];
Conditions(37).Mode = [0 0];
Conditions(37).PosFunctionX = [1 0];
Conditions(37).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(37).SpatialFreq = 30;
Conditions(37).PosFuncNameX = 'none';
Conditions(37).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(38).PatternID = 4;
Conditions(38).Duration = 3;
Conditions(38).InitialPosition = [1 2];
Conditions(38).Gains = [48 0 0 0];
Conditions(38).Mode = [0 0];
Conditions(38).PosFunctionX = [1 0];
Conditions(38).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(38).SpatialFreq = 22.5000;
Conditions(38).PosFuncNameX = 'none';
Conditions(38).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(39).PatternID = 4;
Conditions(39).Duration = 3;
Conditions(39).InitialPosition = [1 2];
Conditions(39).Gains = [-48 0 0 0];
Conditions(39).Mode = [0 0];
Conditions(39).PosFunctionX = [1 0];
Conditions(39).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(39).SpatialFreq = 22.5000;
Conditions(39).PosFuncNameX = 'none';
Conditions(39).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(40).PatternID = 4;
Conditions(40).Duration = 3;
Conditions(40).InitialPosition = [1 3];
Conditions(40).Gains = [48 0 0 0];
Conditions(40).Mode = [0 0];
Conditions(40).PosFunctionX = [1 0];
Conditions(40).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(40).SpatialFreq = 22.5000;
Conditions(40).PosFuncNameX = 'none';
Conditions(40).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(41).PatternID = 4;
Conditions(41).Duration = 3;
Conditions(41).InitialPosition = [1 3];
Conditions(41).Gains = [-48 0 0 0];
Conditions(41).Mode = [0 0];
Conditions(41).PosFunctionX = [1 0];
Conditions(41).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(41).SpatialFreq = 22.5000;
Conditions(41).PosFuncNameX = 'none';
Conditions(41).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(42).PatternID = 4;
Conditions(42).Duration = 3;
Conditions(42).InitialPosition = [1 4];
Conditions(42).Gains = [48 0 0 0];
Conditions(42).Mode = [0 0];
Conditions(42).PosFunctionX = [1 0];
Conditions(42).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(42).SpatialFreq = 22.5000;
Conditions(42).PosFuncNameX = 'none';
Conditions(42).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(43).PatternID = 4;
Conditions(43).Duration = 3;
Conditions(43).InitialPosition = [1 4];
Conditions(43).Gains = [-48 0 0 0];
Conditions(43).Mode = [0 0];
Conditions(43).PosFunctionX = [1 0];
Conditions(43).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(43).SpatialFreq = 22.5000;
Conditions(43).PosFuncNameX = 'none';
Conditions(43).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(44).PatternID = 4;
Conditions(44).Duration = 3;
Conditions(44).InitialPosition = [1 5];
Conditions(44).Gains = [48 0 0 0];
Conditions(44).Mode = [0 0];
Conditions(44).PosFunctionX = [1 0];
Conditions(44).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(44).SpatialFreq = 22.5000;
Conditions(44).PosFuncNameX = 'none';
Conditions(44).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
%% from telethon_tuning_conditions_9_14 
Conditions(45).PatternID = 2;
Conditions(45).Duration = 3;
Conditions(45).InitialPosition = [1 1];
Conditions(45).Gains = [4 0 0 0];
Conditions(45).Mode = [0 0];
Conditions(45).PosFunctionX = [1 0];
Conditions(45).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(45).SpatialFreq = 30;
Conditions(45).PosFuncNameX = 'none';
Conditions(45).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(46).PatternID = 2;
Conditions(46).Duration = 3;
Conditions(46).InitialPosition = [1 1];
Conditions(46).Gains = [-4 0 0 0];
Conditions(46).Mode = [0 0];
Conditions(46).PosFunctionX = [1 0];
Conditions(46).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(46).SpatialFreq = 30;
Conditions(46).PosFuncNameX = 'none';
Conditions(46).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(47).PatternID = 2;
Conditions(47).Duration = 3;
Conditions(47).InitialPosition = [1 1];
Conditions(47).Gains = [24 0 0 0];
Conditions(47).Mode = [0 0];
Conditions(47).PosFunctionX = [1 0];
Conditions(47).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(47).SpatialFreq = 30;
Conditions(47).PosFuncNameX = 'none';
Conditions(47).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(48).PatternID = 2;
Conditions(48).Duration = 3;
Conditions(48).InitialPosition = [1 1];
Conditions(48).Gains = [-24 0 0 0];
Conditions(48).Mode = [0 0];
Conditions(48).PosFunctionX = [1 0];
Conditions(48).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(48).SpatialFreq = 30;
Conditions(48).PosFuncNameX = 'none';
Conditions(48).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(49).PatternID = 2;
Conditions(49).Duration = 3;
Conditions(49).InitialPosition = [1 1];
Conditions(49).Gains = [72 0 0 0];
Conditions(49).Mode = [0 0];
Conditions(49).PosFunctionX = [1 0];
Conditions(49).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(49).SpatialFreq = 30;
Conditions(49).PosFuncNameX = 'none';
Conditions(49).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(50).PatternID = 2;
Conditions(50).Duration = 3;
Conditions(50).InitialPosition = [1 1];
Conditions(50).Gains = [-72 0 0 0];
Conditions(50).Mode = [0 0];
Conditions(50).PosFunctionX = [1 0];
Conditions(50).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(50).SpatialFreq = 30;
Conditions(50).PosFuncNameX = 'none';
Conditions(50).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(51).PatternID = 2;
Conditions(51).Duration = 3;
Conditions(51).InitialPosition = [1 1];
Conditions(51).Gains = [144 0 0 0];
Conditions(51).Mode = [0 0];
Conditions(51).PosFunctionX = [1 0];
Conditions(51).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(51).SpatialFreq = 30;
Conditions(51).PosFuncNameX = 'none';
Conditions(51).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(52).PatternID = 2;
Conditions(52).Duration = 3;
Conditions(52).InitialPosition = [1 1];
Conditions(52).Gains = [-144 0 0 0];
Conditions(52).Mode = [0 0];
Conditions(52).PosFunctionX = [1 0];
Conditions(52).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(52).SpatialFreq = 30;
Conditions(52).PosFuncNameX = 'none';
Conditions(52).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(53).PatternID = 2;
Conditions(53).Duration = 3;
Conditions(53).InitialPosition = [1 3];
Conditions(53).Gains = [4 0 0 0];
Conditions(53).Mode = [0 0];
Conditions(53).PosFunctionX = [1 0];
Conditions(53).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(53).SpatialFreq = 45;
Conditions(53).PosFuncNameX = 'none';
Conditions(53).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(54).PatternID = 2;
Conditions(54).Duration = 3;
Conditions(54).InitialPosition = [1 3];
Conditions(54).Gains = [-4 0 0 0];
Conditions(54).Mode = [0 0];
Conditions(54).PosFunctionX = [1 0];
Conditions(54).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(54).SpatialFreq = 45;
Conditions(54).PosFuncNameX = 'none';
Conditions(54).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(55).PatternID = 2;
Conditions(55).Duration = 3;
Conditions(55).InitialPosition = [1 3];
Conditions(55).Gains = [24 0 0 0];
Conditions(55).Mode = [0 0];
Conditions(55).PosFunctionX = [1 0];
Conditions(55).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(55).SpatialFreq = 45;
Conditions(55).PosFuncNameX = 'none';
Conditions(55).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(56).PatternID = 2;
Conditions(56).Duration = 3;
Conditions(56).InitialPosition = [1 3];
Conditions(56).Gains = [-24 0 0 0];
Conditions(56).Mode = [0 0];
Conditions(56).PosFunctionX = [1 0];
Conditions(56).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(56).SpatialFreq = 45;
Conditions(56).PosFuncNameX = 'none';
Conditions(56).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(57).PatternID = 2;
Conditions(57).Duration = 3;
Conditions(57).InitialPosition = [1 3];
Conditions(57).Gains = [72 0 0 0];
Conditions(57).Mode = [0 0];
Conditions(57).PosFunctionX = [1 0];
Conditions(57).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(57).SpatialFreq = 45;
Conditions(57).PosFuncNameX = 'none';
Conditions(57).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(58).PatternID = 2;
Conditions(58).Duration = 3;
Conditions(58).InitialPosition = [1 3];
Conditions(58).Gains = [-72 0 0 0];
Conditions(58).Mode = [0 0];
Conditions(58).PosFunctionX = [1 0];
Conditions(58).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(58).SpatialFreq = 45;
Conditions(58).PosFuncNameX = 'none';
Conditions(58).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(59).PatternID = 2;
Conditions(59).Duration = 3;
Conditions(59).InitialPosition = [1 3];
Conditions(59).Gains = [144 0 0 0];
Conditions(59).Mode = [0 0];
Conditions(59).PosFunctionX = [1 0];
Conditions(59).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(59).SpatialFreq = 45;
Conditions(59).PosFuncNameX = 'none';
Conditions(59).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(60).PatternID = 2;
Conditions(60).Duration = 3;
Conditions(60).InitialPosition = [1 3];
Conditions(60).Gains = [-144 0 0 0];
Conditions(60).Mode = [0 0];
Conditions(60).PosFunctionX = [1 0];
Conditions(60).PatternName = {'Pattern_12_rotation_sf_48P_RC.mat'};
Conditions(60).SpatialFreq = 45;
Conditions(60).PosFuncNameX = 'none';
Conditions(60).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(61).PatternID = 3;
Conditions(61).Duration = 3;
Conditions(61).InitialPosition = [1 1];
Conditions(61).Gains = [4 0 0 0];
Conditions(61).Mode = [0 0];
Conditions(61).PosFunctionX = [1 0];
Conditions(61).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(61).SpatialFreq = 30;
Conditions(61).PosFuncNameX = 'none';
Conditions(61).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(62).PatternID = 3;
Conditions(62).Duration = 3;
Conditions(62).InitialPosition = [1 1];
Conditions(62).Gains = [-4 0 0 0];
Conditions(62).Mode = [0 0];
Conditions(62).PosFunctionX = [1 0];
Conditions(62).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(62).SpatialFreq = 30;
Conditions(62).PosFuncNameX = 'none';
Conditions(62).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(63).PatternID = 3;
Conditions(63).Duration = 3;
Conditions(63).InitialPosition = [1 1];
Conditions(63).Gains = [72 0 0 0];
Conditions(63).Mode = [0 0];
Conditions(63).PosFunctionX = [1 0];
Conditions(63).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(63).SpatialFreq = 30;
Conditions(63).PosFuncNameX = 'none';
Conditions(63).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(64).PatternID = 3;
Conditions(64).Duration = 3;
Conditions(64).InitialPosition = [1 1];
Conditions(64).Gains = [-72 0 0 0];
Conditions(64).Mode = [0 0];
Conditions(64).PosFunctionX = [1 0];
Conditions(64).PatternName = {'Pattern_13_expansion_48P_RC.mat'};
Conditions(64).SpatialFreq = 30;
Conditions(64).PosFuncNameX = 'none';
Conditions(64).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(65).PatternID = 4;
Conditions(65).Duration = 3;
Conditions(65).InitialPosition = [1 2];
Conditions(65).Gains = [48 0 0 0];
Conditions(65).Mode = [0 0];
Conditions(65).PosFunctionX = [1 0];
Conditions(65).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(65).SpatialFreq = 22.5000;
Conditions(65).PosFuncNameX = 'none';
Conditions(65).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(66).PatternID = 4;
Conditions(66).Duration = 3;
Conditions(66).InitialPosition = [1 2];
Conditions(66).Gains = [-48 0 0 0];
Conditions(66).Mode = [0 0];
Conditions(66).PosFunctionX = [1 0];
Conditions(66).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(66).SpatialFreq = 22.5000;
Conditions(66).PosFuncNameX = 'none';
Conditions(66).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(67).PatternID = 4;
Conditions(67).Duration = 3;
Conditions(67).InitialPosition = [1 3];
Conditions(67).Gains = [48 0 0 0];
Conditions(67).Mode = [0 0];
Conditions(67).PosFunctionX = [1 0];
Conditions(67).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(67).SpatialFreq = 22.5000;
Conditions(67).PosFuncNameX = 'none';
Conditions(67).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(68).PatternID = 4;
Conditions(68).Duration = 3;
Conditions(68).InitialPosition = [1 3];
Conditions(68).Gains = [-48 0 0 0];
Conditions(68).Mode = [0 0];
Conditions(68).PosFunctionX = [1 0];
Conditions(68).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(68).SpatialFreq = 22.5000;
Conditions(68).PosFuncNameX = 'none';
Conditions(68).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(69).PatternID = 4;
Conditions(69).Duration = 3;
Conditions(69).InitialPosition = [1 4];
Conditions(69).Gains = [48 0 0 0];
Conditions(69).Mode = [0 0];
Conditions(69).PosFunctionX = [1 0];
Conditions(69).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(69).SpatialFreq = 22.5000;
Conditions(69).PosFuncNameX = 'none';
Conditions(69).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(70).PatternID = 4;
Conditions(70).Duration = 3;
Conditions(70).InitialPosition = [1 4];
Conditions(70).Gains = [-48 0 0 0];
Conditions(70).Mode = [0 0];
Conditions(70).PosFunctionX = [1 0];
Conditions(70).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(70).SpatialFreq = 22.5000;
Conditions(70).PosFuncNameX = 'none';
Conditions(70).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(71).PatternID = 4;
Conditions(71).Duration = 3;
Conditions(71).InitialPosition = [1 5];
Conditions(71).Gains = [48 0 0 0];
Conditions(71).Mode = [0 0];
Conditions(71).PosFunctionX = [1 0];
Conditions(71).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(71).SpatialFreq = 22.5000;
Conditions(71).PosFuncNameX = 'none';
Conditions(71).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(72).PatternID = 4;
Conditions(72).Duration = 3;
Conditions(72).InitialPosition = [1 5];
Conditions(72).Gains = [-48 0 0 0];
Conditions(72).Mode = [0 0];
Conditions(72).PosFunctionX = [1 0];
Conditions(72).PatternName = {'Pattern_14_rotation_contrasts_48P_RC.mat'};
Conditions(72).SpatialFreq = 22.5000;
Conditions(72).PosFuncNameX = 'none';
Conditions(72).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(73).PatternID = 5;
Conditions(73).Duration = 3;
Conditions(73).InitialPosition = [1 1];
Conditions(73).Gains = [8 0 0 0];
Conditions(73).Mode = [0 0];
Conditions(73).PosFunctionX = [1 0];
Conditions(73).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(73).SpatialFreq = 30;
Conditions(73).PosFuncNameX = 'none';
Conditions(73).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(74).PatternID = 5;
Conditions(74).Duration = 3;
Conditions(74).InitialPosition = [1 1];
Conditions(74).Gains = [-8 0 0 0];
Conditions(74).Mode = [0 0];
Conditions(74).PosFunctionX = [1 0];
Conditions(74).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(74).SpatialFreq = 30;
Conditions(74).PosFuncNameX = 'none';
Conditions(74).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(75).PatternID = 5;
Conditions(75).Duration = 3;
Conditions(75).InitialPosition = [1 1];
Conditions(75).Gains = [24 0 0 0];
Conditions(75).Mode = [0 0];
Conditions(75).PosFunctionX = [1 0];
Conditions(75).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(75).SpatialFreq = 30;
Conditions(75).PosFuncNameX = 'none';
Conditions(75).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(76).PatternID = 5;
Conditions(76).Duration = 3;
Conditions(76).InitialPosition = [1 1];
Conditions(76).Gains = [-24 0 0 0];
Conditions(76).Mode = [0 0];
Conditions(76).PosFunctionX = [1 0];
Conditions(76).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(76).SpatialFreq = 30;
Conditions(76).PosFuncNameX = 'none';
Conditions(76).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(77).PatternID = 5;
Conditions(77).Duration = 3;
Conditions(77).InitialPosition = [1 1];
Conditions(77).Gains = [72 0 0 0];
Conditions(77).Mode = [0 0];
Conditions(77).PosFunctionX = [1 0];
Conditions(77).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(77).SpatialFreq = 30;
Conditions(77).PosFuncNameX = 'none';
Conditions(77).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(78).PatternID = 5;
Conditions(78).Duration = 3;
Conditions(78).InitialPosition = [1 1];
Conditions(78).Gains = [-72 0 0 0];
Conditions(78).Mode = [0 0];
Conditions(78).PosFunctionX = [1 0];
Conditions(78).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(78).SpatialFreq = 30;
Conditions(78).PosFuncNameX = 'none';
Conditions(78).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(79).PatternID = 5;
Conditions(79).Duration = 3;
Conditions(79).InitialPosition = [1 3];
Conditions(79).Gains = [8 0 0 0];
Conditions(79).Mode = [0 0];
Conditions(79).PosFunctionX = [1 0];
Conditions(79).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(79).SpatialFreq = 45;
Conditions(79).PosFuncNameX = 'none';
Conditions(79).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(80).PatternID = 5;
Conditions(80).Duration = 3;
Conditions(80).InitialPosition = [1 3];
Conditions(80).Gains = [-8 0 0 0];
Conditions(80).Mode = [0 0];
Conditions(80).PosFunctionX = [1 0];
Conditions(80).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(80).SpatialFreq = 45;
Conditions(80).PosFuncNameX = 'none';
Conditions(80).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(81).PatternID = 5;
Conditions(81).Duration = 3;
Conditions(81).InitialPosition = [1 3];
Conditions(81).Gains = [24 0 0 0];
Conditions(81).Mode = [0 0];
Conditions(81).PosFunctionX = [1 0];
Conditions(81).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(81).SpatialFreq = 45;
Conditions(81).PosFuncNameX = 'none';
Conditions(81).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(82).PatternID = 5;
Conditions(82).Duration = 3;
Conditions(82).InitialPosition = [1 3];
Conditions(82).Gains = [-24 0 0 0];
Conditions(82).Mode = [0 0];
Conditions(82).PosFunctionX = [1 0];
Conditions(82).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(82).SpatialFreq = 45;
Conditions(82).PosFuncNameX = 'none';
Conditions(82).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(83).PatternID = 5;
Conditions(83).Duration = 3;
Conditions(83).InitialPosition = [1 3];
Conditions(83).Gains = [72 0 0 0];
Conditions(83).Mode = [0 0];
Conditions(83).PosFunctionX = [1 0];
Conditions(83).PatternName = {'Pattern_15_rp_rotation_sf_48P_RC.mat'};
Conditions(83).SpatialFreq = 45;
Conditions(83).PosFuncNameX = 'none';
Conditions(83).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
%% from telethon_small_field_conditions_9_14 
Conditions(84).PatternID = 10;
Conditions(84).Duration = 3;
Conditions(84).InitialPosition = [47 1];
Conditions(84).Gains = [0 0 0 0];
Conditions(84).Mode = [4 0];
Conditions(84).PosFunctionX = [1 7];
Conditions(84).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(84).SpatialFreq = 0;
Conditions(84).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
Conditions(84).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(85).PatternID = 10;
Conditions(85).Duration = 3;
Conditions(85).InitialPosition = [47 1];
Conditions(85).Gains = [0 0 0 0];
Conditions(85).Mode = [4 0];
Conditions(85).PosFunctionX = [1 8];
Conditions(85).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(85).SpatialFreq = 0;
Conditions(85).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
Conditions(85).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(86).PatternID = 10;
Conditions(86).Duration = 3;
Conditions(86).InitialPosition = [47 1];
Conditions(86).Gains = [0 0 0 0];
Conditions(86).Mode = [4 0];
Conditions(86).PosFunctionX = [1 9];
Conditions(86).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(86).SpatialFreq = 0;
Conditions(86).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
Conditions(86).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(87).PatternID = 10;
Conditions(87).Duration = 3;
Conditions(87).InitialPosition = [47 1];
Conditions(87).Gains = [0 0 0 0];
Conditions(87).Mode = [4 0];
Conditions(87).PosFunctionX = [1 10];
Conditions(87).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(87).SpatialFreq = 0;
Conditions(87).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
Conditions(87).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(88).PatternID = 10;
Conditions(88).Duration = 3;
Conditions(88).InitialPosition = [47 1];
Conditions(88).Gains = [0 0 0 0];
Conditions(88).Mode = [4 0];
Conditions(88).PosFunctionX = [1 11];
Conditions(88).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(88).SpatialFreq = 0;
Conditions(88).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
Conditions(88).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(89).PatternID = 10;
Conditions(89).Duration = 3;
Conditions(89).InitialPosition = [47 1];
Conditions(89).Gains = [0 0 0 0];
Conditions(89).Mode = [4 0];
Conditions(89).PosFunctionX = [1 12];
Conditions(89).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(89).SpatialFreq = 0;
Conditions(89).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
Conditions(89).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(90).PatternID = 10;
Conditions(90).Duration = 3;
Conditions(90).InitialPosition = [47 2];
Conditions(90).Gains = [0 0 0 0];
Conditions(90).Mode = [4 0];
Conditions(90).PosFunctionX = [1 7];
Conditions(90).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(90).SpatialFreq = 0;
Conditions(90).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
Conditions(90).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(91).PatternID = 10;
Conditions(91).Duration = 3;
Conditions(91).InitialPosition = [47 2];
Conditions(91).Gains = [0 0 0 0];
Conditions(91).Mode = [4 0];
Conditions(91).PosFunctionX = [1 8];
Conditions(91).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(91).SpatialFreq = 0;
Conditions(91).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
Conditions(91).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(92).PatternID = 10;
Conditions(92).Duration = 3;
Conditions(92).InitialPosition = [47 2];
Conditions(92).Gains = [0 0 0 0];
Conditions(92).Mode = [4 0];
Conditions(92).PosFunctionX = [1 9];
Conditions(92).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(92).SpatialFreq = 0;
Conditions(92).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
Conditions(92).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(93).PatternID = 10;
Conditions(93).Duration = 3;
Conditions(93).InitialPosition = [47 2];
Conditions(93).Gains = [0 0 0 0];
Conditions(93).Mode = [4 0];
Conditions(93).PosFunctionX = [1 10];
Conditions(93).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(93).SpatialFreq = 0;
Conditions(93).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
Conditions(93).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(94).PatternID = 10;
Conditions(94).Duration = 3;
Conditions(94).InitialPosition = [47 2];
Conditions(94).Gains = [0 0 0 0];
Conditions(94).Mode = [4 0];
Conditions(94).PosFunctionX = [1 11];
Conditions(94).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(94).SpatialFreq = 0;
Conditions(94).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
Conditions(94).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(95).PatternID = 10;
Conditions(95).Duration = 3;
Conditions(95).InitialPosition = [47 2];
Conditions(95).Gains = [0 0 0 0];
Conditions(95).Mode = [4 0];
Conditions(95).PosFunctionX = [1 12];
Conditions(95).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(95).SpatialFreq = 0;
Conditions(95).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
Conditions(95).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(96).PatternID = 10;
Conditions(96).Duration = 3;
Conditions(96).InitialPosition = [47 3];
Conditions(96).Gains = [0 0 0 0];
Conditions(96).Mode = [4 0];
Conditions(96).PosFunctionX = [1 7];
Conditions(96).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(96).SpatialFreq = 0;
Conditions(96).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_1.mat';
Conditions(96).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(97).PatternID = 10;
Conditions(97).Duration = 3;
Conditions(97).InitialPosition = [47 3];
Conditions(97).Gains = [0 0 0 0];
Conditions(97).Mode = [4 0];
Conditions(97).PosFunctionX = [1 8];
Conditions(97).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(97).SpatialFreq = 0;
Conditions(97).PosFuncNameX = 'position_function_sine_1Hz_20wide_100Hzsf_2.mat';
Conditions(97).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(98).PatternID = 10;
Conditions(98).Duration = 3;
Conditions(98).InitialPosition = [47 3];
Conditions(98).Gains = [0 0 0 0];
Conditions(98).Mode = [4 0];
Conditions(98).PosFunctionX = [1 9];
Conditions(98).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(98).SpatialFreq = 0;
Conditions(98).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_1.mat';
Conditions(98).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(99).PatternID = 10;
Conditions(99).Duration = 3;
Conditions(99).InitialPosition = [47 3];
Conditions(99).Gains = [0 0 0 0];
Conditions(99).Mode = [4 0];
Conditions(99).PosFunctionX = [1 10];
Conditions(99).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(99).SpatialFreq = 0;
Conditions(99).PosFuncNameX = 'position_function_sine_3Hz_20wide_100Hzsf_2.mat';
Conditions(99).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(100).PatternID = 10;
Conditions(100).Duration = 3;
Conditions(100).InitialPosition = [47 3];
Conditions(100).Gains = [0 0 0 0];
Conditions(100).Mode = [4 0];
Conditions(100).PosFunctionX = [1 11];
Conditions(100).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(100).SpatialFreq = 0;
Conditions(100).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_1.mat';
Conditions(100).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(101).PatternID = 10;
Conditions(101).Duration = 3;
Conditions(101).InitialPosition = [47 3];
Conditions(101).Gains = [0 0 0 0];
Conditions(101).Mode = [4 0];
Conditions(101).PosFunctionX = [1 12];
Conditions(101).PatternName = {'Pattern_20_4wide_stripes_48P_RC.mat'};
Conditions(101).SpatialFreq = 0;
Conditions(101).PosFuncNameX = 'position_function_sine_5Hz_20wide_100Hzsf_2.mat';
Conditions(101).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
%% from telethon_optic_flow_condition_9_14 
Conditions(102).PatternID = 16;
Conditions(102).Duration = 3;
Conditions(102).InitialPosition = [1 1];
Conditions(102).Gains = [0 0 0 0];
Conditions(102).Mode = [4 0];
Conditions(102).PosFunctionX = [1 3];
Conditions(102).PatternName = {'Pattern_26_lift_gs2.mat'};
Conditions(102).SpatialFreq = 0;
Conditions(102).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(102).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(103).PatternID = 16;
Conditions(103).Duration = 3;
Conditions(103).InitialPosition = [1 1];
Conditions(103).Gains = [0 0 0 0];
Conditions(103).Mode = [4 0];
Conditions(103).PosFunctionX = [1 4];
Conditions(103).PatternName = {'Pattern_26_lift_gs2.mat'};
Conditions(103).SpatialFreq = 0;
Conditions(103).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
Conditions(103).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(104).PatternID = 17;
Conditions(104).Duration = 3;
Conditions(104).InitialPosition = [1 1];
Conditions(104).Gains = [0 0 0 0];
Conditions(104).Mode = [4 0];
Conditions(104).PosFunctionX = [1 3];
Conditions(104).PatternName = {'Pattern_27_pitch_gs2.mat'};
Conditions(104).SpatialFreq = 0;
Conditions(104).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(104).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(105).PatternID = 17;
Conditions(105).Duration = 3;
Conditions(105).InitialPosition = [1 1];
Conditions(105).Gains = [0 0 0 0];
Conditions(105).Mode = [4 0];
Conditions(105).PosFunctionX = [1 4];
Conditions(105).PatternName = {'Pattern_27_pitch_gs2.mat'};
Conditions(105).SpatialFreq = 0;
Conditions(105).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
Conditions(105).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(106).PatternID = 18;
Conditions(106).Duration = 3;
Conditions(106).InitialPosition = [1 1];
Conditions(106).Gains = [0 0 0 0];
Conditions(106).Mode = [4 0];
Conditions(106).PosFunctionX = [1 3];
Conditions(106).PatternName = {'Pattern_28_roll_gs2.mat'};
Conditions(106).SpatialFreq = 0;
Conditions(106).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(106).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(107).PatternID = 18;
Conditions(107).Duration = 3;
Conditions(107).InitialPosition = [1 1];
Conditions(107).Gains = [0 0 0 0];
Conditions(107).Mode = [4 0];
Conditions(107).PosFunctionX = [1 4];
Conditions(107).PatternName = {'Pattern_28_roll_gs2.mat'};
Conditions(107).SpatialFreq = 0;
Conditions(107).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
Conditions(107).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(108).PatternID = 19;
Conditions(108).Duration = 3;
Conditions(108).InitialPosition = [1 1];
Conditions(108).Gains = [0 0 0 0];
Conditions(108).Mode = [4 0];
Conditions(108).PosFunctionX = [1 3];
Conditions(108).PatternName = {'Pattern_29_sideslip_gs2.mat'};
Conditions(108).SpatialFreq = 0;
Conditions(108).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(108).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(109).PatternID = 19;
Conditions(109).Duration = 3;
Conditions(109).InitialPosition = [1 1];
Conditions(109).Gains = [0 0 0 0];
Conditions(109).Mode = [4 0];
Conditions(109).PosFunctionX = [1 4];
Conditions(109).PatternName = {'Pattern_29_sideslip_gs2.mat'};
Conditions(109).SpatialFreq = 0;
Conditions(109).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
Conditions(109).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(110).PatternID = 20;
Conditions(110).Duration = 3;
Conditions(110).InitialPosition = [1 1];
Conditions(110).Gains = [0 0 0 0];
Conditions(110).Mode = [4 0];
Conditions(110).PosFunctionX = [1 3];
Conditions(110).PatternName = {'Pattern_30_thrust_gs2.mat'};
Conditions(110).SpatialFreq = 0;
Conditions(110).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(110).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(111).PatternID = 20;
Conditions(111).Duration = 3;
Conditions(111).InitialPosition = [1 1];
Conditions(111).Gains = [0 0 0 0];
Conditions(111).Mode = [4 0];
Conditions(111).PosFunctionX = [1 4];
Conditions(111).PatternName = {'Pattern_30_thrust_gs2.mat'};
Conditions(111).SpatialFreq = 0;
Conditions(111).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_positive.mat';
Conditions(111).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(112).PatternID = 21;
Conditions(112).Duration = 3;
Conditions(112).InitialPosition = [1 1];
Conditions(112).Gains = [0 0 0 0];
Conditions(112).Mode = [4 0];
Conditions(112).PosFunctionX = [1 3];
Conditions(112).PatternName = {'Pattern_31_yaw_gs2.mat'};
Conditions(112).SpatialFreq = 0;
Conditions(112).PosFuncNameX = 'position_function_sine_1Hz_20_pp_48wide_negative.mat';
Conditions(112).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
%% from telethon_onoff_conditions_9_14 
Conditions(113).PatternID = 12;
Conditions(113).Duration = 3;
Conditions(113).InitialPosition = [1 1];
Conditions(113).Gains = [1 0 1 0];
Conditions(113).Mode = [0 0];
Conditions(113).PosFunctionX = [1 0];
Conditions(113).PatternName = {'Pattern_22_expansion_on_foeleft_48_RC_telethon.mat'};
Conditions(113).SpatialFreq = 30;
Conditions(113).PosFuncNameX = 'none';
Conditions(113).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(114).PatternID = 13;
Conditions(114).Duration = 3;
Conditions(114).InitialPosition = [1 1];
Conditions(114).Gains = [1 0 1 0];
Conditions(114).Mode = [0 0];
Conditions(114).PosFunctionX = [1 0];
Conditions(114).PatternName = {'Pattern_23_expansion_on_foeright_48_RC_telethon.mat'};
Conditions(114).SpatialFreq = 30;
Conditions(114).PosFuncNameX = 'none';
Conditions(114).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(115).PatternID = 14;
Conditions(115).Duration = 3;
Conditions(115).InitialPosition = [1 1];
Conditions(115).Gains = [1 0 1 0];
Conditions(115).Mode = [0 0];
Conditions(115).PosFunctionX = [1 0];
Conditions(115).PatternName = {'Pattern_24_expansion_off_foeleft_48_RC_telethon.mat'};
Conditions(115).SpatialFreq = 30;
Conditions(115).PosFuncNameX = 'none';
Conditions(115).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(116).PatternID = 15;
Conditions(116).Duration = 3;
Conditions(116).InitialPosition = [1 1];
Conditions(116).Gains = [1 0 1 0];
Conditions(116).Mode = [0 0];
Conditions(116).PosFunctionX = [1 0];
Conditions(116).PatternName = {'Pattern_25_expansion_off_foeright_48_RC_telethon.mat'};
Conditions(116).SpatialFreq = 30;
Conditions(116).PosFuncNameX = 'none';
Conditions(116).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(117).PatternID = 11;
Conditions(117).Duration = 3;
Conditions(117).InitialPosition = [1 1];
Conditions(117).Gains = [32 0 0 0];
Conditions(117).Mode = [0 0];
Conditions(117).PosFunctionX = [1 0];
Conditions(117).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(117).SpatialFreq = 30;
Conditions(117).PosFuncNameX = 'none';
Conditions(117).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(118).PatternID = 11;
Conditions(118).Duration = 3;
Conditions(118).InitialPosition = [1 2];
Conditions(118).Gains = [-32 0 0 0];
Conditions(118).Mode = [0 0];
Conditions(118).PosFunctionX = [1 0];
Conditions(118).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(118).SpatialFreq = 30;
Conditions(118).PosFuncNameX = 'none';
Conditions(118).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
Conditions(119).PatternID = 11;
Conditions(119).Duration = 3;
Conditions(119).InitialPosition = [1 3];
Conditions(119).Gains = [32 0 0 0];
Conditions(119).Mode = [0 0];
Conditions(119).PosFunctionX = [1 0];
Conditions(119).PatternName = {'Pattern_21_on_off_motion_telethon_pattern_8wide.mat'};
Conditions(119).SpatialFreq = 30;
Conditions(119).PosFuncNameX = 'none';
Conditions(119).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14'; 
%
%% from telethon_bilateral_conditions_9_14 Conditions(120).PatternID = 22;
Conditions(120).PatternID = 22;
Conditions(120).Duration = 3;
Conditions(120).InitialPosition = [1 3];
Conditions(120).Gains = [8 0 0 0];
Conditions(120).Mode = [0 0];
Conditions(120).PosFunctionX = [1 0];
Conditions(120).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(120).SpatialFreq = 30;
Conditions(120).PosFuncNameX = 'none';
Conditions(120).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(121).PatternID = 23;
Conditions(121).Duration = 3;
Conditions(121).InitialPosition = [1 3];
Conditions(121).Gains = [-8 0 0 0];
Conditions(121).Mode = [0 0];
Conditions(121).PosFunctionX = [1 0];
Conditions(121).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(121).SpatialFreq = 30;
Conditions(121).PosFuncNameX = 'none';
Conditions(121).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(122).PatternID = 23;
Conditions(122).Duration = 3;
Conditions(122).InitialPosition = [1 3];
Conditions(122).Gains = [8 0 0 0];
Conditions(122).Mode = [0 0];
Conditions(122).PosFunctionX = [1 0];
Conditions(122).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(122).SpatialFreq = 30;
Conditions(122).PosFuncNameX = 'none';
Conditions(122).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(123).PatternID = 22;
Conditions(123).Duration = 3;
Conditions(123).InitialPosition = [1 3];
Conditions(123).Gains = [-8 0 0 0];
Conditions(123).Mode = [0 0];
Conditions(123).PosFunctionX = [1 0];
Conditions(123).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(123).SpatialFreq = 30;
Conditions(123).PosFuncNameX = 'none';
Conditions(123).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(124).PatternID = 22;
Conditions(124).Duration = 3;
Conditions(124).InitialPosition = [1 3];
Conditions(124).Gains = [24 0 0 0];
Conditions(124).Mode = [0 0];
Conditions(124).PosFunctionX = [1 0];
Conditions(124).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(124).SpatialFreq = 30;
Conditions(124).PosFuncNameX = 'none';
Conditions(124).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(125).PatternID = 23;
Conditions(125).Duration = 3;
Conditions(125).InitialPosition = [1 3];
Conditions(125).Gains = [-24 0 0 0];
Conditions(125).Mode = [0 0];
Conditions(125).PosFunctionX = [1 0];
Conditions(125).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(125).SpatialFreq = 30;
Conditions(125).PosFuncNameX = 'none';
Conditions(125).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(126).PatternID = 23;
Conditions(126).Duration = 3;
Conditions(126).InitialPosition = [1 3];
Conditions(126).Gains = [24 0 0 0];
Conditions(126).Mode = [0 0];
Conditions(126).PosFunctionX = [1 0];
Conditions(126).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(126).SpatialFreq = 30;
Conditions(126).PosFuncNameX = 'none';
Conditions(126).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(127).PatternID = 22;
Conditions(127).Duration = 3;
Conditions(127).InitialPosition = [1 3];
Conditions(127).Gains = [-24 0 0 0];
Conditions(127).Mode = [0 0];
Conditions(127).PosFunctionX = [1 0];
Conditions(127).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(127).SpatialFreq = 30;
Conditions(127).PosFuncNameX = 'none';
Conditions(127).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(128).PatternID = 22;
Conditions(128).Duration = 3;
Conditions(128).InitialPosition = [1 3];
Conditions(128).Gains = [96 0 0 0];
Conditions(128).Mode = [0 0];
Conditions(128).PosFunctionX = [1 0];
Conditions(128).PatternName = {'Pattern_32_rotation_left_half_gs3.mat'};
Conditions(128).SpatialFreq = 30;
Conditions(128).PosFuncNameX = 'none';
Conditions(128).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(129).PatternID = 23;
Conditions(129).Duration = 3;
Conditions(129).InitialPosition = [1 3];
Conditions(129).Gains = [-96 0 0 0];
Conditions(129).Mode = [0 0];
Conditions(129).PosFunctionX = [1 0];
Conditions(129).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(129).SpatialFreq = 30;
Conditions(129).PosFuncNameX = 'none';
Conditions(129).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%
Conditions(130).PatternID = 23;
Conditions(130).Duration = 3;
Conditions(130).InitialPosition = [1 3];
Conditions(130).Gains = [96 0 0 0];
Conditions(130).Mode = [0 0];
Conditions(130).PosFunctionX = [1 0];
Conditions(130).PatternName = {'Pattern_33_rotation_right_half_gs3.mat'};
Conditions(130).SpatialFreq = 30;
Conditions(130).PosFuncNameX = 'none';
Conditions(130).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 
%% Closed loop condition for interspersing between trials
%
Conditions(131).PatternID = 1;
Conditions(131).Duration = 3.5;
Conditions(131).InitialPosition = [49 1];
Conditions(131).Gains = [-15 0 0 0];
Conditions(131).Mode = [1 0];
Conditions(131).PosFunctionX = [1 0];
Conditions(131).PatternName = {'Pattern_11_8wide_bothcontrasts_stripes_c49_telethon.mat'};
Conditions(131).SpatialFreq = 0;
Conditions(131).PosFuncNameX = 'none';
Conditions(131).PosFuncLoc = 'R:\Telethon_Database\functions\telethon_pos_funcs_04_11'; 

%% Set condition parameters that are not specified (or do not change) in the telethon
% assign voltages to each condition as well.
encoded_vals = linspace(.1,9.9,numel(Conditions));

for cond_num = 1:numel(Conditions)
    Conditions(cond_num).PanelCfgNum    = 1;
    Conditions(cond_num).PanelCfgName   = 'default_48_4_bus';
	Conditions(cond_num).PosFuncNameY 	= 'null';
	Conditions(cond_num).FuncFreqY 		= 50;
	Conditions(cond_num).FuncFreqX 		= 50;
	Conditions(cond_num).PosFunctionY 	= [0 0];
	Conditions(cond_num).VelFunction 	= [1 0];
	Conditions(cond_num).VelFuncName 	= 'none';
    Conditions(cond_num).Voltage        =  encoded_vals(cond_num);
end

% Even though it is set in the experiment, be explicit about the voltage
% value of the closed loop portion!
Conditions(numel(Conditions)).Voltage        =  0;

