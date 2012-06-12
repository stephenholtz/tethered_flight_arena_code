% 'C:\tethered_flight_arena_code\+Exp\protocols\PROTOCOL_NAME\temp_meta_file.m'
%
% metadata.Protocol is added in with data from the argument passed to 
% Exp.Run, in order to avoid mistakes in typing it in.

% Transgene metadata
metadata.Line               = 'gmr_42f06_ae_01';
metadata.Chromo2            = 'gmr_42f06_gal4; tubp_gal80ts';
metadata.Chromo3            = 'gmr_42f06_gal4; uas_kir_2.1';
metadata.Sex                = 'female';
metadata.DoB                = '4_9_12';
metadata.HeadGlued          = '0';
metadata.Effector           = 'gal80ts_kir21'; % 'gal80ts_kir21' 'gal80ts_tnt'
metadata.daqFile            = 'raw_data.daq';
metadata.temp_unshift_time  = '0.0.0';     % length of time unshifted in days.hours.mins
metadata.temp_shift_time	= '0.0.0';
metadata.temp_unshifted     = 18;
metadata.temp_shifted       = 30;
metadata.temp_experiment    = 20.6;
metadata.temp_ambient       = metadata.temp_experiment;
metadata.humidity_ambient   = 60;
metadata.fly_tag            = '';
metadata.note               = '';

time = 2;
switch time % Prevents me from messing up the light cycles, kinda.
    case 1
        metadata.LightCycle = '20_12'; % AM
    case 2
        metadata.LightCycle = '01_17'; % PM
    case 3
        metadata.LightCycle = '04_20'; % PM
    case 4
        metadata.LightCycle = '06_22'; % PM
    case 5
        metadata.LightCycle = '17_09'; % AM
    otherwise
        metadata.LightCycle = '00_00'; % ...
end

% Don't generally change.
[~,metadata.Arena]          = system('%computername%','echo'); % REISERLAB-WW11
[~,metadata.Experimenter]   = system('%username%','echo');     % HOLTZS
metadata.AssayType          = 'tf';
metadata.DateTime           = datestr(now,30);
metadata.ExperimentName     = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
metadata.daqFile            = 'raw_data.daq';

% Note: if adding more fields, the field must also be added in the
% appropriate class (usually Experiment) and to the populate_class function
% that makes sense.
