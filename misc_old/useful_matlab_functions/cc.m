% cc - my favorite two letter command
clear all force
close all force

try; daqreset; end %#ok<*TRYNC,*NOSEM>
try; delete(instrfindall); end

clc