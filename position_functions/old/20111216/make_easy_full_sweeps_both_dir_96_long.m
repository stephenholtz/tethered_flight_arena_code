% Pos func failsafes --- ALWAYS RUN FULL SCRIPT!

count = 0;

cd('C:\tethered_flight_arena_code\position_functions\20111216\')

% Sweep functions

for sweep = 1;
%     if sweep ==1; func = sort([0:3]);
%     elseif sweep ==2; func = sort(([0:3]),'descend'); 
%     end
    func = [0 1 0 1];
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_debugging_' dirname];
   save(name,'func'); clear func;
end

for sweep = 1;
    if sweep ==1; func = sort([0:1,0:1]);
    elseif sweep ==2; func = sort(([0:1,0:1]),'descend'); 
    end
    
    
   count = count +1;
   if sweep == 1; dirname = 'CW'; else dirname = 'CCW';end
   if count < 10; num = [ '0' num2str(count)] ; else num = num2str(count); end
   name = ['position_function_' num '_debugging_' dirname];
   save(name,'func'); clear func;
end