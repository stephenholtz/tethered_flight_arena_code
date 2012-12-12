% Full scripts for making high resolution tuning curve figures, very easy
% full_high_res_analysis_script
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Volumes/lacie-temp-external//high_res_tuning_curves_v01/';

exp_dir = data_location;

geno_names{1} = 'gmr_29g11dbd_gal80ts_kir21';
geno_names{2} = 'gmr_20c11ad_48d11dbd_gal80ts_kir21';
geno_names{3} = 'gmr_25b02ad_48d11dbd_gal80ts_kir21';
geno_names{4} = 'gmr_31c06ad_34g07dbd_gal80ts_kir21';
geno_names{5} = 'gmr_35a03ad_29g11dbd_gal80ts_kir21';


%% Process initial raw data and save summary.mat files
if 0

    cd(exp_dir); %#ok<*UNRCH>
    genotypes = dir(exp_dir);

    for i = 1:numel(genotypes);
        if ~sum(strcmpi(genotypes(i).name,{'.','..','DS_STORE','thumbs'}))
            if ~sum(strcmpi([genotypes(i).name '_summary'],dir(fullfile(exp_dir,genotypes(i).name))));
                try
                    geno = tfAnalysis.import(fullfile(exp_dir,genotypes(i).name),'all');
                    eval([genotypes(i).name '_summary = geno;'])
                    save(fullfile(exp_dir,genotypes(i).name,[genotypes(i).name '_summary']),[genotypes(i).name '_summary']);
                catch proc_err
                    disp(proc_err)
                    genotypes(i).name
                end
            else
                disp([genotypes(i).name ' already processed'])
            end
        end
    end

    clear genotypes i

end

%% Load in summary files

if 0

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

if 0

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

            % L - R data            
            [avg, variance]                 = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all');

            tuning_curves.(curve_name){i}.avg               = cell2mat(avg);
            tuning_curves.(curve_name){i}.sem               = cell2mat(variance);
            tuning_curves.(curve_name){i}.avg_ts            = avg_ts;
            tuning_curves.(curve_name){i}.sem_ts            = variance_ts;
            
            tuning_curves.(curve_name){i}.tf                = geno_data{i}.grouped_conditions{condition_set_number}.tf;
            tuning_curves.(curve_name){i}.speed             = geno_data{i}.grouped_conditions{condition_set_number}.speed;
            tuning_curves.(curve_name){i}.condition_numbers = condition_numbers;
            tuning_curves.(curve_name){i}.name              = geno_data{i}.experiment{1}.line_name;
            tuning_curves.(curve_name){i}.num               = numel(geno_data{i}.experiment);
            
            
            % L and R Data            
            [l_wba_avg, l_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','mean','yes','all');
            [l_wba_avg_ts, l_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'left_amp','none','yes','all');
            
            [r_wba_avg, r_wba_sem]          = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','mean','yes','all');            
            [r_wba_avg_ts, r_wba_sem_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'right_amp','none','yes','all');
            
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
    my_colormap      = {[.5 .5 0],[.5 0 0],[.5 0 .5],[0 .5 .5],[.9 .25 .25]};
    my_lr_colormap  = {[1 .5 0],[.5 1 0],[.5 0 1],[0 .5 1]};
    
    
    % Iterate over graph_geno_sets (different combinations of genotypes)
    % tuning_curve takes 'graph' structure with .avg, .variance, .color
    % timeseries   " "
    
    % Easily make a few quick comparisons
        FIG_SET = 1;
        % FIG_SET = 2;
    
    switch FIG_SET
        case 1
            graph_geno_sets =  {[1,1],...
                                [2,1],...
                                [3,1],...
                                [4,1],...
                                [5,1]};
        case 2
            graph_geno_sets = {[1, 1]};
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
                    set(gca,'Ylim',[-4.15 4.15])

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
                                try 
                                    l_hand = legend('0',legend_name{1},'sem',legend_name{2},'sem');
                                    set(l_hand,'Location','EastOutside','interpreter','none')
                                catch %#ok<*CTCH>
                                    l_hand = legend('',legend_name{1},'sem');
                                    set(l_hand,'Location','EastOutside','interpreter','none')
                                end
                                
                            case 2
                                l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem');
                                set(l_hand,'Location','EastOutside','interpreter','none')
                            case 3
                                l_hand = legend('0',['Left_' legend_name{1}],'sem',['Right_' legend_name{1}],'sem',['L-R_ ' legend_name{1}],'sem');
                                set(l_hand,'Location','EastOutside','interpreter','none')                                
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
            
            annotation('textbox','position',[.3  .99 .5 .01],'string','Hz:',...
                            'interpreter','none','EdgeColor',[1 1 1],...
                            'fontsize',12);
            
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
                                            'Color',[1 1 1],'Position',[50 50 755 755],...
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

                raw_graph_width     = .92/(3.5);
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

                set(gca,'Ylim',[-4.5 4.5])
                
                box off;
                
                set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf),...
                    'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)+1],...
                    'xticklabel',{tuning_curves.(curve_name){geno_set{1}(1)}.tf})

                if row == 1  && col == 1
                    ylabel({'Full Field','Mean LmR (V)'})
                elseif row == 2 && col == 1
                    ylabel({'Progressive Mot.','Mean LmR (V)'})
                elseif row == 3  && col == 1
                    xlabel('Temporal Frequency')
                    ylabel({'Regressive Mot.','Mean LmR (V)'})
                elseif row == 3
                    xlabel('Temporal Frequency (Hz)')
                end
                
                annotation('textbox','position',[.3  .99 .5 .01],'string',...
                            [tuning_curves.(curve_name){geno_set{1}(1)}.name ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num),...
                            tuning_curves.(curve_name){geno_set{1}(2)}.name ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(2)}.num),] ,...
                            'interpreter','none','EdgeColor',[1 1 1],...
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
