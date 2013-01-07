% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/unilateral_flicker_contribution_phi_and_rev_phi_v01/';

exp_dir = data_location;

geno_names{1} = 'gmr_48a08_gal80ts_kir21';

%% Process initial raw data and save summary.mat files
if 1

    cd(exp_dir); %#ok<*UNRCH>
    genotypes = dir(exp_dir);
    
    for i = 1:numel(genotypes);
        if genotypes(i).isdir && ~sum(strcmpi(genotypes(i).name,{'.','..','.DS_STORE','DS_STORE','.thumbs'}))
            %if ~sum(strcmpi([genotypes(i).name '_summary'],dir(fullfile(exp_dir,genotypes(i).name))));
                try
                    geno = tfAnalysis.import(fullfile(exp_dir,genotypes(i).name),'all');
                    eval([genotypes(i).name '_summary = geno;'])
                    save(fullfile(exp_dir,genotypes(i).name,[genotypes(i).name '_summary']),[genotypes(i).name '_summary']);
                catch proc_err
                    disp(proc_err)
                    genotypes(i).name
                end
            %else
            %    disp([genotypes(i).name ' already processed'])
            %end
        end
    end
    
    clear genotypes i
    
end

%% Load in summary files

if 1

    for g = 1:numel(geno_names)
        file_name = [];
        stable_dir_name = dir(fullfile(data_location,[geno_names{g},'*']));
        location = fullfile(data_location,stable_dir_name.name);
        file_name = dir(fullfile(location,'*summary.mat'));
        
        if exist(fullfile(location,file_name.name),'file')
            load(fullfile(location,file_name.name));
            fprintf(['Loaded: ' num2str(g) ' of ' num2str(numel(geno_names)) '\n']);
        else
            disp('no processed summary data!')
        end
        
        geno_data{g} = tfAnalysis.ExpSet(eval(file_name.name(1:end-4))); %#ok<*AGROW>

    end
    
    clear g stable_dir_name location file_name
    
end

