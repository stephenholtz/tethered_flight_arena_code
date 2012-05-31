%% Position functions

% 100 Hz ==> can have .01 seconds b/n posiitons ==> .025 b/n = 150 deg/s
% .2 == 187.5, .3 == 125 
% 

% This goes 'step step pause' at 125deg/s if sampling at 100 Hz
pause_n_steps = [0*ones(1,100) 1*ones(1,3) 2*ones(1,3)];
func = [];
for g = 0:2:95
    func = [func g+pause_n_steps];
end
orig_func = func;
func = orig_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_01_125deg_s_48position_1secPause_forwards','func')
cd('R:\')

rev_func = fliplr(func);
func = rev_func;

cd('R:\slh_database\functions\20110906\')
save('position_function_02_125deg_s_48position_1secPause_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_03_125deg_s_48position_1secPause_both_dir','func')        
cd('R:\')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  24 position version

pause_n_steps = [0*ones(1,50) 1*ones(1,3) 2*ones(1,3) 2*ones(1,47)];
func = []; count = 0;
for g = 0:4:95
    func = [func g+pause_n_steps];
    count = count+1;
end
orig_func = func;
func = orig_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_04_125deg_s_24position_1secPause_forwards','func')
cd('R:\')

rev_func = fliplr(func);
func = rev_func;

cd('R:\slh_database\functions\20110906\')
save('position_function_05_125deg_s_24position_1secPause_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func; 
cd('R:\slh_database\functions\20110906\')
save('position_function_06_125deg_s_24position_1secPause_both_dir','func')        
cd('R:\')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  12 position version

pause_n_steps = [0*ones(1,50) 1*ones(1,3) 2*ones(1,3) 2*ones(1,47)];
func = []; count = 0;
for g = 0:8:95
    func = [func g+pause_n_steps];
    count = count+1;
end
orig_func = func;
func = orig_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_07_125deg_s_12position_1secPause_forwards','func')
cd('R:\')
 
rev_func = fliplr(func);
func = rev_func;

cd('R:\slh_database\functions\20110906\')
save('position_function_08_125deg_s_12position_1secPause_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func; 
cd('R:\slh_database\functions\20110906\')
save('position_function_09_125deg_s_12position_1secPause_both_dir','func')        
cd('R:\')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 48 position version

%This will go saw wave front back back front ... --> skip to next position
%at 150 deg/s
clear func; func = []; count = 0;
shifty = [0*ones(1,3) 1*ones(1,3) 0*ones(1,3) -1*ones(1,3) 0*ones(1,50) 2*ones(1,47)];
for g = 0:2:87
    func = [func g+shifty];
    count = count+1;
end

orig_func = func; 
func = orig_func; 

cd('R:\slh_database\functions\20110906\')
save('position_function_10_125deg_s_48position_1secPause_saw_then_shift_forwards','func')
cd('R:\')

rev_func = fliplr(func);
func = rev_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_11_125deg_s_48position_1secPause_saw_then_shift_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_12_125deg_s_48position_1secPause_saw_then_shift_both_dir','func')        


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 24 position version

%This will go square wave front back front back --> skip to next position
%at 150 deg/s
clear func; func = [];
shifty = [0*ones(1,3) 1*ones(1,3) 0*ones(1,3) -1*ones(1,3) 0*ones(1,50) 4*ones(1,47)];
for g = 0:4:87
    func = [func g+shifty];
end

orig_func = func;
% func = orig_func;

cd('R:\slh_database\functions\20110906\')
save('position_function_13_125deg_s_24position_1secPause_saw_then_shift_forwards','func')
cd('R:\')

rev_func = fliplr(func);
func = rev_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_14_125deg_s_24position_1secPause_saw_then_shift_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_15_125deg_s_24position_1secPause_saw_then_shift_both_dir','func')        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 12 position version

%This will go square wave front back front back --> skip to next position
%at 150 deg/s
clear func; func = [];
shifty = [0*ones(1,22) 0*ones(1,3) 1*ones(1,3) 0*ones(1,3) -1*ones(1,3) 0*ones(1,50) 8*ones(1,25)];
for g = 0:8:87
    func = [func g+shifty];
end

func = [8*ones(1,25) func(1:1174) + 8];

orig_func = func;
func = orig_func;

cd('R:\slh_database\functions\20110906\')
save('position_function_16_125deg_s_12position_1secPause_saw_then_shift_forwards','func')
cd('R:\')
 
rev_func = fliplr(func);
func = rev_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_17_125deg_s_12position_1secPause_saw_then_shift_backwards','func')        
cd('R:\')

both_func = [orig_func repmat(orig_func(end),1,97) rev_func];
func = both_func;
cd('R:\slh_database\functions\20110906\')
save('position_function_18_125deg_s_12position_1secPause_saw_then_shift_both_dir','func')        


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 12 position version
% Special function for Pattern_9_4px_wide_barrel_stripes, subtract 1 at the
% end to get starting at zero

% Goes like: pause at init for half sec, jump jump (150 deg/s) pause for half
% sec, go back to init wait 1 sec, jump jump opposite (150 deg/s) pause for
% half sec, go back to init (then move to next mobile stripe)

% 30.1; seconds
clear func; func = []; clear rev_func; rev_func = [];

init = 10;

jumpy = [(init)*ones(1,50)...
        (init+1)*ones(1,3) ...
        (init+2)*ones(1,3)...
        (init+2)*ones(1,47)...
        (init)*ones(1,100)...
        (init-1)*ones(1,3) ...
        (init-2)*ones(1,3)...
        (init-2)*ones(1,47)];
    
for g = 0:11
    func = [func g*20+jumpy];
end
func = func - 1;
cd('R:\slh_database\functions\20110906\')
save('position_function_19_125deg_s_12position_1secPause_barrel_shifts_front','func')        

init = 230;
jumpyback = [(init)*ones(1,50)...
        (init-1)*ones(1,3) ...
        (init-2)*ones(1,3)...
        (init-2)*ones(1,47)...
        (init)*ones(1,100)...
        (init+1)*ones(1,3) ... 
        (init+2)*ones(1,3)...
        (init+2)*ones(1,47)];
    
for g = 0:11
    rev_func = [rev_func jumpyback-g*20];
end
func = rev_func -1;
cd('R:\slh_database\functions\20110906\')
save('position_function_20_125deg_s_12position_1secPause_barrel_shifts_back','func')        


both_func = [func rev_func - 1]; func = both_func; 

cd('R:\slh_database\functions\20110906\')
save('position_function_21_125deg_s_12position_1secPause_barrel_shifts_both_dir','func')        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6 position version
% Special function for Pattern_9_4px_wide_barrel_stripes, subtract 1 at the
% end to get starting at zero

% Goes like: pause at init for half sec, jump jump (150 deg/s) pause for half
% sec, go back to init wait 1 sec, jump jump opposite (150 deg/s) pause for
% half sec, go back to init (then move to next mobile stripe)

% 15.4 seconds
clear func; func = []; clear rev_func; rev_func = [];

init = 30;

jumpy = [(init)*ones(1,50)...
        (init+1)*ones(1,3) ...
        (init+2)*ones(1,3)...
        (init+2)*ones(1,47)...
        (init)*ones(1,100)...
        (init-1)*ones(1,3) ...
        (init-2)*ones(1,3)...
        (init-2)*ones(1,47)];
    
for g = 0:5
    func = [func g*40+jumpy];
end
func = func - 1;
cd('R:\slh_database\functions\20110906\')
save('position_function_22_125deg_s_06position_1secPause_barrel_shifts_front','func')        

init = 210;
jumpyback = [(init)*ones(1,50)...
        (init-1)*ones(1,3) ...
        (init-2)*ones(1,3)...
        (init-2)*ones(1,47)...
        (init)*ones(1,100)...
        (init+1)*ones(1,3) ... 
        (init+2)*ones(1,3)...
        (init+2)*ones(1,47)];
    
for g = 0:5
    rev_func = [rev_func jumpyback-g*40];
end
func = rev_func -1;
cd('R:\slh_database\functions\20110906\')
save('position_function_23_125deg_s_06position_1secPause_barrel_shifts_back','func')        


both_func = [func rev_func - 1]; func = both_func; 

cd('R:\slh_database\functions\20110906\')
save('position_function_24_125deg_s_06position_1secPause_barrel_shifts_both_dir','func')        
