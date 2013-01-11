% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/progressive_regressive_spatial_freq_comparison_v01/';

exp_dir = data_location;

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';

%% Process initial raw data and save summary.mat files

if 0
    for i = 1:numel(geno_names)
        geno = tfAnalysis.import(fullfile(data_location,geno_names{i}),'all');
        summary_filename = [geno_names{i} '_summary'];
        eval([summary_filename ' = geno;']);
        save(fullfile(exp_dir,geno_names{i},summary_filename),summary_filename);
    end
end

%% Load in summary files

if 0
    
    for g = 1:numel(geno_names)
        [summary_file,summary_filepath] = returnDirFileList(fullfile(data_location,geno_names{g}),'summary.mat');
        load(summary_filepath{:});
        
        geno_data{g} = tfAnalysis.ExpSet(eval(summary_file{1}(1:end-4))); %#ok<*AGROW>
    end
    
end

%% Use summary files to save specific subsets of data in tuning_curves.mat

if 0
    % Calculate normalization value per genotype
    for i = 1:numel(geno_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp;
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:32
            % All of the individual tuning curves to be saved:
            %
            if      condition_set_number == 1
                        curve_name = 'prog_l_15_r_15';
            elseif  condition_set_number == 2
                        curve_name = 'prog_l_30_r_15';
            elseif  condition_set_number == 3
                        curve_name = 'prog_l_60_r_15';
            elseif  condition_set_number == 4
                        curve_name = 'prog_l_90_r_15';
            elseif  condition_set_number == 5
                        curve_name = 'prog_l_15_r_30';
            elseif  condition_set_number == 6
                        curve_name = 'prog_l_30_r_30';
            elseif  condition_set_number == 7
                        curve_name = 'prog_l_60_r_30';
            elseif  condition_set_number == 8
                        curve_name = 'prog_l_90_r_30';
            elseif  condition_set_number == 9
                        curve_name = 'prog_l_15_r_60';
            elseif  condition_set_number == 10
                        curve_name = 'prog_l_30_r_60';
            elseif  condition_set_number == 11
                        curve_name = 'prog_l_60_r_60';
            elseif  condition_set_number == 12
                        curve_name = 'prog_l_90_r_60';
            elseif  condition_set_number == 13
                        curve_name = 'prog_l_15_r_90';
            elseif  condition_set_number == 14
                        curve_name = 'prog_l_30_r_90';
            elseif  condition_set_number == 15
                        curve_name = 'prog_l_60_r_90';
            elseif  condition_set_number == 16
                        curve_name = 'prog_l_90_r_90';
            elseif  condition_set_number == 17
                        curve_name = 'reg_l_15_r_15';
            elseif  condition_set_number == 18
                        curve_name = 'reg_l_30_r_15';
            elseif  condition_set_number == 19
                        curve_name = 'reg_l_60_r_15';
            elseif  condition_set_number == 20
                        curve_name = 'reg_l_90_r_15';
            elseif  condition_set_number == 21
                        curve_name = 'reg_l_15_r_30';
            elseif  condition_set_number == 22
                        curve_name = 'reg_l_30_r_30';
            elseif  condition_set_number == 23
                        curve_name = 'reg_l_60_r_30';
            elseif  condition_set_number == 24
                        curve_name = 'reg_l_90_r_30';
            elseif  condition_set_number == 25
                        curve_name = 'reg_l_15_r_60';
            elseif  condition_set_number == 26
                        curve_name = 'reg_l_30_r_60';
            elseif  condition_set_number == 27
                        curve_name = 'reg_l_60_r_60';
            elseif  condition_set_number == 28
                        curve_name = 'reg_l_90_r_60';
            elseif  condition_set_number == 29
                        curve_name = 'reg_l_15_r_90';
            elseif  condition_set_number == 30
                        curve_name = 'reg_l_30_r_90';
            elseif  condition_set_number == 31
                        curve_name = 'reg_l_60_r_90';
            elseif  condition_set_number == 32
                        curve_name = 'reg_l_90_r_90';
            end
            
            condition_numbers = geno_data{i}.grouped_conditions{condition_set_number}.list;
            
            % L - R data normalized
            [avg, variance]                 = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i));
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i));
            
            tuning_curves.(curve_name){i}.avg               = cell2mat(avg);
            tuning_curves.(curve_name){i}.sem               = cell2mat(variance);
            tuning_curves.(curve_name){i}.avg_ts            = avg_ts;
            tuning_curves.(curve_name){i}.sem_ts            = variance_ts;
            
            % L - R data not normalized (*_nn)            
            [avg_nn, variance_nn]                 = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',1);
            [avg_ts_nn, variance_ts_nn]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',1);
            
            tuning_curves.(curve_name){i}.avg_nn               = cell2mat(avg_nn);
            tuning_curves.(curve_name){i}.sem_nn               = cell2mat(variance_nn);
            tuning_curves.(curve_name){i}.avg_ts_nn            = avg_ts_nn;
            tuning_curves.(curve_name){i}.sem_ts_nn            = variance_ts_nn;
            
            
            tuning_curves.(curve_name){i}.tf                = geno_data{i}.grouped_conditions{condition_set_number}.tf;
            tuning_curves.(curve_name){i}.speed             = geno_data{i}.grouped_conditions{condition_set_number}.speed;
            tuning_curves.(curve_name){i}.condition_numbers = condition_numbers;
            tuning_curves.(curve_name){i}.name              = geno_data{i}.experiment{1}.line_name;
            tuning_curves.(curve_name){i}.num               = numel(geno_data{i}.experiment);
            
            % L and R Data, no normalization here...
            
