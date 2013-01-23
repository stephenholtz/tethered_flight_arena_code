% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/short_visual_phenotype_test_v01/';

exp_dir = data_location;

geno_names{1} = 'repo_GFP';
geno_names{2} = 'repo_E50K';
geno_names{3} = 'repo_D474N';
geno_names{4} = 'GMR_D474N';

%% Process initial raw data and save summary.mat files

if 0
    for i = 1:numel(geno_names) %#ok<*UNRCH>
        geno = tfAnalysis.import(fullfile(data_location,geno_names{i}),'all');
        summary_filename = [geno_names{i} '_summary'];
        eval([summary_filename ' = geno;']);
        save(fullfile(exp_dir,geno_names{i},summary_filename),summary_filename);
    end
end

%% Load in summary files

if 0
    addpath(genpath('/Users/stephenholtz/matlab-utils'))
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
        
        for condition_set_number = 1:3
            % All of the individual tuning curves to be saved:
            %
            if      condition_set_number == 1
                        curve_name = 'optomotor_l_30';
            elseif  condition_set_number == 2
                        curve_name = 'optomotor_l_30_contrasts';
            elseif  condition_set_number == 3
                        curve_name = 'oscillating_stripe_a_45';
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
            
            
            % Xcorr
            [avg{1}, variance{1}]                 = geno_data{i}.get_corr_trial_data_set(condition_numbers(1),'lmr','x_pos','all');
            [avg{2}, variance{2}]                 = geno_data{i}.get_corr_trial_data_set(condition_numbers(2),'lmr','x_pos','all');
            [avg{3}, variance{3}]                 = geno_data{i}.get_corr_trial_data_set(condition_numbers(3),'lmr','x_pos','all');
            %[avg_ts, variance_ts]           = geno_data{i}.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');
            
            tuning_curves.(curve_name){i}.corr_avg               = cell2mat(([avg{:}]));
            tuning_curves.(curve_name){i}.corr_sem               = cell2mat(([variance{:}]));
            %tuning_curves.(curve_name){i}.corr_avg_ts            = avg_ts;
            %tuning_curves.(curve_name){i}.corr_sem_ts            = variance_ts;
            
            % Propogate names
            tuning_curves.(curve_name){i}.tf                = geno_data{i}.grouped_conditions{condition_set_number}.tf;
            tuning_curves.(curve_name){i}.speed             = geno_data{i}.grouped_conditions{condition_set_number}.speed;
            try tuning_curves.(curve_name){i}.contrast      = geno_data{i}.grouped_conditions{condition_set_number}.contrast; end %#ok<TRYNC>
            try tuning_curves.(curve_name){i}.mc            = geno_data{i}.grouped_conditions{condition_set_number}.mc; end %#ok<TRYNC>            
            tuning_curves.(curve_name){i}.condition_numbers = condition_numbers;
            tuning_curves.(curve_name){i}.name              = geno_data{i}.experiment{1}.line_name;
            tuning_curves.(curve_name){i}.num               = numel(geno_data{i}.experiment);
            
        end
        condition_set_number = 4;
        curve_name = 'vel_nulling';        

        % gather three points for each of the test contrasts used at a given
        % temporal frequency
        contrast_set = [.09 .27 .45];

        stim_set{1} = [1 2 3];
        stim_set{2} = [4 5 6];
        stim_set{3} = [7 8 9];
        stim_set{4} = [10 11 12];
        stim_set{5} = [13 14 15];
        
        for g = 1:numel(stim_set)

            % vel nulling is the 12th set
            condition_numbers = geno_data{i}.grouped_conditions{condition_set_number}.list(stim_set{g});

            [null_contrast_vals{g}, null_contrast_vals_sem{g}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i)); %#ok<*SAGROW>
            
        end
        
        for g = 1:numel(null_contrast_vals)

            null_contrast_line{g} = cell2mat(null_contrast_vals{g});

            temp_contrast_resp = (cell2mat(null_contrast_vals{g}));

            % Fit a first degree polynomial coef
            fit_vals(g,:) = polyfit(contrast_set',temp_contrast_resp',1);

            % Find the zero crossing point/null contrast
            intercept_val{g} = -1*(fit_vals(g,2)/fit_vals(g,1));
            null_contrast{g} = 1/intercept_val{g};

            % Plot the raw data points  
            raw_plot{g} = [contrast_set;temp_contrast_resp];

            % Plot the fit line (for a few more points)
            fit_plot{g} = [[.01 contrast_set .6];polyval(fit_vals(g,:),[.01 contrast_set .6])];

        end
        
        % Make a variable with all the nulling data
        tuning_curves.(curve_name){i}.intercept_val     = intercept_val;
        tuning_curves.(curve_name){i}.null_contrast     = null_contrast;
        tuning_curves.(curve_name){i}.raw_plot          = raw_plot;
        tuning_curves.(curve_name){i}.fit_plot          = fit_plot;
        tuning_curves.(curve_name){i}.fit_vals          = fit_vals;
        tuning_curves.(curve_name){i}.contrast_set      = contrast_set;
        tuning_curves.(curve_name){i}.name              = geno_names{i};
        tuning_curves.(curve_name){i}.N                 = numel(geno_data{i}.experiment);        
        
    end
    
    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

