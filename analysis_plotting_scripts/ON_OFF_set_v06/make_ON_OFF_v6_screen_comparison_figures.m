% This will make a few screen-like summary figures for the ON OFF tethered
% flight stuff
%
% For now only timeseries in one large figure makes sense, with a second
% figure below with same subplot positions and space-time diagrams so we
% can easily flip between the two and see what stimuli were used
%
% Comparisons here get tricky: 
% Shi-TS - figures to compare to BOTH unshifted control, and control that
%          was shifted to the higher temp
%        - also have a version that compares Kir and Shi-TS versus their
%          respective controls
% Kir    - Compare to the split half, or the un-temperature shifted
%          versions
% 
% The summ_data structure should have flipped and averaged, as well as CW /
% CCW versions of each LmR timeseries response.
%

% Initial variables which all scripts use
data_loc.long = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06';
data_loc.short = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_short';
%data_location = '/Volumes/reiserlab/slh_fs/ON_OFF_set_v06';

summary_loc.long = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06';
summary_loc.short = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_short';

% All of the geno_names are the folder names with the data, and the
% better_geno_names are what the folder contents will be called in the
% figure legends etc.,

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';                better_geno_names{1}  = 'Ctrl (48a08ad kir)';
geno_names{2} = 'gmr_29g11dbd_gal80ts_kir21';               better_geno_names{2}  = 'Ctrl (29g11dbd kir)';

geno_names{3} = 'dim_gmr_48A08ad_66A01dbd_gal80ts_kir21';   better_geno_names{3}  = 'L1 DIM (48a08ad 66a01dbd kir)';

geno_names{4} = 'gmr_75h07ad_29g11dbd_gal80ts_kir21';       better_geno_names{4}  = '?? (75h07ad 29g11dbd kir)';
geno_names{5} = 'gmr_48a08ad_29g11dbd_gal80ts_kir21';       better_geno_names{5}  = 'L1+2 (48a08ad 29g11dbd kir)';
geno_names{6} = 'gmr_82f12ad_75h08dbd_gal80ts_kir21';       better_geno_names{6}  = 'L2 (82f12ad 75h08dbd kir)';
geno_names{7} = 'gmr_48a08ad_66a01dbd_gal80ts_kir21';       better_geno_names{7}  = 'L1 (48a08ad 66a01dbd kir)';
geno_names{8} = 'gmr_53g02ad_29g11dbd_gal80ts_kir21';       better_geno_names{8}  = 'L2 (53g02ad 29g11dbd kir)';

geno_names{9}  = 'gmr_53g02ad_29g11dbd_kitamoto_shibire';   better_geno_names{9}  = 'L2 (53g02ad 29g11dbd shiTS)';
geno_names{10} = 'gmr_82f12ad_75h08dbd_kitamoto_shibire';   better_geno_names{10} = 'L2 (82f12ad 75h08dbd shiTS)';
geno_names{11} = 'gmr_48a08ad_66a01dbd_kitamoto_shibire';   better_geno_names{11} = 'L1 (48a08ad 66a01dbd shiTS)';
geno_names{12} = 'ok371vp16ad_ortc3dbd_kitamoto_shibire';   better_geno_names{12} = 'L1 (ok371vp16ad ortc3dbd shiTS)';

geno_names{13} = 'shift_L1_c202a_kitamoto_shibire';                 better_geno_names{13} = '[34C] L1 (c202a shiTS)';
geno_names{14} = 'shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';     better_geno_names{14} = '[34C] L1 (48a08ad 66a01dbd shiTS)';
geno_names{15} = 'shift_iso_d1_kitamoto_shibire';                   better_geno_names{15} = '[34C] Ctrl (ISO-D1 shiTS)';
geno_names{16} = 'shift_ok371_vp16_ad_ort_c1_3_dbd_kitamoto_shibire';better_geno_names{16} = '[34C] L1 (ok371vp16ad ortc3dbd shiTS)';

geno_names{17} = 'dim_shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';      better_geno_names{17} = '[34C] L1 DIM (48a08ad 66a01dbd shiTS)';
geno_names{18} = 'dim_shift_iso_d1_kitamoto_shibire';                    better_geno_names{18} = '[34C] Ctrl DIM (ISO-D1 shiTS)';
geno_names{19} = 'dim_shift_ok371vp16ad_ortc3dbd_kitamoto_shibire'; better_geno_names{19} = '[34C] L1 DIM (ok371vp16ad ortc3dbd shiTS)';

geno_names{20} = 'dim_retest2_gmr_48a08ad_66a01dbd_gal80ts_kir21'; better_geno_names{20} = 'L1 DIM Retest (48a08ad 66a01dbd kir)';

