% This will make a few figures from a few different experiment type sources
% and combine everything where there are overlapping experimental
% conditions. The summary file generated from this should have all of the
% data necessary for making figures.

addpath(genpath('/Users/stephenholtz/matlab-utils'))

% Locations for all of the experiment groupings
data_location       = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_final_set/ON_OFF_set_v06_MIXED';
summary_location    = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_figures';

% Names of all the folders with the different experiments
% [34C] ShiTS
num = 1; geno_folder_names{num} = 'shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';       colormap_ind{num} = 1;    proper_geno_names{num} = 'L1 (48a08AD;66A01DBD)/ShiTS';
num = 2; geno_folder_names{num} = 'shift_gmr_48a08ad_kitamoto_shibire';                colormap_ind{num} = 2;    proper_geno_names{num} = 'Ctrl (48a08AD;+)/ShiTS';
num = 3; geno_folder_names{num} = 'shift_ok371_vp16_ad_ort_c1_3_dbd_kitamoto_shibire'; colormap_ind{num} = 3;    proper_geno_names{num} = 'L1 (ok371vp16AD;ortC1-3DBD)/ShiTS';
num = 4; geno_folder_names{num} = 'shift_L1_c202a_kitamoto_shibire';                   colormap_ind{num} = 4;    proper_geno_names{num} = 'L1 (c202a)/ShiTS';
num = 5; geno_folder_names{num} = 'shift_iso_d1_kitamoto_shibire';                     colormap_ind{num} = 5;    proper_geno_names{num} = 'Ctrl (Iso-D1)/ShiTS';

% [34C] ShiTS DIM
num = 6; geno_folder_names{num} = 'dim_shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';   colormap_ind{num} = 8;    proper_geno_names{num} = '(low contrast) L1 (48a08AD;66A01DBD)/ShiTS';
num = 7; geno_folder_names{num} = 'dim_shift_gmr_48a08ad_kitamoto_shibire';            colormap_ind{num} = 9;    proper_geno_names{num} = '(low contrast) Ctrl (48a08AD;+)/ShiTS';
num = 8; geno_folder_names{num} = 'dim_shift_ok371vp16ad_ortc3dbd_kitamoto_shibire';   colormap_ind{num} = 10;    proper_geno_names{num} = '(low contrast) L1 (ok371vp16AD;ortC1-3DBD)/ShiTS';
num = 9; geno_folder_names{num} = 'dim_shift_L1_c202a_kitamoto_shibire';               colormap_ind{num} = 11;    proper_geno_names{num} = '(low contrast) L1 (c202a)/ShiTS';
num = 10; geno_folder_names{num} = 'dim_shift_iso_d1_kitamoto_shibire';                colormap_ind{num} = 12;    proper_geno_names{num} = '(low contrast) Ctrl (Iso-D1)/ShiTS';

% [25C] Kir2.1
num = 11; geno_folder_names{num} = 'gmr_48a08ad_66a01dbd_gal80ts_kir21';               colormap_ind{num} = 6;    proper_geno_names{num} = 'L1 (48a08AD;66A01DBD)/Kir2.1';
num = 12; geno_folder_names{num} = 'gmr_48a08ad_gal80ts_kir21';                        colormap_ind{num} = 7;    proper_geno_names{num} = 'Ctrl (48a08AD;+)/Kir2.1';

% [25C] Kir2.1 DIM
num = 13; geno_folder_names{num} = 'dim_combined_gmr_48a08ad_66a01dbd_gal80ts_kir21';  colormap_ind{num} = 13;    proper_geno_names{num} = '(low contrast) L1 (48a08AD;66A01DBD)/Kir2.1';
num = 14; geno_folder_names{num} = 'dim_gmr_48a08ad_gal80ts_kir21';                    colormap_ind{num} = 14;    proper_geno_names{num} = '(low contrast) Ctrl (48a08AD;+)/Kir2.1';
num = 15; geno_folder_names{num} = 'dim_retest_gmr_48a08ad_66a01dbd_gal80ts_kir21';    colormap_ind{num} = 13;    proper_geno_names{num} = '(low contrast) L1 (48a08AD;66A01DBD)/Kir2.1';

% debugging folder
%geno_folder_names{1} = 'debug_folder';       proper_geno_names{1} = 'debug...';

% All of the names of the condition subsets that have inds that agree with
% the grouped_conds values.
curve_names = { 'edges_rear_ON_OFF',...     1
                'edges_center_ON_OFF',...   2
                'sweep_ON',...              3* (in short protocol)
                'sweep_OFF',...             4*
                'steady_ON_ON',...          5
                'steady_ON_OFF',...         6
                'steady_OFF_ON',...         7
                'steady_OFF_OFF',...        8
                'lam_30_rotation',...       9*
                'opposed_ON_OFF',...        10*
                'expansion_ON',...          11*
                'expansion_OFF',...         12*
                'sawtooth_ON',...           13*
                'sawtooth_OFF',...          14*
                'stripe_fixation'};%        15*

% Save figures as pdfs
save_figures                    = 1;

% Make certain figures
optomotor_tune_figure           = 1;
sawtooth_expansion_tune_figure  = 1;

