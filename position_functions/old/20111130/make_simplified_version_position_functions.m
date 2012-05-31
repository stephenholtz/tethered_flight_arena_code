% Pos func failsafes --- ALWAYS RUN FULL SCRIPT!

count = 0;

cd('R:\slh_database\functions\20111130\')

% Sweep functions

for sweep = 1:2;
    if sweep ==1; func = sort([0:95 0:95]);
    elseif sweep ==2; func = sort(([0:95 0:95]),'descend'); 
    end
    
    func = [func repmat(func(numel(func)),1,40)];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_full_sweep_in_192_samps_' dirname];
   save(name,'func'); clear func;
end

% Wiggle functions
for phase = 1:2         %both phases
for wiggle = 1        %5 positions
    backPos = 1;
    positions = [0]+backPos;  
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
    name = ['position_function_' num '_3_pix_full_sin_in_120_samps' dirname '_pixel_' num2str(initPos)];
    save(name,'func'); clear func;
end
end
