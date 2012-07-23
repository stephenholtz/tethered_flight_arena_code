function OL_pd_1_1(conds_to_run, exp)
 exp = 1;
global pd_speed;
global pd_bias;
 
% Pats = get_pats('C:\Matlabroot\Panel_controller_11_9_2010\Patterns\rp_pd_2011\all_together'); %%the pats list
% Panel_com('all_off');
% Panel_com('set_config_id',2); %%only 2 middle rows

pd_speed = 100; pd_bias = 94 ; %%%%%pd_speed = 118; pd_bias = 120  is the limit for y = 1 on these pats
OL_time = 3;
CL_interval_time = 3.5; CL_gain = -8;

switch exp
    case 1
        script = 'pd_conditions_rot_4wide_1_11';%%% the name of the script
        pd_conditions_rot_4wide_1_11; %%runs the conditions script
        range = linspace(0.05,1,num_conditions);%%the voltage range to encode conditions for this experiment
    case 2
        script = 'pd_conditions_rot_8wide_1_11';%%% the name of the script
        pd_conditions_rot_8wide_1_11; %%runs the conditions script
        range = linspace(1.05,2,num_conditions);
    case 3
        script = 'pd_conditions_exp_4wide_1_11';%%% the name of the script
        pd_conditions_exp_4wide_1_11; %%runs the conditions script
        range = linspace(2.05,3,num_conditions);
    case 4
        script = 'pd_conditions_exp_8wide_1_11';%%% the name of the script
        pd_conditions_exp_8wide_1_11; %%runs the conditions script
        range = linspace(3.05,4,num_conditions);
end



AO = analogoutput('mcc');
chans = addchannel(AO, [0]); 

AI = analoginput('mcc');
chans = addchannel(AI, [0]);   

DO1 = digitalio('mcc'); %%changed 11/17
puffer = addline(DO1,0,0,'out');

times = 0; conds_missed = []; num_reps = 3; CL_gain = -13;

% start with n seconds of closed loop before experiment begins
fprintf('first trial: dark stripe, bright background...\n');
[times conds_missed] = half_arena_stripe_fix_trial(AO, AI, DO1, CL_interval_time, stripe_pat, [1 0], [CL_gain, 0, 0, 0], [49 1], times, conds_missed, condition_num);

for i = 1:num_reps      
       
    if isempty(conds_to_run)
        conds_to_run = randperm(num_conditions);
    end
    
    fprintf(strcat('conds2run =', num2str(conds_to_run), ' \n'));

    for j = 1:length(conds_to_run)
        condition_num = conds_to_run(j);
        Pattern_ID = condition(condition_num).pattern; 
        spee = condition(condition_num).X_gain;
        bias = condition(condition_num).X_bias;
        Pos_X = condition(condition_num).X_ind;
        Pos_Y = condition(condition_num).Y_ind;
        
        fprintf('rep %d, cond %d, speed %d, Cond_# %d,  \n',i,j, spee, condition_num);
       % Panel_com('set_config_id',2); %%only 2 middle rows
       % Panel_com('all_off');
        Panel_com('set_pattern_id', Pattern_ID);   
        Panel_com('set_mode',[0 0]);
        Panel_com('send_gain_bias',[spee bias 0 0]);
        Panel_com('set_position', [Pos_X Pos_Y]);     

         putsample(AO, [condition_num/(num_conditions/4)]) % scale condition number to fit in 0-4V range

         Panel_com('start')
         pause(OL_time)
         Panel_com('stop')

         fprintf('stripe fix \n');
[times conds_missed] = half_arena_stripe_fix_trial(AO, AI, DO1, CL_interval_time, stripe_pat, [1 0], [CL_gain, 0, 0, 0], [49 1], times, conds_missed, condition_num);
              
    end
end
   
    if isempty(conds_missed) == 0 && num_reps > 1;
   conds_to_run = conds_missed;
    OL_pd_1_1(conds_to_run, exp)
    else
    end
    
%     if num_reps > 1 && text == 1;
%     send_text_message('207-314-8294','verizon','alert','fly completed')
%     end
    
clear AO
clear AI
clear DO1
