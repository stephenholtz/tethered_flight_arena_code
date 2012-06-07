% Pos func failsafes --- ALWAYS RUN FULL SCRIPT!

count = 0;

cd('C:\tethered_flight_arena_code\position_functions\20111209\')

% Sweep functions

for sweep = 1:2;
    if sweep ==1; func = sort([0:95]);
    elseif sweep ==2; func = sort(([0:95]),'descend'); 
    end
    
    func = [func repmat(func(numel(func)),1,40)];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_full_sweep_in_96_samps_' dirname];
   save(name,'func'); clear func;
end

%play at 32 hz sampling to get 120 dps

% 360 deg / ( 96 samps / 32 Hz samp) = 120 dps (checked!)


% Now do same deg/s for only 49 samples..

for sweep = 1:2;
    if sweep ==1; func = sort([0:48]);
    elseif sweep ==2; func = sort(([0:48]),'descend'); 
    end
    
    func = [func repmat(func(numel(func)),1,40)];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_full_sweep_in_49_samps_' dirname];
   save(name,'func'); clear func;
end



% for sweep = 1:2;
%     if sweep ==1; func = sort([0:48]);
%     elseif sweep ==2; func = sort(([0:48]),'descend'); 
%     end
%     
%     func = [func repmat(func(numel(func)),1,40)];
%     
%    count = count +1;
%    if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
%    if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
%    name = ['position_function_' num '_debugging_' dirname];
%    save(name,'func'); clear func;
% end

% make another position function that moves with the same step frequency
% (i.e. degrees/sec) in 4 positions

for sweep = 1:2;
    if sweep ==1; func = sort(repmat(([0:7]),1,6),'ascend'); 
    elseif sweep ==2; func = sort(repmat(([0:7]),1,6),'descend'); 
    end
    
    func = [func repmat(func(numel(func)),1,40)];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_full_4_pos_sweep_in_49_samps' dirname];
   save(name,'func'); clear func;
end



