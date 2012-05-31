% 'C:\tethered_flight_arena_code\+Exp\temp_meta_file.m'

% Transgene metadata
metadata.Line           = 'gmr_42f06_ae_01';
metadata.Chromo2        = 'gmr_42f06_gal4; tubp_gal80ts';
metadata.Chromo3        = 'gmr_42f06_gal4; uas_kir_2.1';
metadata.Sex            = 'female';
metadata.DoB            = '4_9_12';
metadata.LightCycle     = '20_12';
metadata.HeadGlued      = '0';
metadata.Protocol       = 'telethon_experiment_2011';
metadata.Effector       = 'gal80ts_kir21';
metadata.daqFile        = 'raw_data.daq';

temp_unshift_time       = '0.0.0';     % length of time unshifted in days.hours.mins
temp_shift_time         = '0.0.0';
temp_unshifted          = 18;
temp_shifted            = 30;
temp_experiment         = 20.6;
temp_ambient            = 20.6;
humidity_ambient        = 60;

% Don't generally change.
metadata.Arena          = '2';          % BEWARE COPY PASTE!
metadata.Experimenter   = 'stephen';
metadata.AssayType      = 'tf';
metadata.DateTime       = datestr(now,30);
metadata.ExperimentName = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
metadata.daqFile        = 'raw_data.daq';

% Note: if adding more fields, the field must also be added in the
% appropriate class (usually Experiment) and to the populate_class function
% that makes sense.