%% Make a complete summary figure
if 1
    
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map = {[205 201 201]/255};

    tuningFigHandle(1) = figure(  'Name','Summary Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 755 755],...
                            'PaperOrientation','portrait');
	
    
	% Vel null portion
    vel_null_pos        = [.3 .75 .65 .19];
    opto_tune_pos       = [.55 .4 .36 .26];    
    contrast_tune_pos   = [.1 .4 .36 .26];
    track_tune_pos      = [.76 .14 .15 .15];
    
    osc_pos{1} = [.09 .14 .15 .15];
    osc_pos{2} = [.32 .14 .15 .15];
    osc_pos{3} = [.55 .14 .15 .15];
    
    subplot('Position',vel_null_pos)
    
    for i = 1:numel(geno_names)
    
        null_contrast_vals = cell2mat(tuning_curves.vel_nulling{i}.null_contrast);

        %--Plot a line for every value in the subplot
        temp_freq = [.2 1.3 5.3 10.7 16];

        semilogx(temp_freq,null_contrast_vals,'Color',my_colormap{i},'LineWidth',2);
        hold on;
        
    end
    
    set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1);
    axis([0 20 0 6]);
    xlabel('Test Stim. Temp. Freq. (Hz)')
    ylabel('1 / null contrast')
    title('Velocity Nulling')
    
    l_hand = legend(geno_names);
    set(l_hand,'interpreter','none','location','NorthEastOutside')
    
    % Optomotor speeds portion
    curve_name = 'optomotor_l_30';
 
    subplot('Position',opto_tune_pos)    
    
    for i = 1:numel(geno_names)
        graph.avg{i}        = tuning_curves.(curve_name){i}.avg;
        graph.variance{i}   = tuning_curves.(curve_name){i}.sem;
        graph.color{i}      = my_colormap{i};
    end
    tfPlot.tuning_curve(graph);
    
    set(gca,'xtick',1:numel(tuning_curves.(curve_name){i}.tf),...
        'xlim',[0 numel(tuning_curves.(curve_name){i}.tf)+1],...
        'xticklabel',{'.5', '2', '4', '8'})
    ylabel('Mean L-R WBA')
    xlabel('Temporal Frequency')
    title('Optomotor Response (Stimulus Speed Changes)')
    clear graph
    
    % Optomotor contrast portion
    
    subplot('Position',contrast_tune_pos)
    curve_name = 'optomotor_l_30_contrasts';
    
    for i = 1:numel(geno_names)
        graph.avg{i}        = tuning_curves.(curve_name){i}.avg;
        graph.variance{i}   = tuning_curves.(curve_name){i}.sem;
        graph.color{i}      = my_colormap{i};
    end
    
    tfPlot.tuning_curve(graph);
    
    set(gca,'xtick',1:numel(tuning_curves.(curve_name){i}.contrast),...
        'xlim',[0 numel(tuning_curves.(curve_name){i}.contrast)+1],...
        'xticklabel',{'1', '.71', '.43', '.14'})
    ylabel('Mean L-R WBA')
    xlabel('Contrast')
    title('Optomotor Response (Stimulus Contrast Changes)')
    clear graph
    
    % Oscillating Stripes portion
    
    curve_name = 'optomotor_l_30_contrasts';
    stim_speeds={'4','8','16'};
    for stim = 1:3
        
        subplot('Position',osc_pos{stim})
        
        for i = 1:numel(geno_names)
            graph.avg{i}        = tuning_curves.oscillating_stripe_a_45{i}.avg_ts{stim};
            graph.variance{i}   = tuning_curves.oscillating_stripe_a_45{i}.sem_ts{stim};
            graph.color{i}      = my_colormap{i};
        end
        
        tfPlot.timeseries(graph);
    
        ylabel('Mean L-R WBA')
        xlabel('time')
        title(['Stripe Tracking (Speed:' stim_speeds{stim} ')'])
    
    end
    
    clear graph
    
    % Stripe Tracking Corr
    
    subplot('Position',track_tune_pos)
    curve_name = 'oscillating_stripe_a_45';
    
    for i = 1:numel(geno_names)
        graph.avg{i}        = tuning_curves.(curve_name){i}.corr_avg;
        graph.variance{i}   = tuning_curves.(curve_name){i}.corr_sem;
        graph.color{i}      = my_colormap{i};
    end
    
    tfPlot.tuning_curve(graph);
    
    set(gca,'xtick',1:3,...
        'xlim',[1 3],...
        'xticklabel',{'4', '8', '16'})
    ylabel('Correlation')
    xlabel('~Speed')
    title('Stripe Tracking Ability')
    clear graph
        
    
    annotation('textbox','position',[.05 .72 .2 .15],'string',...
                {'Summary of short', 'stimulus protocol.'},...
                'interpreter','none','EdgeColor','none',...
                'fontsize',16);
    
    export_fig(gcf,fullfile(data_location,filesep,'summary_repo_figure'),'-pdf') 