for i = 1:20
   data_location{i} = data_loc.long;
   summary_location{i} = summary_loc.long;
end

% new, short protocol
geno_names{21} = 'dim_gmr_48a08ad_gal80ts_kir21'; better_geno_names{21} = 'Ctrl DIM (48a08ad kir)';
geno_names{22} = 'shift_gmr_48a08ad_kitamoto_shibire'; better_geno_names{22} = '[34C] Ctrl (48a08ad shiTS)';
geno_names{numel(geno_names) + 1} = 'shift_gmr_48a08ad_kitamoto_shibire'; better_geno_names{numel(geno_names)} = 'FILLER';

for i = 21:numel(geno_names)
   data_location{i} = data_loc.short;
   summary_location{i} = summary_loc.short;
end

for plot_group = 8

    switch plot_group
        case 1
            geno_name_inds_to_plot = 1:numel(geno_names);
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'all_groups_';
        case 2
            geno_name_inds_to_plot = [1 2 6];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'L1_comparison_';
        case 3
            geno_name_inds_to_plot = 1:5;
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'standard_';
        case 4
            geno_name_inds_to_plot = [1 13 14];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'shi_kir_ctrls_';
        case 5
            geno_name_inds_to_plot = [13 14 15 16];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'shi_shifted_';
        case 6
            geno_name_inds_to_plot = [17 18 19];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'shi_dim_shift_';
        case 7
            geno_name_inds_to_plot = [14 17 16 19];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'shi_dim_shift_compare_no_ctrl_';
        case 8
            geno_name_inds_to_plot = [7 3 20];
            better_geno_names_to_plot = better_geno_names(geno_name_inds_to_plot);
            name_type = 'dim_retest_L1_kir_comparison_';
    end
    
    % All of the tuning curves to be saved. Copied from the
    % grouped_conditions struct in grouped_conds.m
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
                    'sawtooth_OFF'};%           14*
    
    % Make space time diagrams in the figures
    % make_stds               = 1;
    
    % Save figures as pdfs
    save_figures            = 0;
    
    % Make certain figures
    edges_sweep_steady_figure   = 0;
    tuthill_stimuli_figure      = 0;
    
    % Process initial pruned data and save summary.mat files
    if 1
        tfAnalysis.save_geno_group_summary_files(geno_names,data_location,0);
    end
    
    if 1
        % Use summary files to save specific subsets of data in summ_data.mat

        addpath(genpath('/Users/stephenholtz/matlab-utils'))
        
        fprintf('\n\nLoading in *_summary.mat files from %s.',summary_location{1})
        
        if ~exist('geno_data','var')
            geno_data = tfAnalysis.load_geno_group_summary_files(geno_names,summary_location);
        end
        
        % Calculate normalization value per genotype
        for i = numel(geno_names)
           mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
        end

        geno_norm_values = mean_turning_resps/mean(mean_turning_resps);

        [B,A]=butter(2,.05,'low');

        % MAKE SURE TO CHANGE THIS TO THE LATEST VERSION!
        conditions = ON_OFF_set_v06;

        summ_data.better_names = better_geno_names;
        
        fprintf('\n\nProcessing data from %d genotypes: ',numel(geno_names))
        
        for i = 1:numel(geno_names)

            fprintf('%d,',i)
            
            if i < 21 || i == numel(geno_names)
                curve_inds_to_use = 1:numel(curve_names);
            else
                curve_inds_to_use = [3 4 9:14];
            end
            
            for condition_set_number = curve_inds_to_use

                % Gets CW or CCW or flipped and averaged

                for sym = 3 %1:3

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
                    
                    summ_data.(curve_name).raw(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);

                    condition_numbers = geno_data{i}.grouped_conditions(condition_set_number).conds;
                    summ_data.(curve_name).(['raw' symmetry])(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);

                    for u = 1:numel(condition_numbers)
                        condition_numbers{u} = condition_numbers{u}(sym_inds);
                    end

                    % add an example space time diagram to the summ_data
                    if 0
                        if i == 1
                        std_hand = tfPlot.arenaSimulation('small',conditions(condition_numbers{1}(1)));
                        fig_hand = std_hand.MakeSimpleSpaceTimeDiagram('green');
                        frame_info = getframe(fig_hand);
                        summ_data.(curve_name).space_time_diagram{sym} = frame_info.cdata;
                        clear std_hand fig_hand frame_info
                        close all
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

                    summ_data.B = B;
                    summ_data.A = A;
                    
                end
            end
        end
        
        fprintf('\n ...Saving summarized data.\n')
        
        save(fullfile(summary_location,'summ_data'),'summ_data')
        
        clear curve_name condition_set_number i avg variance avg_ts variance_ts
        
    end
    
    % Set up colormaps, variables etc.,
    
    % Make a black version of the figure for nice contrast if wanted
    black_figure = 0;
    
    if black_figure
        figure_color = [0 0 0];
        font_color = [1 1 1];
        axis_color = figure_color;
        zero_line_color = font_color;
        xy_color = [1 1 1];
        grid = 'off';
        fig_name_prefix = 'black_';
    else
        figure_color = [1 1 1];
        font_color = [0 0 0];
        axis_color = figure_color;
        zero_line_color = font_color;
        xy_color = [0 0 0];
        grid = 'off';
        fig_name_prefix = '';
    end

    colormap_type = 'mine';

    switch colormap_type
        case 'mine'
            my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255,[0 0 210]/255};
        otherwise
            temp_colormap = pastel(1:numel(geno_names)+2);

            for i = 1:size(temp_colormap,2)-1
                my_colormap{i} = squeeze(temp_colormap(:,i+1,:))';
            end
            clear temp_colormap;
    end
    
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map        = {[205 201 201]/255,[125 125 125]/255};

    title_fontsize = 14;

    if ~exist('summ_data','var')
        load(fullfile(summary_location,'summ_data'));
    end
    