optomotor_ts_figure             = 1;
sawtooth_expansion_ts_figure    = 1;

% Make summary data files within each folder (if needed)
if 0
    overwrite_flag = 0;
    tfAnalysis.save_geno_group_summary_files(geno_folder_names,data_location,overwrite_flag);
end

% Load in all of the experiment folder summary files and make a
% summ_data.mat file with all of the processed / organized data
if 0
    
    fprintf('\n\nLoading in *_summary.mat files from %s.',summary_location)

    if ~exist('geno_data','var')
        geno_data = tfAnalysis.load_geno_group_summary_files(geno_folder_names,data_location);
    end
    
    % Ca(low contrast)ulate normalization value per genotype
    for i = numel(geno_folder_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end

    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);

    % These are set up so the indecies work for both regular and 'short'
    % versions of the experiment
    conditions = ON_OFF_set_v06_short; %%%%% TODO
    
    fprintf('\n\nProcessing data from %d genotypes: \n',numel(geno_folder_names))
    
    for i = 1:numel(geno_folder_names)
        fprintf('%s\n',geno_folder_names{i})
        
        % Only use the condition sets that are common to both protocols
        for condition_set_number = [3 4 9 10 11 12 13 14]
            
            % Gets CW or CCW or flipped and averaged
            for sym = 3

                if sym == 1
                    symmetry = '_CW';
                    sym_inds = 1;
                    flip = 'no';
                elseif sym == 2
                    symmetry = '_CCW'; 
                    sym_inds = 2;
                    flip = 'no';
                elseif sym == 3
                    symmetry = '';
                    sym_inds = 1:2;
                    flip = 'yes';
                end
                
                curve_name = curve_names{condition_set_number};

                summ_data.names{condition_set_number} = curve_name;

                %summ_data.(curve_name).raw(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);

                % These condition numbers need to be made on a per
                % experiment basis now...
                for exp_num = 1:numel(geno_data{i}.experiment)
                    condition_numbers{exp_num} = geno_data{i}.grouped_conditions{exp_num}(condition_set_number).conds;
                end
                
                %summ_data.(curve_name).(['raw' symmetry])(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);
                for exp_num = 1:numel(geno_data{i}.experiment)
                    for u = 1:numel(condition_numbers{exp_num})
                        condition_numbers{exp_num}{u} = condition_numbers{exp_num}{u}(sym_inds);
                    end
                end
                
                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean',flip,'all',geno_norm_values(i));
                
                summ_data.(curve_name).(['raw' symmetry])(i).avg_lmr = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_lmr = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'all',geno_norm_values(i));

                summ_data.(curve_name).(['raw' symmetry])(i).avg_lmr_ts = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_lmr_ts = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'exp',geno_norm_values(i));

                summ_data.(curve_name).(['raw' symmetry])(i).avg_per_fly_lmr_ts = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_per_fly_lmr_ts = v;

                [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'none',geno_norm_values(i));

                summ_data.(curve_name).(['raw' symmetry])(i).all_lmr_ts = a;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','all',geno_norm_values(i));

                summ_data.(curve_name).(['raw' symmetry])(i).avg_x_pos_ts = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_x_pos_ts = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','exp',geno_norm_values(i));

                summ_data.(curve_name).(['raw' symmetry])(i).avg_per_fly_x_pos_ts = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_per_fly_x_pos_ts = v;

                [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','none',geno_norm_values(i));

                summ_data.(curve_name).raw(i).all_x_pos_ts = a;

                summ_data.(curve_name).raw(i).N = numel(geno_data{i}.experiment);
                
                clear condition_numbers

            end
        end
    end
    
    fprintf('\n ...Saving summarized data.\n')

    save(fullfile(summary_location,'summ_data'),'summ_data')
    
end

% Make the figures

for plotting_group = 3
    
    if plotting_group == 1
        % ShiTS regular
        geno_inds_to_plot = 1:5;
        isdim = 0;
        graph_name = 'ShiTS';
    elseif plotting_group == 2
        % ShiTS dim
        geno_inds_to_plot = [6:10];
        isdim = 1;
        graph_name = 'ShiTS Dim';
    elseif plotting_group == 3
        % ShiTS regular and dim
        geno_inds_to_plot = [1:5 6:10];
        isdim = 1;
        graph_name = 'ShiTS Reg + Dim';
    elseif plotting_group == 4
        % Kir regular and dim
        geno_inds_to_plot = [11 12 13 14];
        isdim = 2;
        graph_name = 'Kir Reg + Dim';
    elseif plotting_group == 5
        % Kir regular and dim
        geno_inds_to_plot = [2 7];
        isdim = 2;
        graph_name = 'Kir Reg + Dim';
    end

    figure_color = [1 1 1];
    font_color = [0 0 0];
    axis_color = figure_color;
    zero_line_color = font_color;
    xy_color = [0 0 0];
    grid = 'off';
    fig_name_prefix = '';

    % Should only be plotting 7
    dim = .45;
    my_bright_colormap  = {[235 225 2]/255,[30 144 255]/255,[255 5 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255,[0 0 210]/255};
    my_dim_colormap     = {dim*[235 225 2]/255,dim*[30 144 255]/255,dim*[255 5 0]/255,dim*[238 0 238]/255,dim*[0 238 0]/255,dim*[255 44 44]/255,dim*[0 0 210]/255};

    my_colormap = [my_bright_colormap my_dim_colormap];
    
    if ~exist('summ_data','var')
        load(fullfile(summary_location,'summ_data'));
    end

    if optomotor_tune_figure
        
        curve_name = 'lam_30_rotation';

        hands{1} = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 1000 800],...
                                    'PaperOrientation','portrait');
        
        % Just make a tuning curve with the correct color
        for i = 1:numel(geno_inds_to_plot)
            graph.line{i}   = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr);
            graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr);
            
            graph.color{i}  = my_colormap{colormap_ind{geno_inds_to_plot(i)}};
            
            names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
            n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
            
        end
        
        graph.zero_line_color = [.27 .27 .27];
        
        makeErrorbarTuningCurve(graph);

        title({curve_name,graph_name},'interpreter','none')
        ylabel('Mean L-R WBA [V]','color',font_color)
        xlabel('Temporal Frequency','color',font_color)        
        
        legend_hand = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
        %set(legend_hand,'location','Best')
        
        clear graph names_plotted n_for_names_plotted
    end

    if optomotor_ts_figure
        
        curve_name = 'lam_30_rotation';
        
        % Set up subplot dimensions
        nHigh       = 1;
        nWide       = 4;
        widthGap    = .02;
        heightGap   = .05;
        widthOffset = .08;
        heightOffset= .04;
        
        sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
        
        % sawtooth off,on expansion of,on tuning curve
        plot_iter = 0;
        
        hands{1} = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 1000 800],...
                                    'PaperOrientation','portrait');
        
        for speed = 1:3
            
            plot_iter = plot_iter + 1;
            
            subplot('Position',sp_positions{1,plot_iter})            
            
            % Just make a tuning curve with the correct color
            for i = 1:numel(geno_inds_to_plot)
                graph.line{i} 	= (summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{speed});
                graph.shade{i}  = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts{speed});

                graph.color{i}  = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

            end

            graph.zero_line_color = [.27 .27 .27];

            makeErrorShadedTimeseries(graph);

            title({curve_name,graph_name},'interpreter','none')
            ylabel('Mean L-R WBA [V]','color',font_color)
            xlabel('Temporal Frequency','color',font_color)        

            if plot_iter == 3
                legend_hand = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
                %set(legend_hand,'location','Best')
            end
            
            axis([0 2500 -3.5 3.5])
            
            clear graph names_plotted n_for_names_plotted

        end
    end
    
    if sawtooth_expansion_tune_figure

        % Set up subplot dimensions
        nHigh       = 1;
        nWide       = 5;
        widthGap    = .02;
        heightGap   = .05;
        widthOffset = .08;
        heightOffset= .04;
        
        sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
        
        % sawtooth off,on expansion of,on tuning curve
        plot_iter = 0;
        
        hands{2} = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 1200 800],...
                                    'PaperOrientation','portrait');
        
        for cn = {'sawtooth_ON','sawtooth_OFF','expansion_ON','expansion_OFF'}
            
            plot_iter = plot_iter + 1;
            
            subplot('Position',sp_positions{1,plot_iter})            
            
            curve_name = cn{1};

                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i}       = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr);
                    graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr);
                    
                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

                end

                graph.zero_line_color = [.27 .27 .27];
                
                makeErrorbarTuningCurve(graph);

                title({curve_name,graph_name},'interpreter','none')
                ylabel('Mean L-R WBA [V]','color',font_color)
                xlabel('Temporal Frequency','color',font_color)        
                axis([0 2 0 2])

                if plot_iter == 4
                    [~] = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
                end
                
                clear graph names_plotted n_for_names_plotted
        end
    end
    
    if sawtooth_expansion_ts_figure

        % Set up subplot dimensions
        nHigh       = 2;
        nWide       = 3;
        widthGap    = .02; %% for the legend
        heightGap   = .1;
        widthOffset = .01;
        heightOffset= .04;
        
        sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
        
        % sawtooth off,on expansion of,on tuning curve
        plot_iter = 0;

        hands{2} = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 800 800],...
                                    'PaperOrientation','portrait');
        
        for cn = {'sawtooth_ON','sawtooth_OFF','expansion_ON','expansion_OFF'}
            
            plot_iter = plot_iter + 1;
            
            subplot('Position',sp_positions{plot_iter})
            
            curve_name = cn{1};
                
                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i}       = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts);
                    graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts);
                    
                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

                end
                
                graph.zero_line_color = [.27 .27 .27];
                
                makeErrorShadedTimeseries(graph);
                
                title({curve_name,graph_name},'interpreter','none')
                ylabel('Mean L-R WBA [V]','color',font_color)
                axis([0 3000 -3 3])
                
                if plot_iter == 4
                    [legend_hand] = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
                    set(legend_hand,'Position',[.75 .2 .2 .6])
                end
                
                clear graph names_plotted n_for_names_plotted
        end
    end
    
end

