%%% Patterns on SD card

stripe_pat = 1;
pd4b = [5:-1:2]; pd4a = [9:-1:6]; 
pd_speed = 100; pd_bias = 94;

condition_num = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cond_num = 1;  num_CL_conditions = 0; %%rotation
    
for pp = 1:2 %%%before or after
    for ii = 1 %%48 frames
        for i = 1:length(pd_bias)
             for jj = 1:4 %%offsets are [0 1 2 3] for 48 frame pattern
                for k = 1:2
            
                  if pp == 1
                condition(cond_num).pattern = pd4b(ii);
                  else
                condition(cond_num).pattern = pd4a(ii);
                  end
                    
                condition(cond_num).Y_ind = jj; 
                condition(cond_num).X_ind = 1;

                condition(cond_num).Y_gain = 0;
                condition(cond_num).mode = [0 0];
                condition(cond_num).time = OL_time;
               
               if k == 1;
                 condition(cond_num).X_gain = pd_speed;
                 condition(cond_num).X_bias = pd_bias(i);

                else
                 condition(cond_num).X_gain = -pd_speed;
                 condition(cond_num).X_bias = -pd_bias(i);
               end
               
               cond_num = cond_num + 1;
                end
               
                end
        end
    end
end

for pp = 1:2
    for ii = 2 %%96 frames
        for i = 1:length(pd_bias)
                for jj = 1:6 %%offsets are [0 1 2 3 4 6] for 96 frame pattern
                                for k = 1:2
            
                    if pp == 1
                condition(cond_num).pattern = pd4b(ii);
                    else
                condition(cond_num).pattern = pd4a(ii);
                    end
                    
                condition(cond_num).Y_ind = jj; 
                condition(cond_num).X_ind = 1;

                condition(cond_num).Y_gain = 0;
                condition(cond_num).mode = [0 0];
                condition(cond_num).time = OL_time;
               
               if k == 1;
                 condition(cond_num).X_gain = pd_speed;
                 condition(cond_num).X_bias = pd_bias(i);

                else
                 condition(cond_num).X_gain = -pd_speed;
                 condition(cond_num).X_bias = -pd_bias(i);
               end
               cond_num = cond_num + 1;
                end
               
                end
        end
    end
end

for pp = 1:2
  for ii = [3] %% 192 pattern
        for i = 1:length(pd_bias)
                for jj = 1:8 %%offsets are [0 1 2 3 4 6 8 12] for 192 and 384 frame pattern
                                for k = 1:2
            
                    if pp == 1
                condition(cond_num).pattern = pd4b(ii);
                    else
                condition(cond_num).pattern = pd4a(ii);
                    end
   
                condition(cond_num).Y_ind = jj; 
                condition(cond_num).X_ind = 1;

                condition(cond_num).Y_gain = 0;
                condition(cond_num).mode = [0 0];
                condition(cond_num).time = OL_time;
               
               if k == 1;
                 condition(cond_num).X_gain = pd_speed;
                 condition(cond_num).X_bias = pd_bias(i);

                else
                 condition(cond_num).X_gain = -pd_speed;
                 condition(cond_num).X_bias = -pd_bias(i);
               end
               cond_num = cond_num + 1;
                end
               
                end
        end
  end
end

for pp = 1:2
   for ii = [4] %% 384 pattern only (1 Hz)
        for i = 1:length(pd_bias)
                for jj = 1:8 %%offsets are [0 1 2 3 4 6 8 12] for 192 and 384 frame pattern
                                for k = 1:2
            
                    if pp == 1
                condition(cond_num).pattern = pd4b(ii);
                    else
                condition(cond_num).pattern = pd4a(ii);
                    end
                 
                condition(cond_num).Y_ind = jj; 
                condition(cond_num).X_ind = 1;
                condition(cond_num).Y_gain = 0;
                condition(cond_num).mode = [0 0];
                condition(cond_num).time = OL_time;
               
               if k == 1;
                 condition(cond_num).X_gain = pd_speed;
                 condition(cond_num).X_bias = pd_bias(i);

                else
                 condition(cond_num).X_gain = -pd_speed;
                 condition(cond_num).X_bias = -pd_bias(i);
               end
               cond_num = cond_num + 1;
                end
               
                end
        end
   end
end

num_conditions = cond_num-1;

for j = 1:num_conditions
conds_matrix(j,:) = [j condition(j).pattern condition(j).Y_ind condition(j).X_ind condition(j).X_gain condition(j).X_bias condition(j).Y_gain condition(j).mode  condition(j).time];
end
