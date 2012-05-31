% 'C:\tethered_flight_arena_code\+Exp\temp_meta_file.m'
% make sure each item is part of the metadata struct: i.e.
% metadata.flynotes

% Transgene metadata
metadata.Line           = 'gmr_58e02_ae_01';                    % this will be searched for in the database
metadata.Chromo2        = 'gmr_58e02_gal4; tubp_gal80ts';       % this is for better information on the genotype
metadata.Chromo3        = 'gmr_58e02_gal4; uas_kir_2.1';        % this is for better information on genotype
metadata.Sex            = 'female';                             % sex, written out
metadata.DoB            = '5_16_12';                            % month _ day _ year
metadata.LightCycle     = '20_12';                              % lights on _ lights off
metadata.HeadGlued      = '0';                                  % 1 = glued, 0 = not glued
metadata.Protocol       = 'telethon_experiment_2011';           % this should be the exact name of the protocol in the protocol folder and the condition file in the protocol folder
metadata.Effector       = 'gal80ts_kir21';                      % this will be used in database for searching
metadata.fly_tag        = '';       % for keeping track of flies that need histology etc.,
metadata.note           = '';       % for misc things that don't fit, but don't need a category

metadata.temp_unshift_time       = '0.0.0';     % length of time unshifted in days.hours.mins
metadata.temp_shift_time         = '0.0.0';     % length of time shifted in days.hours.mins
metadata.temp_unshifted          = 18;          % for flies that are raised at 25, this should be 25, the other temps should be zero
metadata.temp_shifted            = 30;          % if the flies are raised at 25 and not shifted, this value does not matter
metadata.temp_experiment         = 20.2;        % from the thermometer above the arenas
metadata.temp_ambient            = 20.2;        % from the thermometer above the arenas
metadata.humidity_ambient        = 56;          % from the thermometer above the arenas

% metadata.Line           = 'w-;gmr';
% metadata.Chromo2        = 'gmr; gmr';
% metadata.Chromo3        = 'gmr; gmr';
% metadata.Sex            = 'male_left_female_right';
% metadata.DoB            = '5_15_12';
% metadata.LightCycle     = '01_17';
% metadata.HeadGlued      = '0';
% metadata.Protocol       = 'telethon_experiment_2011';
% metadata.Effector       = 'null';
% metadata.daqFile        = 'raw_data.daq';

% Don't generally change.
metadata.Arena          = '2';              % Number written on the controller of each arena% BEWARE COPY PASTE!
metadata.Experimenter   = 'stephen';        % keep track of who ran the experiment
metadata.AssayType      = 'tf';             % used for the database, tf = tethered flight vs ff = free flight vs ?? for others
metadata.DateTime       = datestr(now,30);  % the time the experiment started
metadata.ExperimentName = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
metadata.daqFile        = 'raw_data.daq';   % this shouldn't change, but it might be useful to have control of it

% Note: if adding more fields, the field must also be added in the
% appropriate class (usually Experiment) and to the populate_class function
% that makes sense. Also the Utilities metadataFieldList should be updated
% if a field is deemed necessary for the experiment (there is a check done
% to make sure all the fields in that list are present)!

