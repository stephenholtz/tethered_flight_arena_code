         Panel_com('all_off');

% % Panel_com('set_config_id',2); %%full arena
Panel_com('set_config_id',4); %%half arena

for pat = 20:30
    
%%%%pd_speed = 100; pd_bias = 75; %%this is about the limit for full arena
%%%%%pd_speed = 118; pd_bias = 120%% this is about the limit for half arena
                     
                   pd_speed = 100; pd_bias = 60 ; 

Pattern_ID = pat;   
Gain_X = pd_speed;
 Bias_X = pd_bias;
 Ind_X = 1;
Gain_Y = 0;
Bias_Y = 0;
Ind_Y = 6  ; 
 
Time = 10;
Mode = [0 1];
             
             % 4 seconds of open loop
             Panel_com('set_mode',Mode);
             Panel_com('send_gain_bias',[Gain_X Bias_X Gain_Y Bias_Y]);
             Panel_com('set_pattern_id', Pattern_ID);
             Panel_com('set_position', [Ind_X Ind_Y]);
             
             Panel_com('start'); pat
             pause;  
             Panel_com('stop')

end