%             [l_wba_avg, l_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','mean','yes','all',1);
%             [l_wba_avg_ts, l_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','none','yes','all',1);
%             
%             [r_wba_avg, r_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','mean','yes','all',1);            
%             [r_wba_avg_ts, r_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','none','yes','all',1);
%             
%             tuning_curves.(curve_name){i}.l_wba_avg               = cell2mat(l_wba_avg);
%             tuning_curves.(curve_name){i}.l_wba_sem               = cell2mat(l_wba_sem);
%             tuning_curves.(curve_name){i}.l_wba_avg_ts            = l_wba_avg_ts;
%             tuning_curves.(curve_name){i}.l_wba_sem_ts            = l_wba_sem_ts;
%             
%             tuning_curves.(curve_name){i}.r_wba_avg               = cell2mat(r_wba_avg);
%             tuning_curves.(curve_name){i}.r_wba_sem               = cell2mat(r_wba_sem);
%             tuning_curves.(curve_name){i}.r_wba_avg_ts            = r_wba_avg_ts;
%             tuning_curves.(curve_name){i}.r_wba_sem_ts            = r_wba_sem_ts;
  
        end
    end
    
    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

%% Make a figure from the data in tuning_curves.mat

if 1
    
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[238 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map = {[205 201 201]/255};
    
    % Iterate over graph_geno_sets (different combinations of genotypes)
    % tuning_curve takes 'graph' structure with .avg, .variance, .color
    % timeseries   " "
    
    % Easily make a few quick comparisons
        FIG_SET = 4;
        %FIG_SET = 2;
        %FIG_SET = 3;
        
    switch FIG_SET
        case 1
            graph_geno_sets =  {[1,1],...
                                [2,1],...
                                [3,1],...
                                [4,1],...
                                [5,1]};
        case 2
            graph_geno_sets = {[4, 1]};
        case 3
            graph_geno_sets = {[2,1,3,4,5]};
        case 4
            graph_geno_sets = {1};
    end
    
    % Iterate over the plotted graph contents
    PLOT_CONTENTS = 1;
    %PLOT_CONTENTS = 2;
    %PLOT_CONTENTS = 3;
    
    switch PLOT_CONTENTS
        case 1
            % Just the lmr plots
            plot_content_fields = 1;
        case 2
            % The lmr, l r, and l r lmr plots
            plot_content_fields = [1,2,3];
        case 3
            plot_content_fields = [1,4];
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%----- FIGURE MAKING STARTS HERE ---------------------------------------%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%---- EDIT HERE
    for geno_set = graph_geno_sets
        
        % Make a figure name
        fig_name = tuning_curves.prog_l_15_r_15{geno_set{1}(1)}.name(5:end);
        legend_name{1} = fig_name;
        
        if numel(geno_set{1}) > 1
            for i = 2:numel(geno_set{1})
                fig_name = [fig_name '_vs_' tuning_curves.phi_30{geno_set{1}(i)}.name(5:end)];
                legend_name{i} = tuning_curves.phi_30{geno_set{1}(i)}.name(5:end); %#ok<*SAGROW>
            end
        end
            
        % Correclty add cell types to each genotype
        for name_iter = 1:numel(legend_name)
            switch legend_name{name_iter}
                case {'gmr_20c11ad_48d11dbd','20c11ad_48d11dbd'}
                    cell_type = '(C2+C3)';
                case {'gmr_25b02ad_48d11dbd','25b02ad_48d11dbd'}
                    cell_type = '(C2)';
                case {'gmr_31c06_34g07dbd','31c06_34g07dbd'}
                    cell_type = '(L4)';
                case {'gmr_35a03ad_29g11dbd','35a03ad_29g11dbd'}
                    cell_type = '(C3)';
                case {'gmr_29g11dbd','29g11dbd','48a08ad','gmr_48a08ad'}
                    cell_type = '(ctrl)';
                otherwise
                    cell_type = '(?)';
            end
            
            legend_name{name_iter} = [legend_name{name_iter} ' ' cell_type];
        end
        
        for plot_contents = plot_content_fields
if 0            
%-----------Giant Raw Figure-----------
            % Averaged timeseries for each of the stimuli.

            for cond_set_group = 1:2
                switch cond_set_group
                    case 1
                        mot_str = 'Progressive Motion';
                        mot = 'prog';
                        cond_set_nums = 1:16;
                    case 2
                        mot_str = 'Regressive Motion';
                        mot = 'reg';
                        cond_set_nums = 17:32;
                end
                
                switch plot_contents
                    case 1
                        rawFigHandle(plot_contents) = figure(  'Name',['Summary Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                            'Color',[1 1 1],'Position',[50 50 755 500],...
                                            'PaperOrientation','portrait');
                    case 2
                        rawFigHandle(plot_contents) = figure(  'Name',['L R Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                        'Color',[1 1 1],'Position',[50 50 755 755],...
                                        'PaperOrientation','portrait');
                    case 3
                        rawFigHandle(plot_contents) = figure(  'Name',['L R LmR Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                        'Color',[1 1 1],'Position',[50 50 755 755],...
                                        'PaperOrientation','portrait');                
                end

                graph.avg = [];
                graph.variance = [];
                condition_iter = 0;                
                total_x_plots = 12;
                total_y_plots = 5;
                
            % silly plot placement info
            raw_graph_width     = .92/(total_x_plots+2);
            raw_graph_height    = 1/(total_y_plots) - .035;

            start_x_pos = .089;
            start_y_pos = .91;
            
            sub_x_offset    = raw_graph_width+.005;
            y_offset        = raw_graph_height+.04;

            for condition_set_number = cond_set_nums
            
            if      condition_set_number == 1
                        curve_name = 'prog_l_15_r_15';
            elseif  condition_set_number == 2
                        curve_name = 'prog_l_30_r_15';
            elseif  condition_set_number == 3
                        curve_name = 'prog_l_60_r_15';
            elseif  condition_set_number == 4
                        curve_name = 'prog_l_90_r_15';
            elseif  condition_set_number == 5
                        curve_name = 'prog_l_15_r_30';
            elseif  condition_set_number == 6
                        curve_name = 'prog_l_30_r_30';
            elseif  condition_set_number == 7
                        curve_name = 'prog_l_60_r_30';
            elseif  condition_set_number == 8
                        curve_name = 'prog_l_90_r_30';
            elseif  condition_set_number == 9
                        curve_name = 'prog_l_15_r_60';
            elseif  condition_set_number == 10
                        curve_name = 'prog_l_30_r_60';
            elseif  condition_set_number == 11
                        curve_name = 'prog_l_60_r_60';
            elseif  condition_set_number == 12
                        curve_name = 'prog_l_90_r_60';
            elseif  condition_set_number == 13
                        curve_name = 'prog_l_15_r_90';
            elseif  condition_set_number == 14
                        curve_name = 'prog_l_30_r_90';
            elseif  condition_set_number == 15
                        curve_name = 'prog_l_60_r_90';
            elseif  condition_set_number == 16
                        curve_name = 'prog_l_90_r_90';
            elseif  condition_set_number == 17
                        curve_name = 'reg_l_15_r_15';
            elseif  condition_set_number == 18
                        curve_name = 'reg_l_30_r_15';
            elseif  condition_set_number == 19
                        curve_name = 'reg_l_60_r_15';
            elseif  condition_set_number == 20
                        curve_name = 'reg_l_90_r_15';
            elseif  condition_set_number == 21
                        curve_name = 'reg_l_15_r_30';
            elseif  condition_set_number == 22
                        curve_name = 'reg_l_30_r_30';
            elseif  condition_set_number == 23
                        curve_name = 'reg_l_60_r_30';
            elseif  condition_set_number == 24
                        curve_name = 'reg_l_90_r_30';
            elseif  condition_set_number == 25
                        curve_name = 'reg_l_15_r_60';
            elseif  condition_set_number == 26
                        curve_name = 'reg_l_30_r_60';
            elseif  condition_set_number == 27
                        curve_name = 'reg_l_60_r_60';
            elseif  condition_set_number == 28
                        curve_name = 'reg_l_90_r_60';
            elseif  condition_set_number == 29
                        curve_name = 'reg_l_15_r_90';
            elseif  condition_set_number == 30
                        curve_name = 'reg_l_30_r_90';
            elseif  condition_set_number == 31
                        curve_name = 'reg_l_60_r_90';
            elseif  condition_set_number == 32
                        curve_name = 'reg_l_90_r_90';
            end
            
            condition_iter = condition_iter + 1;

            if condition_iter > 1
                start_x_pos = start_x_pos + sub_x_offset*3 +.01;
                if ~mod(condition_iter-1,4)
                    start_x_pos = .089;
                end
            end
            
            if ~mod(condition_iter-1,4)
                start_y_pos = start_y_pos - y_offset;
            end
                
                for stim_index = 1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.speed);
                    
                    
                    sp_position = [start_x_pos+(sub_x_offset*(stim_index-1)),...
                                        start_y_pos,...
                                        raw_graph_width,...
                                        raw_graph_height];
                    
                    subplot('Position',sp_position);
                    
                    switch plot_contents
                        case 1
                            % standard lmr plots
                            for i = 1:numel(geno_set{1})
                                graph.avg{i}       = tuning_curves.(curve_name){geno_set{1}(i)}.avg_ts{stim_index};
                                graph.variance{i}  = tuning_curves.(curve_name){geno_set{1}(i)}.sem_ts{stim_index};
                                graph.color{i}     = my_colormap{i};
                            end
                        case 2
                            % Only plot out one genotype at a time, and
                            % plot l and r separately
                            for i = 1
                                graph.avg{1}       = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg_ts{stim_index};
                                graph.variance{1}  = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem_ts{stim_index};
                                graph.color{1}     = my_lr_colormap{1};

                                graph.avg{2}       = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg_ts{stim_index};
                                graph.variance{2}  = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem_ts{stim_index};
                                graph.color{2}     = my_lr_colormap{2};                        
                            end
                        case 3
                            % Only plot out one genotype at a time, and do
                            % L, R, lmr
                            for i = 1
                                graph.avg{1}       = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg_ts{stim_index};
                                graph.variance{1}  = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem_ts{stim_index};
                                graph.color{1}     = my_lr_colormap{1};

                                graph.avg{2}       = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg_ts{stim_index};
                                graph.variance{2}  = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem_ts{stim_index};
                                graph.color{2}     = my_lr_colormap{2};   
                                
                                graph.avg{3}       = tuning_curves.(curve_name){geno_set{1}(1)}.avg_ts{stim_index};
                                graph.variance{3}  = tuning_curves.(curve_name){geno_set{1}(1)}.sem_ts{stim_index};
                                graph.color{3}     = my_colormap{1};                                
                            end                  
                    end
                    
                    tfPlot.timeseries(graph);
                    if condition_iter < 5
                        title(tuning_curves.(curve_name){geno_set{1}(1)}.tf(stim_index))
                    end
                    box off;
                    
                    if plot_contents == 1
                        set(gca,'Ylim',[-3.85 3.85])
                    else
                        set(gca,'Ylim',[-3.85 3.85])
                    end
                    if stim_index == 1 && condition_iter == 13
                        axis on;
                        set(gca,'XTickLabel',{'.5','1','1.5','2'})
                        xlabel('Time (s)')
                    elseif stim_index == 1
                        axis on;
                        set(gca,'XTickLabel',{''})
%                     % Change the legends for different plot_contents
%                     elseif condition_set_number == 6 && stim_index == 5;
%                         
%                         switch plot_contents
%                             case 1
%                                 legend_cell{1} = '0';
%                                 name_ind = 1;
%                                 for name_iter = 1:numel(legend_name)
%                                     name_ind = name_ind + 1;
%                                     legend_cell{name_ind} = legend_name{name_iter};
%                                     name_ind = name_ind + 1;
%                                     legend_cell{name_ind} = [' SEM, N = ' num2str(tuning_curves.(curve_name){geno_set{1}(name_iter)}.num)];
%                                 end
%                                 l_hand = legend(legend_cell);
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                             case 2
%                                 l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem');
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                             case 3
%                                 l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem',['L-R_ ' legend_name{1}],'sem');
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                         end
%                         
%                         axis off;
                    else
                        axis off;
                    end
%                     if mod(condition_iter,2)
%                         ylabel({'',curve_name},'interpreter','none')
%                     else
%                         ylabel({curve_name,''},'interpreter','none')
%                     end
                end


            end
            
            annotation('textbox','position',[.33  .945 .25 .05],'string',mot_str,...
                            'EdgeColor','none',...
                            'fontsize',14);

            annotation('textbox','position',[.073  .913 .25 .05],'string','Right:',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.2 .913 .25 .05],'string',' \lambda 15',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.4 .913 .25 .05],'string',' \lambda 30',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.6 .913 .25 .05],'string','\lambda 60',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.8 .913 .25 .05],'string','\lambda 90',...
                            'EdgeColor','none',...
                            'fontsize',14);      
            annotation('textbox','position',[.003  .9 .25 .05],'string',{'Left:'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.2 .25 .05],'string',{' \lambda 15'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.4 .25 .05],'string',{' \lambda 30'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.6 .25 .05],'string',{' \lambda 60'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.8 .25 .05],'string',{' \lambda 90'},...
                            'EdgeColor','none',...
                            'fontsize',14);
                        
%             annotation('textbox','position',[.0177  .954 .25 .05],'string',mot_str,...
%                             'EdgeColor','none',...
%                             'fontsize',18);            
            annotation('textbox','position',[.077  .863 .05 .05],'string','Hz:',...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',10);

%             annotation('textbox','position',[.276  .942 .2 .05],'string','Regular-Phi',...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%             annotation('textbox','position',[.69  .942 .2 .05],'string','Reverse-Phi',...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%                         
%             if plot_contents ~= 1    
%                 annotation('textbox','position',[.55  .1 .9 .1],'string',...
%                             {[legend_name{1} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num)],...
%                              [legend_name{2} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num)]},...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%             end          
%             subplot('Position',[.1  .95 .02 .015])
%             rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',my_colormap{1});
%             box off; axis off;
%             annotation('textbox','Position',[.005  .95 .15 .02],'string','Stim LmR',...
%                                 'interpreter','none','EdgeColor','none',...
%                                 'fontsize',10);
%             %subplot('Position',[.1  .95 .2 .015])
%             annotation('line','position',[.012  .93 .14 0],'Color',[0 0 0]);
%             box off; axis off;
%             annotation('textbox','Position',[.01  .97 .15 .02],'string',{'+ Follows Left','','- Follows Right'},...
%                                 'interpreter','none','EdgeColor','none',...
%                                 'fontsize',14);
            % Save the giant raw wing beat figure
            switch plot_contents
                case 1
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['raw_turns_lam_' mot '_' fig_name]),'-pdf')
                case 2
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['L_R_wba_ts_lam_' mot '_' fig_name]),'-pdf')
                case 3
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['L_R_LmR_wba_ts_lam_' mot '_' fig_name]),'-pdf')
            end
            
            end
