% Pos func failsafes --- ALWAYS RUN FULL SCRIPT!

% makes 2 sets of 11 positions around the arena, one in each direction
% will sweep across each panel

count = 0;

cd('R:\slh_database\functions\20111109\')

for dir = 1:2           % Both Dir
for sweepstart = 1:11   % 12 Positions
    func = [];

    if      dir == 1;  init = (sweepstart*8 - 2);
            addy = sort([0:4 0:4]);
    elseif  dir == 2;  init = (sweepstart*8 + 2);
            addy = sort(([0:4 0:4]))*-1;

    end
       
    func = init+addy; func = [func repmat(func(numel(func)),1,100)]; %#ok<*AGROW>
    
   count = count +1;
   if dir == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_single_4px_150deg_s_movement_100hz_' dirname '_position_' num2str(sweepstart)];
   save(name,'func'); clear func;
end
end


% Wiggle functions
for phase = 1:2         %both phases
for wiggle = 1:5        %5 positions
    centerPos = 48;
    positions = [-24 -12 0 12 24]+centerPos;  
    initPos = positions(wiggle);
    
    % this gives an upswipe speed of 150deg/sec.... average spee over the whole sine
    % wave is slightly lower....
    if phase == 1;  dunk = 3*make_sine_wave_function(2, 60, 1);
    elseif phase == 2; dunk = 3*circshift(make_sine_wave_function(2, 60, 1)',30)';
    end
    func =(dunk + initPos); func = round(func);
    func = [func repmat(func(numel(func)),1,40)];
    
    count = count +1;
    if phase == 1; dirname = '0'; else dirname = '+pi';end
    if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
    name = ['position_function_' num '_4pix_wiggle_100hz_phase' dirname '_position_' num2str(wiggle)];
    save(name,'func'); clear func;
end
end

% Sweep functions

for sweep = 1:2;
    if sweep ==1; func = sort([0:95 0:95]);
    elseif sweep ==2; func = sort(([0:95 0:95]),'descend'); 
    end

    func = [func repmat(func(numel(func)),1,40)];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_150deg_s_full_sweep_100hz_' dirname];
   save(name,'func'); clear func;
end