for easy_code_collapse = 1
    if edges_sweep_steady_figure

        % Set up subplot dimensions
        nHigh       = 4;
        nWide       = 5;
        widthGap    = .02;
        heightGap   = .05;
        widthOffset = .08;
        heightOffset= .04;

        sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);


        edges_sweep_steady_figure_handle(1) = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                'Color',figure_color,'Position',[50 50 1000 800],...
                                'PaperOrientation','portrait');    

        % Plot the 'edges' and the 'sweep'

        % Each cond_num is a new row
        row_iter = 1;

        for cond_num = [1 2 3 4]

            curve_name = curve_names{cond_num};

            % Each speed is a new col
            col_iter = 1;

            for speed = 1:2

                graph_iter = 1;
                for u = geno_name_inds_to_plot
                    graph.line{graph_iter}        = summ_data.(curve_name).raw(u).avg_lmr_ts{speed};
                    graph.shade{graph_iter}       = summ_data.(curve_name).raw(u).sem_lmr_ts{speed};
                    graph.color{graph_iter}       = my_colormap{graph_iter};
                    N(graph_iter)                 = summ_data.(curve_name).raw(u).N;
                    graph_iter = graph_iter + 1;
                end

                graph.zero_line_color = zero_line_color;

                subplot('Position',sp_positions{row_iter,col_iter})            

                makeErrorShadedTimeseries(graph);

                set(gca,'color',axis_color,'XGrid','on','YGrid','on');

                axis([0 size(graph.line{1},2) -3 3])

                set(gca,'XColor',xy_color,'YColor',xy_color)

                % Label Plots correctly
                if speed == 1
                   ylabel('L-R WBA [V]','color',font_color)
                end

                if row_iter == 4
                   xlabel('Time [ms]','color',font_color)
                end

                if row_iter == 1
                    if speed == 1
                        title('Edges From Rear: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('Edges From Rear: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 2
                    if speed == 1
                        title('Edges From Front: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('Edges From Front: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 3
                    if speed == 1
                        title('Sweep ON: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('Sweep ON: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 4
                    if speed == 1
                        title('Sweep OFF: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('Sweep OFF: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                end

                % Add legend with all the genotype names
                if row_iter == 1 && speed == 2

                    legend_names = [];

                    graph_iter = 1;
                    for u = geno_name_inds_to_plot
                        legend_names{graph_iter} = better_geno_names_to_plot{graph_iter};
                        graph_iter = graph_iter + 1;
                    end

                    [legend_hand,obj_hand,~,text_content]=legend(legend_names);
                    set(legend_hand,'location','NorthEastOutside','interpreter','none')

                    for u = 1:numel(text_content)
                        text = text_content{u};
                        set(obj_hand(u),'String',{[text(1:13) '-'],text(14:end),[' N = ' num2str(N(u))]})
                        set(obj_hand(u),'linewidth',5,'color',font_color)
                    end

                    legend_pos = get(legend_hand,'Position');
                    new_legend_pos = [legend_pos(1)+.01 legend_pos(2)/2 legend_pos(3) legend_pos(4)*4];
                    set(legend_hand,'Position',new_legend_pos,'box','off');

                end

                col_iter = col_iter + 1;

                clear graph

            end

            row_iter = row_iter + 1;

        end

        % Plot the 'steady state'

        % Each cond_num is a new row
        row_iter = 1;

        for cond_num = [5 6 7 8]

            curve_name = curve_names{cond_num};

            % Each speed is a new col, starting at col 4
            col_iter = 4;

            for speed = 1:2

                graph_iter = 1;
                for u = geno_name_inds_to_plot
                    graph.line{graph_iter}        = summ_data.(curve_name).raw(u).avg_lmr_ts{speed};
                    graph.shade{graph_iter}       = summ_data.(curve_name).raw(u).sem_lmr_ts{speed};
                    graph.color{graph_iter}       = my_colormap{graph_iter};
                    N(graph_iter)                 = summ_data.(curve_name).raw(u).N;
                    graph_iter = graph_iter + 1;
                end

                graph.zero_line_color = zero_line_color;

                subplot('Position',sp_positions{row_iter,col_iter})            

                makeErrorShadedTimeseries(graph);

                set(gca,'color',axis_color,'XGrid','on','YGrid','on');

                axis([0 size(graph.line{1},2) -2 2])

                set(gca,'XColor',xy_color,'YColor',xy_color)

                % Label Plots correctly
                if speed == 1
                   ylabel('L-R WBA [V]','color',font_color)
                end

                if row_iter == 4
                   xlabel('Time [ms]','color',font_color)
                end

                if row_iter == 1
                    if speed == 1
                        title('ON->ON: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('ON->ON: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 2
                    if speed == 1
                        title('ON->OFF: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('ON->OFF: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 3
                    if speed == 1
                        title('OFF->ON: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('OFF->ON: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                elseif row_iter == 4
                    if speed == 1
                        title('OFF->OFF: 100 dps','Fontsize',title_fontsize,'color',font_color)
                    elseif speed == 2
                        title('OFF->OFF: 220 dps','Fontsize',title_fontsize,'color',font_color)
                    end
                end

                col_iter = col_iter + 1;

                clear graph
            end

            row_iter = row_iter + 1;

        end

        annotation('textbox','position',[ .15 .88 .62 .1],'string','New ON OFF Stimuli','fontweight','bold','interpreter','none','EdgeColor','none','Fontsize',title_fontsize+2,'Color',font_color);

        if save_figures; export_fig(edges_sweep_steady_figure_handle(1),fullfile(summary_location,[fig_name_prefix name_type 'new_ON_OFF_stimuli']),'-pdf'); end

    end

    if tuthill_stimuli_figure
        % Set up subplot dimensions
        nHigh       = 2;
        nWide       = 5;
        widthGap    = .04;
        heightGap   = .1;
        widthOffset = .08;
        heightOffset= .01;

        sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);

        tuthill_stimuli_figure_handle(1) = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                'Color',figure_color,'Position',[50 50 1000 800],...
                                'PaperOrientation','portrait');    

        % plot opposed motion

        curve_name = 'opposed_ON_OFF';

        speed = 1;

        graph_iter = 1;
        for u = geno_name_inds_to_plot
            graph.line{graph_iter}        = summ_data.(curve_name).raw(u).avg_lmr_ts{speed};
            graph.shade{graph_iter}       = summ_data.(curve_name).raw(u).sem_lmr_ts{speed};
            graph.color{graph_iter}       = my_colormap{graph_iter};
            N(graph_iter)                 = summ_data.(curve_name).raw(u).N;
            graph_iter = graph_iter + 1;
        end


        sp = sp_positions{1,1};
        sp(3) = sp(3)*1.75;
        sp(1) = sp(1)*1.15;

        graph.zero_line_color = zero_line_color;

        subplot('Position',sp)

        makeErrorShadedTimeseries(graph);

        set(gca,'color',axis_color,'XGrid','on','YGrid','on');

        axis([0 size(graph.line{1},2) -2 2])

        set(gca,'XColor',xy_color,'YColor',xy_color)

        title('Opposed Motion','Fontsize',title_fontsize,'color',font_color)

        ylabel('L-R WBA [V]','color',font_color)

        xlabel('Time [ms]','color',font_color)

        % plot rotation

        curve_name = 'lam_30_rotation';

        % each speed is a new column
        col_iter = 3;
        row_iter = 1;

        for speed = 1:3

            graph_iter = 1;
            for u = geno_name_inds_to_plot
                graph.line{graph_iter}        = summ_data.(curve_name).raw(u).avg_lmr_ts{speed};
                graph.shade{graph_iter}       = summ_data.(curve_name).raw(u).sem_lmr_ts{speed};
                graph.color{graph_iter}       = my_colormap{graph_iter};
                N(graph_iter)                 = summ_data.(curve_name).raw(u).N;
                graph_iter = graph_iter + 1;
            end

            graph.zero_line_color = zero_line_color;

            subplot('Position',sp_positions{row_iter,col_iter})

            makeErrorShadedTimeseries(graph);

            set(gca,'color',axis_color,'XGrid','on','YGrid','on');

            axis([0 size(graph.line{1},2) -3.5 3.5])

            set(gca,'XColor',xy_color,'YColor',xy_color)

            % Label Plots correctly
            if col_iter == 1
               ylabel('L-R WBA [V]','color',font_color)
            end

            if speed == 1;
                title({'Optomotor',' \lambda 30, 15 dps'},'Fontsize',title_fontsize,'color',font_color)
            elseif speed == 2
                title({'Optomotor','\lambda 30, 90 dps'},'Fontsize',title_fontsize,'color',font_color)
            elseif speed == 3
                title({'Optomotor','\lambda 30, 270 dps'},'Fontsize',title_fontsize,'color',font_color)
            end

            col_iter = col_iter + 1;

            clear graph
        end

        % plot sawtooth, expansion

        % Each cond_num is a new col
        row_iter = 2;
        col_iter = 1;

        for cond_num = [11 12 13 14]

            curve_name = curve_names{cond_num};

            % Each speed is a new col, starting at col 4


            speed = 1;

            graph_iter = 1;
            for u = geno_name_inds_to_plot
                graph.line{graph_iter}        = summ_data.(curve_name).raw(u).avg_lmr_ts{speed};
                graph.shade{graph_iter}       = summ_data.(curve_name).raw(u).sem_lmr_ts{speed};
                graph.color{graph_iter}       = my_colormap{graph_iter};
                N(graph_iter)                 = summ_data.(curve_name).raw(u).N;
                graph_iter = graph_iter + 1;
            end


            graph.zero_line_color = zero_line_color;

            subplot('Position',sp_positions{row_iter,col_iter})            

            makeErrorShadedTimeseries(graph);

            set(gca,'color',axis_color,'XGrid','on','YGrid','on');

            set(gca,'XColor',xy_color,'YColor',xy_color)

            % Label Plots correctly
            if col_iter == 1 || col_iter == 4
               ylabel('L-R WBA [V]','color',font_color)
            end

            xlabel('Time [ms]','color',font_color)

            if col_iter == 1
                title('ON Expansion','Fontsize',title_fontsize,'color',font_color)
                axis([0 size(graph.line{1},2) -2 2])
            elseif col_iter == 2
                title('OFF Expansion','Fontsize',title_fontsize,'color',font_color)
                axis([0 size(graph.line{1},2) -2 2])            
            elseif col_iter == 4
                title('ON Sawtooth','Fontsize',title_fontsize,'color',font_color)
                axis([0 size(graph.line{1},2) -3 3])            
            elseif col_iter == 5
                title('OFF Sawtooth','Fontsize',title_fontsize,'color',font_color)
                axis([0 size(graph.line{1},2) -3 3])            
            end

            % Add legend with all the genotype names
            if row_iter == 2 && col_iter == 2

                legend_names = [];

                graph_iter = 1;
                for u = geno_name_inds_to_plot
                    legend_names{graph_iter} = better_geno_names_to_plot{graph_iter};
                    graph_iter = graph_iter + 1;
                end

                [legend_hand,obj_hand,~,text_content]=legend(legend_names);
                set(legend_hand,'location','NorthEastOutside','interpreter','none')

                for u = 1:numel(text_content)
                    text = text_content{u};
                    set(obj_hand(u),'String',{[text(1:13) '-'],text(14:end),[' N = ' num2str(N(u))]})
                    set(obj_hand(u),'linewidth',5,'color',font_color)
                end

                legend_pos = get(legend_hand,'Position');
                new_legend_pos = [legend_pos(1)+.01 .05 legend_pos(3) legend_pos(4)*4];
                set(legend_hand,'Position',new_legend_pos,'box','off');

            end

            if col_iter == 2
                col_iter = col_iter + 2;
            else
                col_iter = col_iter + 1;
            end
            clear graph
        end

        annotation('textbox','position',[ .15 .88 .62 .1],'string','Tuthill ON OFF Stimuli','fontweight','bold','interpreter','none','EdgeColor','none','Fontsize',title_fontsize+2,'Color',font_color);

        if save_figures; export_fig(tuthill_stimuli_figure_handle(1),fullfile(summary_location,[fig_name_prefix name_type 'tuthill_ON_OFF_stimuli']),'-pdf'); end

    end

end

end