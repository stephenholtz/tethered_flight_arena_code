% 'C:\tethered_flight_arena_code\+Exp\temp_meta_file.m'

% Transgene metadata
metadata.Line                   = 'gmr_48a08dbd';
metadata.Chromo2                = 'gmr; tubp_gal80ts';
metadata.Chromo3                = 'gmr_48a08dbd; uas_kir_2.1';
metadata.Sex                    = 'female';
metadata.DoB                    = '5_29_12';
metadata.LightCycle             = '01_17';
metadata.HeadGlued              = '0';
metadata.Effector               = 'gal80ts_kir21';
metadata.daqFile                = 'raw_data.daq';
metadata.temp_unshift_time      = '0.0.0';     % length of time unshifted in days.hours.mins
metadata.temp_shift_time        = '0.0.0';
metadata.temp_unshifted         = 25;
metadata.temp_shifted           = 30;
metadata.temp_experiment        = 20.3;
metadata.temp_ambient           = 20.3;
metadata.humidity_ambient       = 55;
metadata.fly_tag                = '';
metadata.note                   = '';

% Don't generally change.
metadata.Arena                  = '1';          % BEWARE COPY PASTE!
metadata.Experimenter           = 'stephen';
metadata.AssayType              = 'tf';
metadata.DateTime               = datestr(now,30);
metadata.ExperimentName         = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
metadata.daqFile                = 'raw_data.daq';

% Note: if adding more fields, the field must also be added in the
% appropriate class (usually Experiment) and to the populate_class function
% that makes sense.
