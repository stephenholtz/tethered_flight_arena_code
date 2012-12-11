function [degPerSec hz] = dps(pixels,funcLen,panelComSetting)
% Pos Func deg/s
pixDegs = 3.75;
degPerSec = (pixDegs*pixels)/(funcLen./panelComSetting);
hz = degPerSec/360;
end