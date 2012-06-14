
AO = analogoutput('nidaq','Dev1');
chans = addchannel(AO, [1]);

%% 44,100 Hz, 1 seconds of data


duration = 10;
SampleRate = 44100;
set(AO,'SampleRate',SampleRate)
set(AO,'TriggerType','Manual')
NumSamples = SampleRate*duration;

%% 500 Hz sin wave

x = linspace(0,2*pi*500,NumSamples);

data = sin(x)';

putdata(AO,data)
start(AO)
trigger(AO)


wait(AO,100)
delete(AO)
clear AO

daqreset