end

if 1            
%-----------Subs of Raw Figure-----------
            % Averaged timeseries for each of the stimuli.

            for cond_set_group = 1:2
                switch cond_set_group
                    case 1
                        mot_str = 'Progressive Motion';
                        mot = 'prog';
                        cond_set_nums = 1:16;
                    case 2
                        mot_str = 'Regressive Motion';
                        mot = 'reg';
                        cond_set_nums = 17:32;
                end
                
                switch plot_contents
                    case 1
                        rawFigHandle(plot_contents) = figure(  'Name',['Summary Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                            'Color',[1 1 1],'Position',[50 50 755 500],...
                                            'PaperOrientation','portrait');
                    case 2
                        rawFigHandle(plot_contents) = figure(  'Name',['L R Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                        'Color',[1 1 1],'Position',[50 50 755 755],...
                                        'PaperOrientation','portrait');
                    case 3
                        rawFigHandle(plot_contents) = figure(  'Name',['L R LmR Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                        'Color',[1 1 1],'Position',[50 50 755 755],...
                                        'PaperOrientation','portrait');                
                end

                graph.avg = [];
                graph.variance = [];
                condition_iter = 0;                
                total_x_plots = 4;
                total_y_plots = 5;
                
            % silly plot placement info
            raw_graph_width     = .92/(total_x_plots+2);
            raw_graph_height    = 1/(total_y_plots) - .035;
            
            start_x_pos = .089;
            start_y_pos = .91;
            
            sub_x_offset    = raw_graph_width+.005;
            y_offset        = raw_graph_height+.04;

            for condition_set_number = cond_set_nums
            
            if      condition_set_number == 1
                        curve_name = 'prog_l_15_r_15';
            elseif  condition_set_number == 2
                        curve_name = 'prog_l_30_r_15';
            elseif  condition_set_number == 3
                        curve_name = 'prog_l_60_r_15';
            elseif  condition_set_number == 4
                        curve_name = 'prog_l_90_r_15';
            elseif  condition_set_number == 5
                        curve_name = 'prog_l_15_r_30';
            elseif  condition_set_number == 6
                        curve_name = 'prog_l_30_r_30';
            elseif  condition_set_number == 7
                        curve_name = 'prog_l_60_r_30';
            elseif  condition_set_number == 8
                        curve_name = 'prog_l_90_r_30';
            elseif  condition_set_number == 9
                        curve_name = 'prog_l_15_r_60';
            elseif  condition_set_number == 10
                        curve_name = 'prog_l_30_r_60';
            elseif  condition_set_number == 11
                        curve_name = 'prog_l_60_r_60';
            elseif  condition_set_number == 12
                        curve_name = 'prog_l_90_r_60';
            elseif  condition_set_number == 13
                        curve_name = 'prog_l_15_r_90';
            elseif  condition_set_number == 14
                        curve_name = 'prog_l_30_r_90';
            elseif  condition_set_number == 15
                        curve_name = 'prog_l_60_r_90';
            elseif  condition_set_number == 16
                        curve_name = 'prog_l_90_r_90';
            elseif  condition_set_number == 17
                        curve_name = 'reg_l_15_r_15';
            elseif  condition_set_number == 18
                        curve_name = 'reg_l_30_r_15';
            elseif  condition_set_number == 19
                        curve_name = 'reg_l_60_r_15';
            elseif  condition_set_number == 20
                        curve_name = 'reg_l_90_r_15';
            elseif  condition_set_number == 21
                        curve_name = 'reg_l_15_r_30';
            elseif  condition_set_number == 22
                        curve_name = 'reg_l_30_r_30';
            elseif  condition_set_number == 23
                        curve_name = 'reg_l_60_r_30';
            elseif  condition_set_number == 24
                        curve_name = 'reg_l_90_r_30';
            elseif  condition_set_number == 25
                        curve_name = 'reg_l_15_r_60';
            elseif  condition_set_number == 26
                        curve_name = 'reg_l_30_r_60';
            elseif  condition_set_number == 27
                        curve_name = 'reg_l_60_r_60';
            elseif  condition_set_number == 28
                        curve_name = 'reg_l_90_r_60';
            elseif  condition_set_number == 29
                        curve_name = 'reg_l_15_r_90';
            elseif  condition_set_number == 30
                        curve_name = 'reg_l_30_r_90';
            elseif  condition_set_number == 31
                        curve_name = 'reg_l_60_r_90';
            elseif  condition_set_number == 32
                        curve_name = 'reg_l_90_r_90';
            end
            
            condition_iter = condition_iter + 1;

            if condition_iter > 1
%                start_x_pos = start_x_pos +.01;
                if ~mod(condition_iter-1,4)
                    start_x_pos = .089;
                end
            end
            
            if ~mod(condition_iter-1,4)
                start_y_pos = start_y_pos - y_offset;
            end
                
                for stim_index = 2%1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.speed);
                    
                    
                    sp_position = [start_x_pos+(sub_x_offset*(stim_index-1)),...
                                        start_y_pos,...
                                        raw_graph_width,...
                                        raw_graph_height];
                    
                    subplot('Position',sp_position);
                    
                    switch plot_contents
                        case 1
                            % standard lmr plots
                            for i = 1:numel(geno_set{1})
                                graph.avg{i}       = tuning_curves.(curve_name){geno_set{1}(i)}.avg_ts{stim_index};
                                graph.variance{i}  = tuning_curves.(curve_name){geno_set{1}(i)}.sem_ts{stim_index};
                                graph.color{i}     = my_colormap{i};
                            end
                        case 2
                            % Only plot out one genotype at a time, and
                            % plot l and r separately
                            for i = 1
                                graph.avg{1}       = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg_ts{stim_index};
                                graph.variance{1}  = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem_ts{stim_index};
                                graph.color{1}     = my_lr_colormap{1};

                                graph.avg{2}       = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg_ts{stim_index};
                                graph.variance{2}  = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem_ts{stim_index};
                                graph.color{2}     = my_lr_colormap{2};                        
                            end
                        case 3
                            % Only plot out one genotype at a time, and do
                            % L, R, lmr
                            for i = 1
                                graph.avg{1}       = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg_ts{stim_index};
                                graph.variance{1}  = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem_ts{stim_index};
                                graph.color{1}     = my_lr_colormap{1};

                                graph.avg{2}       = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg_ts{stim_index};
                                graph.variance{2}  = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem_ts{stim_index};
                                graph.color{2}     = my_lr_colormap{2};   
                                
                                graph.avg{3}       = tuning_curves.(curve_name){geno_set{1}(1)}.avg_ts{stim_index};
                                graph.variance{3}  = tuning_curves.(curve_name){geno_set{1}(1)}.sem_ts{stim_index};
                                graph.color{3}     = my_colormap{1};                                
                            end                  
                    end
                    
                    tfPlot.timeseries(graph);
                    if condition_iter < 5
                        title(tuning_curves.(curve_name){geno_set{1}(1)}.tf(stim_index))
                    end
                    box off;
                    
                    if plot_contents == 1
                        set(gca,'Ylim',[-3.85 3.85])
                    else
                        set(gca,'Ylim',[-3.85 3.85])
                    end
                    if stim_index == 1 && condition_iter == 13
                        axis on;
                        set(gca,'XTickLabel',{'.5','1','1.5','2'})
                        xlabel('Time (s)')
                    elseif stim_index == 1
                        axis on;
                        set(gca,'XTickLabel',{''})
%                     % Change the legends for different plot_contents
%                     elseif condition_set_number == 6 && stim_index == 5;
%                         
%                         switch plot_contents
%                             case 1
%                                 legend_cell{1} = '0';
%                                 name_ind = 1;
%                                 for name_iter = 1:numel(legend_name)
%                                     name_ind = name_ind + 1;
%                                     legend_cell{name_ind} = legend_name{name_iter};
%                                     name_ind = name_ind + 1;
%                                     legend_cell{name_ind} = [' SEM, N = ' num2str(tuning_curves.(curve_name){geno_set{1}(name_iter)}.num)];
%                                 end
%                                 l_hand = legend(legend_cell);
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                             case 2
%                                 l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem');
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                             case 3
%                                 l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem',['L-R_ ' legend_name{1}],'sem');
%                                 set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                         end
%                         
%                         axis off;
                    else
                        axis off;
                    end
%                     if mod(condition_iter,2)
%                         ylabel({'',curve_name},'interpreter','none')
%                     else
%                         ylabel({curve_name,''},'interpreter','none')
%                     end
                end


            end
            
            annotation('textbox','position',[.33  .945 .25 .05],'string',mot_str,...
                            'EdgeColor','none',...
                            'fontsize',14);

            annotation('textbox','position',[.073  .913 .25 .05],'string','Right:',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.2 .913 .25 .05],'string',' \lambda 15',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.4 .913 .25 .05],'string',' \lambda 30',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.6 .913 .25 .05],'string','\lambda 60',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.8 .913 .25 .05],'string','\lambda 90',...
                            'EdgeColor','none',...
                            'fontsize',14);      
            annotation('textbox','position',[.003  .9 .25 .05],'string',{'Left:'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.2 .25 .05],'string',{' \lambda 15'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.4 .25 .05],'string',{' \lambda 30'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.6 .25 .05],'string',{' \lambda 60'},...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.003  1-.8 .25 .05],'string',{' \lambda 90'},...
                            'EdgeColor','none',...
                            'fontsize',14);
                        
