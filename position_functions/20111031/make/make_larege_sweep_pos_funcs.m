%% Position functions

% .2 == 187.5, .3 == 125 
% 
% This goes sweep forward, back, forward back in 2 seconds, returns to an
% original priming position centered on pixel 49.

initPos = 48;

dunk = make_sine_wave_function(2, 100, 1);

startSwipe = dunk*3+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func (startSwipe + g)];                                        %#ok<*AGROW>
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_01_125deg_s_5pos_3pix_amp','func')

%% FOR DEBUGGING

initPos = 48;

dunk = make_sine_wave_function(2, 100, 1);

startSwipe = dunk*3+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func (startSwipe + g)];                                        %#ok<*AGROW>
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_06_EQUAL_TO_POS_FUNC_1','func')

startSwipe = dunk*4+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] 
    func = [func  (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_05_125deg_s_5pos_4pix_amp','func')


%%
startSwipe = dunk*6+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func  (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_02_125deg_s_5pos_6pix_amp','func')


crunk = circshift(make_sine_wave_function(2, 100, 1)',50)';


startSwipe = crunk*3+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_03_125deg_s_5pos_3pix_amp_reverse','func')

startSwipe = crunk*6+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_04_125deg_s_5pos_6pix_amp_reverse','func')


%% Switchy back and forth

func = [ones(2005,1); 2*ones(2005,1)];



cd('C:\tethered_flight_arena_code\position_functions\20111031\')
save('position_function_07_125deg_s_5pos_6pix_amp_reverse','func')
