close all;

movie_length = 3;
fps = 32;
scripts = {'telethon_bilateral_conditions_9_14'...
    'telethon_onoff_conditions_9_14'...
    'telethon_optic_flow_conditions_9_14'...
    'telethon_small_field_conditions_9_14'...
    'telethon_tuning_conditions_11_14'...
    'telethon_vel_nulling_conditions_9_14'};

%%frame rates of each movie. could also use pattern velocities
frame_rates(1).fps = 8*ones(1,12);
frame_rates(2).fps = [3*ones(1,4) 32*ones(1,4)];
frame_rates(3).fps = [60*ones(1,12)];
frame_rates(4).fps = [30*ones(1,19)];
frame_rates(5).fps = [16*ones(1,40)];
frame_rates(6).fps = [16*ones(1,30)];

pats_rot = 'R:\Telethon_Database\patterns\telethon_09_14_2011_pats\';
scripts_rot = 'R:\Telethon_Database\experiment_scripts\telethon_09_14_2011_scripts\';
funcs_rot = 'R:\Telethon_Database\functions\telethon_pos_funcs_09_14\';
movies_rot = 'R:\Telethon_Database\patterns\telethon_09_14_2011_pats\movies\';
cd(movies_rot);

for jj = 1:length(scripts)
    run([scripts_rot scripts{jj}]);
    for ii = 1:size(conds_matrix,1)
        
fps = frame_rates(jj).fps(ii);
if iscell(conds_matrix{ii,2})
pname = [pats_rot cell2mat(conds_matrix{ii,2})];
else
pname = [pats_rot conds_matrix{ii,2}];
end

load(pname); x_num = pattern.x_num;y_num = pattern.y_num;clear pattern;

conds.X_ind = conds_matrix{ii,6};
conds.Y_ind = conds_matrix{ii,7};
conds.X_gain = conds_matrix{ii,8};
conds.Y_gain = conds_matrix{ii,9};
clear frame_pos framepx framepy xinds yinds indsx indsy indsnx indsny;

if sum(conds_matrix{ii,10}) > 1;
conds.pos_func = conds_matrix{ii,13};load([funcs_rot conds.pos_func]);
frame_pos(1,:) = func(1:movie_length*fps)+conds.X_ind;%% X channel
frame_pos(2,:) = conds.Y_ind*ones(1,movie_length*fps);%%Y channel
else
    if conds.X_gain > 0
    framepx= conds.X_ind:(conds.X_gain*1000);
    frame_pos(1,:) = framepx(1:movie_length*fps);
    elseif conds.X_gain < 0
    framepx= -(conds.X_ind:(-conds.X_gain*1000));
    frame_pos(1,:) = framepx(1:movie_length*fps);
    else
    frame_pos(1,:) =  conds.X_ind*ones(1,movie_length*fps);
    end
    
    if conds.Y_gain > 0
    framepy= conds.Y_ind:(conds.Y_gain*1000);
    frame_pos(2,:) = framepy(1:movie_length*fps);
    elseif conds.Y_gain < 0
    framepy= -(conds.Y_ind:(-conds.Y_gain*1000));
    frame_pos(2,:) = framepy(1:movie_length*fps);
    else
    frame_pos(2,:) =  conds.Y_ind*ones(1,movie_length*fps);
    end
end

%% make sure patterns wrap around
while any(frame_pos(1,:) > x_num)
clear indsx;
indsx = frame_pos(1,:) > x_num; frame_pos(1,indsx) = frame_pos(1,indsx) - x_num;
end

while any(frame_pos(1,:) < 1)
clear indsnx;
indsnx = frame_pos(1,:) < 1; frame_pos(1,indsnx) = frame_pos(1,indsnx) + x_num;
end

while any(frame_pos(2,:) > y_num)
clear indsy;
indsy = frame_pos(2,:) > y_num; frame_pos(2,indsy) = frame_pos(2,indsy) - y_num;
end

while any(frame_pos(2,:) < 1)
clear indsnx;
indsny = frame_pos(2,:) < 1; frame_pos(2,indsny) = frame_pos(2,indsny) + y_num;
end

%%
% figure(2);clf;hold on; plot(frame_pos(1,:),'b');plot(frame_pos(2,:),'r');pause;hold off;

title_struct.title_seq = ones(1,length(frame_pos));
title_struct.title(1).name = pname(56:length(pname)-4);
ST1 = animate_pattern_11_28(pname, frame_pos', [100 100 750 250], [pname(64:70) '_' num2str(jj) '_' num2str(ii)], fps, title_struct);

%% space-time diagram
% figure; image(ST1); 
% C = [0 0 0; 0 2/8 0; 0 3/8 0; 0 4/8 0; 0 5/8 0; 0 6/8 0; 0 7/8 0; 0 1 0];  % 8 levels of gscale   
% axis off; axis image; colormap(C);

    end
end