%             annotation('textbox','position',[.0177  .954 .25 .05],'string',mot_str,...
%                             'EdgeColor','none',...
%                             'fontsize',18);            
            annotation('textbox','position',[.077  .863 .05 .05],'string','Hz:',...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',10);

%             annotation('textbox','position',[.276  .942 .2 .05],'string','Regular-Phi',...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%             annotation('textbox','position',[.69  .942 .2 .05],'string','Reverse-Phi',...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%                         
%             if plot_contents ~= 1    
%                 annotation('textbox','position',[.55  .1 .9 .1],'string',...
%                             {[legend_name{1} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num)],...
%                              [legend_name{2} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num)]},...
%                             'interpreter','none','EdgeColor','none',...
%                             'fontsize',12);
%             end          
%             subplot('Position',[.1  .95 .02 .015])
%             rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',my_colormap{1});
%             box off; axis off;
%             annotation('textbox','Position',[.005  .95 .15 .02],'string','Stim LmR',...
%                                 'interpreter','none','EdgeColor','none',...
%                                 'fontsize',10);
%             %subplot('Position',[.1  .95 .2 .015])
%             annotation('line','position',[.012  .93 .14 0],'Color',[0 0 0]);
%             box off; axis off;
%             annotation('textbox','Position',[.01  .97 .15 .02],'string',{'+ Follows Left','','- Follows Right'},...
%                                 'interpreter','none','EdgeColor','none',...
%                                 'fontsize',14);
            % Save the giant raw wing beat figure
            switch plot_contents
                case 1
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['4_hz_raw_turns_lam_' mot '_' fig_name]),'-pdf')
                case 2
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['4_hz_L_R_wba_ts_lam_' mot '_' fig_name]),'-pdf')
                case 3
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['4_hz_L_R_LmR_wba_ts_lam_' mot '_' fig_name]),'-pdf')
            end
            
            end    