%% Use summary files to save specific subsets of data in tuning_curves.mat
%%%%%%%%%%%%%%%%%%%%%%%% EDIT HERE
if 0
    % Calculate normalization value per genotype
    for i = 1:numel(geno_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp;
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:9
            % All of the individual tuning curves to be saved:
            %
            % Full Field Rotation Lambda 30 - cond#1
            % Full Field Rotation Lambda 60 - cond#4
            % Reverse Phi Full Field Rotation Lambda 60 - cond#7
            %
            % Progressive Lambda 30 - cond#2
            % Progressive Lambda 60 - cond#5
            % Progressive Full Field Rotation Lambda 60 - cond#8
            %
            % Regressive Lambda 30 - cond#3
            % Regressive Lambda 60 - cond#6
            % Regressive Reverse Phi Rotation Lambda 60 - cond#9
            
            if      condition_set_number == 1
                        curve_name = 'phi_30';
            elseif  condition_set_number == 2
                        curve_name = 'phi_prog_30';
            elseif  condition_set_number == 3
                        curve_name = 'phi_reg_30';
            elseif  condition_set_number == 4
                        curve_name = 'phi_60';
            elseif  condition_set_number == 5
                        curve_name = 'phi_prog_60';
            elseif  condition_set_number == 6
                        curve_name = 'phi_reg_60';
            elseif  condition_set_number == 7
                        curve_name = 'rev_phi_60';
            elseif  condition_set_number == 8
                        curve_name = 'rev_phi_prog_60';
            elseif  condition_set_number == 9
                        curve_name = 'rev_phi_reg_60';          
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
            
            [l_wba_avg, l_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','mean','yes','all',1);
            [l_wba_avg_ts, l_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','none','yes','all',1);
            
            [r_wba_avg, r_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','mean','yes','all',1);            
            [r_wba_avg_ts, r_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','none','yes','all',1);
            
            tuning_curves.(curve_name){i}.l_wba_avg               = cell2mat(l_wba_avg);
            tuning_curves.(curve_name){i}.l_wba_sem               = cell2mat(l_wba_sem);
            tuning_curves.(curve_name){i}.l_wba_avg_ts            = l_wba_avg_ts;
            tuning_curves.(curve_name){i}.l_wba_sem_ts            = l_wba_sem_ts;
            
            tuning_curves.(curve_name){i}.r_wba_avg               = cell2mat(r_wba_avg);
            tuning_curves.(curve_name){i}.r_wba_sem               = cell2mat(r_wba_sem);
            tuning_curves.(curve_name){i}.r_wba_avg_ts            = r_wba_avg_ts;
            tuning_curves.(curve_name){i}.r_wba_sem_ts            = r_wba_sem_ts;
  
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
    
    % Iterate over graph_geno_sets (different combinations of genotypes)
    % tuning_curve takes 'graph' structure with .avg, .variance, .color
    % timeseries   " "
    
    % Easily make a few quick comparisons
        FIG_SET = 1;
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
    end
    
    % Iterate over the plotted graph contents
    %PLOT_CONTENTS = 1;
    PLOT_CONTENTS = 2;
    
    switch PLOT_CONTENTS
        case 1
            % Just the lmr plots
            plot_content_fields = 1;
        case 2
            % The lmr, l r, and l r lmr plots
            plot_content_fields = [1,2,3];
    end
    
    for geno_set = graph_geno_sets
        
        % Make a figure name
        fig_name = tuning_curves.phi_30{geno_set{1}(1)}.name(5:end);
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
                case {'gmr_29g11dbd','29g11dbd'}
                    cell_type = '(ctrl)';
                otherwise
                    cell_type = '(?)';
            end
            
            legend_name{name_iter} = [legend_name{name_iter} ' ' cell_type];
        end
        
        
        for plot_contents = plot_content_fields
            
%-----------Giant Raw Figure-----------
            % Averaged timeseries for each of the stimuli.
            switch plot_contents
                case 1
                    rawFigHandle(plot_contents) = figure(  'Name',['Summary Raw TS Figure: ' fig_name],'NumberTitle','off',...
                                        'Color',[1 1 1],'Position',[50 50 755 755],...
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
            
            for condition_set_number = 1:9

                if condition_set_number == 1; 
                        curve_name = 'phi_30';
                elseif condition_set_number == 2
                        curve_name = 'phi_prog_30';
                elseif condition_set_number == 3
                        curve_name = 'phi_reg_30';
                elseif  condition_set_number == 4
                        curve_name = 'phi_60';
                elseif  condition_set_number == 5
                        curve_name = 'phi_prog_60';
                elseif  condition_set_number == 6
                        curve_name = 'phi_reg_60';
                elseif  condition_set_number == 7
                        curve_name = 'rev_phi_60';
                elseif  condition_set_number == 8
                        curve_name = 'rev_phi_prog_60';
                elseif  condition_set_number == 9
                        curve_name = 'rev_phi_reg_60';          
                end
                
                max_num_stimuli = 10;
                
                raw_graph_width     = .92/(max_num_stimuli+.5);
                raw_graph_height    = 1/9 - .035;

                x_offset            = .07;
                condition_offset    = raw_graph_width+.005;

                y_offset            = .90 - (raw_graph_height-.05);
                graph_offset        = raw_graph_height+.026;


                for stim_index = 1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.speed);
                    
                    subplot('Position',[x_offset+(condition_offset*(stim_index-1)),...
                                        y_offset-(graph_offset*(condition_set_number-1)),...
                                        raw_graph_width, raw_graph_height]);
                    
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
                    title(tuning_curves.(curve_name){geno_set{1}(1)}.tf(stim_index))
                    box off;
                    set(gca,'Ylim',[-7.15 7.15])
                    
                    if stim_index == 1 && condition_set_number == 9
                        axis on;
                        set(gca,'XTickLabel',{'.5','1','1.5','2'})
                        xlabel('Time (s)')
                    elseif stim_index == 1
                        axis on;
                        set(gca,'XTickLabel',{''})
                    % Change the legends for different plot_contents
                    elseif condition_set_number == 6 && stim_index == 5;
                        
                        switch plot_contents
                            case 1
                                legend_cell{1} = '0';
                                name_ind = 1;
                                for name_iter = 1:numel(legend_name)
                                    name_ind = name_ind + 1;
                                    legend_cell{name_ind} = legend_name{name_iter};
                                    name_ind = name_ind + 1;
                                    legend_cell{name_ind} = [' SEM, N = ' num2str(tuning_curves.(curve_name){geno_set{1}(name_iter)}.num)];
                                end
                                l_hand = legend(legend_cell);
                                set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
                            case 2
                                l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem');
                                set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
                            case 3
                                l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem',['L-R_ ' legend_name{1}],'sem');
                                set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
                        end
                        
                        axis off;
                    else
                        axis off;
                    end
                    
                    if mod(condition_set_number,2)
                        ylabel({'',curve_name},'interpreter','none')
                    else
                        ylabel({curve_name,''},'interpreter','none')
                    end
                end
            end
            
            annotation('textbox','position',[.065  .9315 .05 .05],'string','Hz:',...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',12);
            
            if plot_contents ~= 1    
                annotation('textbox','position',[.55  .1 .9 .1],'string',...
                            {[legend_name{1} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num)],...
                             [legend_name{2} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num)]},...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',12);
            end

            % Save the giant raw wing beat figure
            switch plot_contents
                case 1
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['hires_raw_turns_' fig_name]),'-pdf')
                case 2
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['hires_L_R_wba_ts_' fig_name]),'-pdf')
                case 3
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['hires_L_R_LmR_wba_ts_' fig_name]),'-pdf')
            end
            
