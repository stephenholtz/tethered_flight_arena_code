% Pos func failsafes --- ALWAYS RUN FULL SCRIPT!

count = 0;

cd('R:\slh_database\functions\20111201\')
figure;
% Wiggle functions
for phase = 1:2       % both phases
for amp = [24 12 4]         % three amplitudes
for wiggle = 1        % 1 position
    backPos = 0;
    positions = [0]+backPos;  
    initPos = positions(wiggle);
    
    % this gives an upswipe speed of 150deg/sec.... average spee over the whole sine
    % wave is slightly lower....  
    if phase == 1;  dunk = amp*make_sine_wave_function(2, 100, 1);
    elseif phase == 2; dunk = amp*circshift(make_sine_wave_function(2, 100, 1)',50)';
    end
    dunk = [dunk(1:101) dunk(1:101)];
    
    func =(dunk + initPos); func = round(func);
    func = [func repmat(func(numel(func)),1,40)];
    count = count +1;
    if phase == 1; dirname = '0'; else dirname = '+pi';end
    if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
    name = ['position_function_' num '_' num2str(amp) '_pix_full_sin_in_101_samps_242long_' dirname '_pixel_' num2str(initPos)];
    save(name,'func');
    
    plot(func); hold on;
    clear func
end
end
end