end


%% Make very simple figure with tuning curves

if 0
    
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[238 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map = {[205 201 201]/255};

    tuningFigHandle(1) = figure(  'Name','Summary Tuning Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 950 755],...
                            'PaperOrientation','portrait');
    geno_set = {[1,2]};
   
    for condition_set_number = 1:2

        if      condition_set_number == 1
                    curve_name = 'optomotor_l_30';
        elseif  condition_set_number == 2
                    curve_name = 'optomotor_l_30_contrasts';
        elseif  condition_set_number == 3
                    curve_name = 'oscillating_stripe_a_45';
        elseif  condition_set_number == 4
                    curve_name = 'vel_nulling';
        end    

        for i = 1:numel(geno_set{1})
            graph.avg{i}        = tuning_curves.(curve_name){geno_set{1}(i)}.avg;
            graph.variance{i}   = tuning_curves.(curve_name){geno_set{1}(i)}.sem;
            graph.color{i}      = my_colormap{i};
        end

        subplot(2,2,condition_set_number)

        tfPlot.tuning_curve(graph);
        title(curve_name,'interpreter','none')
        set(gca,'Ylim',[-4.5 4.5])

        box off;

        if condition_set_number == 1
        set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf),...
            'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)+1],...
            'xticklabel',{'.5', '2', '4', '8'})
            ylabel('Mean L-R WBA')
            xlabel('Temporal Frequency')
        elseif condition_set_number == 2
        set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.contrast),...
            'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.contrast)+1],...
            'xticklabel',{'1', '.71', '.43', '.14'})
            ylabel('Mean L-R WBA')
            xlabel('Contrast')
        end

        l_hand = legend(geno_names{1},'zero',geno_names{2},'Location','best');
        set(l_hand,'interpreter','none')
        
    end
    
    geno_set = {[1,2]};
    graph.avg = [];
    graph.variance = [];
    condition_iter = 0;                
    total_x_plots = 1;
    total_y_plots = 3;

    % silly plot placement info
    raw_graph_width     = .92/(total_x_plots+2);
    raw_graph_height    = 1/(total_y_plots) - .035;

    start_x_pos = .089;
    start_y_pos = .5;

    sub_x_offset    = raw_graph_width+.005;
    y_offset        = raw_graph_height+.04;

    for condition_set_number = 3

        if      condition_set_number == 1
                curve_name = 'optomotor_l_30';
        elseif  condition_set_number == 2
                curve_name = 'optomotor_l_30_contrasts';
        elseif  condition_set_number == 3
                curve_name = 'oscillating_stripe_a_45';
        elseif  condition_set_number == 4
                curve_name = 'vel_nulling';
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
                                .25,...
                                .25];

            subplot('Position',sp_position);

            % standard lmr plots
            for i = 1:numel(geno_set{1})
                graph.avg{i}       = tuning_curves.(curve_name){geno_set{1}(i)}.avg_ts{stim_index};
                graph.variance{i}  = tuning_curves.(curve_name){geno_set{1}(i)}.sem_ts{stim_index};
                graph.color{i}     = my_colormap{i};
            end

            tfPlot.timeseries(graph);
            title(curve_name,'interpreter','none')
            set(gca,'Ylim',[-6.5 6.5])

            box off;

            if condition_set_number == 1
            set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf),...
                'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.tf)+1],...
                'xticklabel',{'.5', '2', '4', '8'})
                ylabel('L-R WBA')
                xlabel('Contrast')
            elseif condition_set_number == 2
            set(gca,'xtick',1:numel(tuning_curves.(curve_name){geno_set{1}(1)}.contrast),...
                'xlim',[0 numel(tuning_curves.(curve_name){geno_set{1}(1)}.contrast)+1],...
                'xticklabel',{'1', '.71', '.43', '.14'})
                ylabel('L-R WBA')
                xlabel('Contrast')
            end

        %l_hand = legend(geno_names{1},'zero',geno_names{2},'Location','best','interpreter','none');

        end
    end
   export_fig(gcf,fullfile(data_location,filesep,'summary_repo_figure'),'-pdf') 