%-----------Tuning Figure-----------
            % Mean turning responses for each of the stimuli sets.
            
            switch plot_contents
                case 1
                    tuningFigHandle(plot_contents) = figure(  'Name',['Summary Tuning Figure: ' fig_name],'NumberTitle','off',...
                                            'Color',[1 1 1],'Position',[50 50 950 755],...
                                            'PaperOrientation','portrait');
                case 2
                    tuningFigHandle(plot_contents) = figure(  'Name',['L vs R Tuning Figure: ' fig_name],'NumberTitle','off',...
                                    'Color',[1 1 1],'Position',[50 50 755 755],...
                                    'PaperOrientation','portrait');                    
                case 3
                    tuningFigHandle(plot_contents) = figure(  'Name',['L R LmR Tuning Figure: ' fig_name],'NumberTitle','off',...
                                    'Color',[1 1 1],'Position',[50 50 755 755],...
                                    'PaperOrientation','portrait');                     
            end
            graph.avg = [];
            graph.variance = [];
            
            for condition_set_number = 1:9
                
                if condition_set_number == 1; 
                        curve_name = 'phi_30';
                        row = 1; col = 1;
                elseif condition_set_number == 2
                        curve_name = 'phi_prog_30';
                        row = 2; col = 1;
                elseif condition_set_number == 3
                        curve_name = 'phi_reg_30';
                        row = 3; col = 1;
                elseif  condition_set_number == 4
                        curve_name = 'phi_60';
                        row = 1; col = 2;
                elseif  condition_set_number == 5
                        curve_name = 'phi_prog_60';
                        row = 2; col = 2;
                elseif  condition_set_number == 6
                        curve_name = 'phi_reg_60';
                        row = 3; col = 2;
                elseif  condition_set_number == 7
                        curve_name = 'rev_phi_60';
                        row = 1; col = 3;
                elseif  condition_set_number == 8
                        curve_name = 'rev_phi_prog_60';
                        row = 2; col = 3;
                elseif  condition_set_number == 9
                        curve_name = 'rev_phi_reg_60';
                        row = 3; col = 3;
                end
                
                max_num_stimuli = 10;
                
                raw_graph_width     = (.92/(3.5))*.75;
                raw_graph_height    = (1/3)-0.075;
                
                x_offset            = .07;
                condition_offset    = raw_graph_width+.06;
                
                y_offset            = .90 - (raw_graph_height-.05);
                graph_offset        = raw_graph_height+.045;
                
                subplot('Position',[x_offset+(condition_offset*(col-1)),...
                                    y_offset-(graph_offset*(row-1)),...
                                    raw_graph_width, raw_graph_height]);
                switch plot_contents
                    case 1
                        for i = 1:numel(geno_set{1})
                            graph.avg{i}        = tuning_curves.(curve_name){geno_set{1}(i)}.avg;
                            graph.variance{i}   = tuning_curves.(curve_name){geno_set{1}(i)}.sem;
                            graph.color{i}      = my_colormap{i};
                        end
                        
                    case 2
                        % only plot the first genotype's L and R turning
                        for i = 1
                            graph.avg{1}        = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg;
                            graph.variance{1}   = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem;
                            graph.color{1}      = my_lr_colormap{1};
                            
                            graph.avg{2}        = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg;
                            graph.variance{2}   = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem;
                            graph.color{2}      = my_lr_colormap{2};                    
                        end
                
                    case 3
                        % only plot the first genotype's L and R turning
                        for i = 1
                            graph.avg{1}        = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_avg;
                            graph.variance{1}   = tuning_curves.(curve_name){geno_set{1}(1)}.l_wba_sem;
                            graph.color{1}      = my_lr_colormap{1};

                            graph.avg{2}        = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_avg;
                            graph.variance{2}   = tuning_curves.(curve_name){geno_set{1}(1)}.r_wba_sem;
                            graph.color{2}      = my_lr_colormap{2}; 
                            
                            graph.avg{3}        = tuning_curves.(curve_name){geno_set{1}(1)}.avg;
                            graph.variance{3}   = tuning_curves.(curve_name){geno_set{1}(1)}.sem;
                            graph.color{3}      = my_colormap{1};                             
                        end
                end
                
                tfPlot.tuning_curve(graph);
                title(curve_name,'interpreter','none')
                set(gca,'Ylim',[-6.5 6.5])
                
                box off;
                
                set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf),...
                    'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)+1],...
                    'xticklabel',{tuning_curves.(curve_name){geno_set{1}(1)}.tf})
                
                if row == 1  && col == 1
                    ylabel({'Full Field','Mean \Delta WBA (V)'})
                elseif row == 2 && col == 1
                    ylabel({'Progressive Mot.','Mean \Delta WBA (V)'})
                elseif row == 3  && col == 1
                    xlabel('Temporal Frequency (Hz)')
                    ylabel({'Regressive Mot.','Mean \Delta WBA (V)'})
                elseif row == 3
                    xlabel('Temporal Frequency (Hz)')
                end
                
                % Add a legend based on plot_contents
                if row == 1 && col == 3
                    switch plot_contents
                        case 1
                            legend_cell = [];
                            name_ind = 0;
                            for name_iter = 1:numel(legend_name)
                                name_ind = name_ind + 1;
                                legend_cell{name_ind} = legend_name{name_iter};
                                name_ind = name_ind + 1;
                                legend_cell{name_ind} = [' N = ' num2str(tuning_curves.(curve_name){geno_set{1}(name_iter)}.num)];
                            end
                            l_hand = legend(legend_cell);
                            set(l_hand,'Location','EastOutside','interpreter','none','EdgeColor',[1 1 1])
                        case 2
                            l_hand = legend(['Left_' legend_name{1}],'-',['Right_' legend_name{1}],'-');
                            set(l_hand,'Location','Best','interpreter','none','EdgeColor',[1 1 1])
                        case 3
                            l_hand = legend(['Left_' legend_name{1}],'-',['Right_' legend_name{1}],'-',['L-R_ ' legend_name{1}]);
                            set(l_hand,'Location','Best','interpreter','none','EdgeColor',[1 1 1])
                    end
                end
                
            end
            
            if plot_contents ~= 1
            annotation('textbox','position',[.3  .9 .9 .1],'string',...
                        [legend_name{1} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num), '  &   ',...
                        legend_name{2} ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num),] ,...
                        'interpreter','none','EdgeColor','none',...
                        'fontsize',12);            
            end
            
            % Save the tuning curve figure
            switch plot_contents
                case 1
                    export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_tune_curves_' fig_name]),'-pdf')
                case 2
                    export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_LvsR_tune_curves_' fig_name]),'-pdf')
                case 3
                    export_fig(tuningFigHandle(plot_contents),fullfile(data_location,filesep,['hires_L_R_LmR_tune_curves_' fig_name]),'-pdf')
            end
        end
    end
end