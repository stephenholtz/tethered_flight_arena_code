% Full scripts for making high resolution tuning curve figures, very easy
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/Desktop/high_res_tuning_curves_v01/';

exp_dir = data_location;

geno_names{1} = 'gmr_29g11dbd_gal80ts_kir21';


%% Process initial raw data and save summary.mat files
if 0

    cd(exp_dir);
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

            condition_numbers  = geno_data{i}.grouped_conditions{condition_set_number}.list;
            
            [avg, variance]    = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');
            
            [avg_ts, variance_ts]    = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all');
            
            tuning_curves.(curve_name){i}.avg               = cell2mat(avg);
            tuning_curves.(curve_name){i}.sem               = cell2mat(variance);
            tuning_curves.(curve_name){i}.avg_ts            = avg_ts;
            tuning_curves.(curve_name){i}.sem_ts            = variance_ts;
            tuning_curves.(curve_name){i}.tf                = geno_data{i}.grouped_conditions{condition_set_number}.tf;
            tuning_curves.(curve_name){i}.speed             = geno_data{i}.grouped_conditions{condition_set_number}.speed;
            tuning_curves.(curve_name){i}.condition_numbers = condition_numbers;
            tuning_curves.(curve_name){i}.name              = geno_data{i}.experiment{1}.line_name;
            tuning_curves.(curve_name){i}.num               = numel(geno_data{i}.experiment);
            
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
    mycolormap = {[.5 .5 0],[.5 0 0],[.5 0 .5],[0 .5 .5],[.9 .25 .25]};
    
    
    % Iterate over graph_geno_sets (different combinations of genotypes)
    % tuning_curve takes 'graph' structure with .avg, .variance, .color
    % timeseries   " "
    
    % Easily make a few quick comparisons
        FIG_SET = 1;
        % FIG_SET = 2;
    
    switch FIG_SET
        case 1
            graph_geno_sets = {[1, 1]};
        case 2
            graph_geno_sets = {[1, 2]};
    end
    
    for geno_set = graph_geno_sets
        
        % Make a figure name
        fig_name = tuning_curves.phi_30{geno_set{1}(1)}.name(5:end);
        legend_name{1} = fig_name;
        
        if numel(geno_set{1}) > 1
            for i = 2:numel(geno_set)
                fig_name = [fig_name '_vs_' tuning_curves.phi_30{geno_set{1}(i)}.name(5:end)];
                legend_name{i} = tuning_curves.phi_30{geno_set{1}(i)}.name(5:end);
            end
        end
                
        %---Giant Raw Figure---
        % Averaged timeseries for each of the stimuli.

        rawFigHandle = figure(  'Name',['Summary Raw Figure: ' fig_name],'NumberTitle','off',...
                                'Color',[1 1 1],'Position',[50 50 755 755],...
                                'PaperOrientation','portrait');
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
                
                graph.avg{1}       = tuning_curves.(curve_name){geno_set{1}(1)}.avg_ts{stim_index};
                graph.variance{1}  = tuning_curves.(curve_name){geno_set{1}(1)}.sem_ts{stim_index};
                graph.color{1}     = mycolormap{1};
                
                tfPlot.timeseries(graph);
                title(tuning_curves.(curve_name){geno_set{1}(1)}.tf(stim_index))
                box off;
                
                if stim_index == 1 && condition_set_number == 9
                    axis on;
                    set(gca,'XTickLabel',{'.5','1','1.5','2'})
                    xlabel('Time (s)')
                elseif stim_index == 1
                    axis on;
                    set(gca,'XTickLabel',{''})
                elseif condition_set_number == 6 && stim_index == 5;
                    l_hand = legend('',legend_name{1},'');
                    set(l_hand,'Location','EastOutside')
                    axis off;
                elseif condition_set_number == 7 && stim_index == 5;
                    try 
                        l_hand = legend('',legend_name{2},'');
                        set(l_hand,'Location','EastOutside')
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
        
        % Save the figure        
        export_fig(rawFigHandle,fullfile(data_location,filesep,['hires_raw_turns_' fig_name]),'-pdf')

        %---Tuning Figure---
        % Mean turning responses for each of the stimuli sets.
        tuningFigHandle = figure(  'Name',['Summary Raw Figure: ' fig_name],'NumberTitle','off',...
                                'Color',[1 1 1],'Position',[50 50 755 755],...
                                'PaperOrientation','portrait');
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

            graph.avg           = tuning_curves.(curve_name){geno_set{1}(1)}.avg;
            graph.variance      = tuning_curves.(curve_name){geno_set{1}(1)}.sem;
            graph.color{1}      = mycolormap{1};
            
            tfPlot.tuning_curve(graph);
            title(curve_name,'interpreter','none')
            
            set(gca,'Ylim',[-3 3])
            
            box off;

            set(gca,'xtick',[1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)],...
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
            
            annotation('textbox','position',[.3  .99 .2 .01],'string',...
                        [tuning_curves.(curve_name){geno_set{1}(1)}.name ', N = ' num2str(tuning_curves.(curve_name){geno_set{1}(1)}.num)] ,...
                        'interpreter','none','EdgeColor',[1 1 1],...
                        'fontsize',14);
            
        end
        
        % Save the figure
        export_fig(tuningFigHandle,fullfile(data_location,filesep,['hires_tune_curves_' fig_name]),'-pdf')
        
    end
        
end