end


%% Make a figure from the data in tuning_curves.mat

if 0
    
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
        FIG_SET = 2;
        
    switch FIG_SET
        case 1
            graph_geno_sets =  {[1,1],...
                                [2,1],...
                                [3,1]};
        case 2
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
        fig_name = tuning_curves.optomotor_l_30{geno_set{1}(1)}.name(5:end);
        legend_name{1} = fig_name;
        
        if numel(geno_set{1}) > 1
            for i = 2:numel(geno_set{1})
                fig_name = [fig_name '_vs_' tuning_curves.optomotor_l_30{geno_set{1}(i)}.name(5:end)];
                legend_name{i} = tuning_curves.optomotor_l_30{geno_set{1}(i)}.name(5:end); %#ok<*SAGROW>
            end
        end
        
        for plot_contents = plot_content_fields
if 1
%-----------Giant Raw Figure-----------
            % Averaged timeseries for each of the stimuli.

            for cond_set_group = 1:2
                cond_set_nums = 1:4;
                
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
                total_x_plots = 3;
                total_y_plots = 4;
                
            % silly plot placement info
            raw_graph_width     = .92/(total_x_plots+2);
            raw_graph_height    = 1/(total_y_plots) - .035;
            
            start_x_pos = .089;
            start_y_pos = .91;
            
            sub_x_offset    = raw_graph_width+.005;
            y_offset        = raw_graph_height+.04;
            
            for condition_set_number = cond_set_nums
            
            if      condition_set_number == 1
                        curve_name = 'optomotor_l_30';
            elseif  condition_set_number == 2
                        curve_name = 'optomotor_l_30_contrasts';
            elseif  condition_set_number == 3
                        curve_name = 'oscillating_stripe_a_45';
            elseif  condition_set_number == 4
                        curve_name = 'vel_nulling';
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
                    else
                        axis off;
                    end
                end


            end

            annotation('textbox','position',[.073  .913 .25 .05],'string','Right:',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.2 .913 .25 .05],'string',' \lambda 15',...
                            'EdgeColor','none',...
                            'fontsize',14);
            annotation('textbox','position',[.077  .863 .05 .05],'string','Hz:',...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',10);
            
            % Save the giant raw wing beat figure
            switch plot_contents
                case 1
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['raw_turning_data_' fig_name]),'-pdf')
                case 2
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['L_R_wba_ts_data_' fig_name]),'-pdf')
                case 3
                    export_fig(rawFigHandle(plot_contents),fullfile(data_location,filesep,['L_R_LmR_wba_ts_data_' fig_name]),'-pdf')
            end
            
            end
end

if 0
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
                        curve_name = 'optomotor_l_30';
            elseif  condition_set_number == 2
                        curve_name = 'optomotor_l_30_contrasts';
            elseif  condition_set_number == 3
                        curve_name = 'oscillating_stripe_a_45';
            elseif  condition_set_number == 4
                        curve_name = 'vel_nulling';
            end
            
            condition_iter = condition_iter + 1;

            if condition_iter > 1
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
                    else
                        axis off;
                    end
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
            annotation('textbox','position',[.077  .863 .05 .05],'string','Hz:',...
                            'interpreter','none','EdgeColor','none',...
                            'fontsize',10);

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
if 0
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
            
            for condition_set_number = 1:3
                
                if      condition_set_number == 1
                            curve_name = 'optomotor_l_30';
                            col = 1;
                elseif  condition_set_number == 2
                            curve_name = 'optomotor_l_30_contrasts';
                            col = 1;
                elseif  condition_set_number == 3
                            curve_name = 'oscillating_stripe_a_45';
                            col = 1;
                elseif  condition_set_number == 4
                            curve_name = 'vel_nulling';
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
end