end
% %-----------Tuning Figure-----------
%             % Mean turning responses for each of the stimuli sets.
%             
%             switch plot_contents
%                 case 1
%                     tuningFigHandle(plot_contents) = figure(  'Name',['Summary Tuning Figure: ' fig_name],'NumberTitle','off',...
%                                             'Color',[1 1 1],'Position',[50 50 950 755],...
%                                             'PaperOrientation','portrait');
%                 case 2
%                     tuningFigHandle(plot_contents) = figure(  'Name',['L vs R Tuning Figure: ' fig_name],'NumberTitle','off',...
%                                     'Color',[1 1 1],'Position',[50 50 755 755],...
%                                     'PaperOrientation','portrait');                    
%                 case 3
%                     tuningFigHandle(plot_contents) = figure(  'Name',['L R LmR Tuning Figure: ' fig_name],'NumberTitle','off',...
%                                     'Color',[1 1 1],'Position',[50 50 755 755],...
%                                     'PaperOrientation','portrait');                     
%             end
%             graph.avg = [];
%             graph.variance = [];
%             
%             for condition_set_number = 1:9
%                 
%                 if condition_set_number == 1; 
%                         curve_name = 'phi_30';
%                         row = 1; col = 1;
%                 elseif condition_set_number == 2
%                         curve_name = 'phi_prog_30';
%                         row = 2; col = 1;
%                 elseif condition_set_number == 3
%                         curve_name = 'phi_reg_30';
%                         row = 3; col = 1;
%                 elseif  condition_set_number == 4
%                         curve_name = 'phi_60';
%                         row = 1; col = 2;
%                 elseif  condition_set_number == 5
%                         curve_name = 'phi_prog_60';
%                         row = 2; col = 2;
%                 elseif  condition_set_number == 6
%                         curve_name = 'phi_reg_60';
%                         row = 3; col = 2;
%                 elseif  condition_set_number == 7
%                         curve_name = 'rev_phi_60';
%                         row = 1; col = 3;
%                 elseif  condition_set_number == 8
%                         curve_name = 'rev_phi_prog_60';
%                         row = 2; col = 3;
%                 elseif  condition_set_number == 9
%                         curve_name = 'rev_phi_reg_60';
%                         row = 3; col = 3;
%                 end
%                 
%                 max_num_stimuli = 10;
%                 
%                 raw_graph_width     = (.92/(3.5))*.75;
%                 raw_graph_height    = (1/3)-0.075;
%                 
%                 x_offset            = .07;
%                 condition_offset    = raw_graph_width+.06;
%                 
%                 y_offset            = .90 - (raw_graph_height-.05);
%                 graph_offset        = raw_graph_height+.045;
%                 
%                 subplot('Position',[x_offset+(condition_offset*(col-1)),...
%                                     y_offset-(graph_offset*(row-1)),...
%                                     raw_graph_width, raw_graph_height]);
%                 switch plot_contents
%                     case 1
%                         for i = 1:numel(geno_set{1})
%                             graph.avg{i}        = tuning_curves.(curve_name){geno_set{1}(i)}.avg;
%                             graph.variance{i}   = tuning_curves.(curve_name){geno_set{1}(i)}.sem;
%                             graph.color{i}      = my_colormap{i};
%                         end
%                         
%                     case 2
%                         % only plot the first genotype's L and R turning
%                         for i = 1
%                             graph.avg{1}        = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg;
%                             graph.variance{1}   = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem;
%                             graph.color{1}      = my_lr_colormap{1};
%                             
%                             graph.avg{2}        = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg;
%                             graph.variance{2}   = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem;
%                             graph.color{2}      = my_lr_colormap{2};                    
%                         end
%                 
%                     case 3
%                         % only plot the first genotype's L and R turning
%                         for i = 1
%                             graph.avg{1}        = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg;
%                             graph.variance{1}   = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem;
%                             graph.color{1}      = my_lr_colormap{1};
% 
%                             graph.avg{2}        = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg;
%                             graph.variance{2}   = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem;
%                             graph.color{2}      = my_lr_colormap{2}; 
%                             
%                             graph.avg{3}        = tuning_curves.(curve_name){geno_set{1}(1)}.avg;
%                             graph.variance{3}   = tuning_curves.(curve_name){geno_set{1}(1)}.sem;
%                             graph.color{3}      = my_colormap{1};                             
%                         end
%                 end
%                 
%                 tfPlot.tuning_curve(graph);
%                 title(curve_name,'interpreter','none')
%                 set(gca,'Ylim',[-6.5 6.5])
%                 
%                 box off;
%                 
%                 set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf),...
%                     'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)+1],...
%                     'xticklabel',{tuning_curves.(curve_name){geno_set{1}(1)}.tf})
%                 
%                 if row == 1  && col == 1
%                     ylabel({'Full Field','Mean \Delta WBA (V)'})
%                 elseif row == 2 && col == 1
%                     ylabel({'Progressive Mot.','Mean \Delta WBA (V)'})
%                 elseif row == 3  && col == 1
%                     xlabel('Temporal Frequency (Hz)')
%                     ylabel({'Regressive Mot.','Mean \Delta WBA (V)'})
%                 elseif row == 3
%                     xlabel('Temporal Frequency (Hz)')
%                 end
%                 
%                 % Add a legend based on plot_contents
%                 if row == 1 && col == 3
%                     switch plot_contents
%                         case 1
%                             legend_cell = [];
%                             name_ind = 0;
%                             for name_iter = 1:numel(legend_name)
%                                 name_ind = name_ind + 1;
%                                 legend_cell{name_ind} = legend_name{name_iter};
%                                 name_ind = name_ind + 1;
%                                 legend_cell{name_ind} = [' N = ' num2str(tuning_curves.(curve_name){geno_set{1}(name_iter)}.num)];
%                             end
%                             l_hand = legend(legend_cell);
%                             set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
%                         case 2
%                             l_hand = legend(['Left_' legend_name{1}],'-',['Right_' legend_name{1}],'-');
%                             set(l_hand,'Location','Best','interpreter','none','EdgeColor',[1 1 1])
%                         case 3
%                             l_hand = legend(['Left_' legend_name{1}],'-',['Right_' legend_name{1}],'-',['L-R_ ' legend_name{1}]);
%                             set(l_hand,'Location','Best','interpreter','none','EdgeColor',[1 1 1])
%                     end
%                 end
%                 
%             end
%             
%             if plot_contents ~= 1
%             annotation('textbox','position',[.3  .9 .9 .1],'string',...
%                         [legend_name{1} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num), '  &   ',...
%                         legend_name{2} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num),] ,...
%                         'interpreter','none','EdgeColor','none',...
%                         'fontsize',12);            
%             end
%             
%             % Save the tuning curve figure
%             switch plot_contents
%                 case 1
%                     export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_tune_curves_' fig_name]),'-pdf')
%                 case 2
%                     export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_LvsR_tune_curves_' fig_name]),'-pdf')
%                 case 3
%                     export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_L_R_LmR_tune_curves_' fig_name]),'-pdf')
%             end
        end
    end
end