% 'C:\tethered_flight_arena_code\+Exp\protocols\PROTOCOL_NAME\temp_meta_file.m'
%
% metadata.Protocol is added in with data from the argument passed to 
% Exp.Run, in order to avoid mistakes in typing it in.

% Transgene metadata
metadata.Line               = 'gmr_48a08ad'; %'gmr_42f06_ae_01';
metadata.Chromo2            = 'gmr; tubp_gal80ts';
metadata.Chromo3            = 'gmr_26a03dbd; uas_kir_2.1';
metadata.Sex                = 'female'; % 'male' 'female'
metadata.DoB                = '2_4_13';
metadata.HeadGlued          = '0'; % '1' '0'
metadata.Effector           = 'gal80ts_kir21'; % 'gal80ts_kir21' 'gal80ts_tnt'
metadata.daqFile            = 'raw_data.daq';
metadata.temp_unshift_time  = '0.0.0';     % length of time unshifted in days.hours.mins
metadata.temp_shift_time	= '0.0.0';
metadata.temp_unshifted     = 25;
metadata.temp_shifted       = 25;
metadata.temp_experiment    = 20.1;
metadata.temp_ambient       = metadata.temp_experiment;
metadata.humidity_ambient   = 60.2;
metadata.fly_tag            = ''; % ['pal_' datestr(now,30)];
metadata.note               = ''; % 'ocelli_dark_paint' 'ocelli_clear_paint'

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
[~,metadata.Arena]          = system('echo %COMPUTERNAME%');    metadata.Arena = metadata.Arena(1:end-1);
[~,metadata.Experimenter]   = system('echo %USERNAME%');        metadata.Experimenter = metadata.Experimenter(1:end-1);
metadata.AssayType          = 'tf';
metadata.DateTime           = datestr(now,30);
metadata.ExperimentName     = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
metadata.daqFile            = 'raw_data.daq';

% Note: if adding more fields, the field must also be added in the
% appropriate class (usually Experiment) and to the populate_class function
% that makes sense.
