% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v04';
exp_dir = data_location;
geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';

% All of the tuning curves to be saved. Copied from the
% grouped_conditions struct in grouped_conds.m
curve_names = { 'minimal_ON_ON',...         1
                'minimal_ON_OFF',...        2
                'minimal_OFF_ON',...        3
                'minimal_OFF_OFF',...       4
                'edges_rear_ON_OFF',...     5
                'edges_center_ON_OFF',...   6
                'sweep_ON',...              7
                'sweep_OFF',...             8
                'steady_ON_ON',...          9
                'steady_ON_OFF',...         10
                'steady_OFF_ON',...         11
                'steady_OFF_OFF',...        12
                'opposed_ON_OFF',...        13
                'expansion_ON',...          14
                'expansion_OFF',...         15
                'sawtooth_ON',...           16
                'sawtooth_OFF'};%           17

% Make space time diagrams in the figures
make_stds               = 1;

% Make certain figures
minimal_figure          = 0;
steady_state_figure     = 0;
edge_sweep_figure       = 0;
competing_edges         = 0;
tuthill_opposed         = 0;
tuthill_motion          = 0;

% Save those figures as pdfs
save_figures            = 1;

% Process initial pruned data and save summary.mat files
if 0
    tfAnalysis.save_geno_group_summary_files(geno_names,data_location);
end

if 1
    % Use summary files to save specific subsets of data in summ_data.mat
    
    addpath(genpath('/Users/stephenholtz/matlab-utils'))

    if ~exist('geno_data','var')
        geno_data = tfAnalysis.load_geno_group_summary_files(geno_names,data_location);
    end

    % Calculate normalization value per genotype
    for i = 1:numel(geno_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    [B,A]=butter(2,.05,'low');
    
    conditions = ON_OFF_set_v04;
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:numel(curve_names)
            
            curve_name = curve_names{condition_set_number};
            
            condition_numbers = geno_data{i}.grouped_conditions(condition_set_number).conds;
            
            summ_data.names{condition_set_number} = curve_name;
            
            % add an example space time diagram to the summ_data
            if 1
                std_hand = tfPlot.arenaSimulation('small',conditions(condition_numbers{1,1}(1,1)));
                fig_hand = std_hand.MakeSimpleSpaceTimeDiagram('green');
                frame_info = getframe(fig_hand);
                summ_data.(curve_name).space_time_diagram = frame_info.cdata;
                clear std_hand fig_hand frame_info
                close all
            end
            
            summ_data.(curve_name).raw(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);
            
            % Pull out L-R, and X Data for each experiment: averages,
            % average timeseries, per-fly timeseries, all timeseries
            
            [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).avg_lmr = a;
            summ_data.(curve_name).raw(i).sem_lmr = v;
            
            [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).avg_lmr_ts = a;
            summ_data.(curve_name).raw(i).sem_lmr_ts = v;
            
            [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','exp',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).avg_per_fly_lmr_ts = a;
            summ_data.(curve_name).raw(i).sem_per_fly_lmr_ts = v;
            
            [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).all_lmr_ts = a;
            
            [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','all',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).avg_x_pos_ts = a;
            summ_data.(curve_name).raw(i).sem_x_pos_ts = v;
            
            [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','exp',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).avg_per_fly_x_pos_ts = a;
            summ_data.(curve_name).raw(i).sem_per_fly_x_pos_ts = v;
            
            [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','none',geno_norm_values(i));
            
            summ_data.(curve_name).raw(i).all_x_pos_ts = a;
            
            summ_data.note = 'The x_pos data is spared the direction conserving flip+average segment during analysis. In these stimuli, the patterns determine the CW vs CCW and the position functions are always the same for processing ease (at least I thought!).';
        
        end
    end
    
    save(fullfile(data_location,'summ_data'),'summ_data')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

% colormaps
my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
grey_map        = {[205 201 201]/255,[125 125 125]/255};

if ~exist('summ_data','var')
    load(fullfile(data_location,'summ_data'));
end

if minimal_figure
    
    % Set up subplot dimensions
    nHigh       = 4;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([1 2 3 4])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};

            tfPlot.timeseries(graph);
            box off
            axis([0 size(graph.avg{i},2) -1.25 1.25])

            if height_iter == 1
                if col == 1
                    title('L-R WBA For Periodic Minimal Motion Stimuli: Short Step Time') 
                elseif col == 2
                    title('L-R WBA For Periodic Minimal Motion Stimuli: Long Step Time') 
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end
            end
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'minimal_motion_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'minimal_motion_v04'),'-fig'); end
end

if steady_state_figure
    
    % Set up subplot dimensions
    nHigh       = 4;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([9 10 11 12])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            switch_point = (size(graph.avg{i},2)/2) - 10;
            plot(repmat(switch_point,3,1),-1:1,'--','Color',grey_map{2},'linewidth',1)

            tfPlot.timeseries(graph);
            box off
            
            axis([0 size(graph.avg{i},2) -1.75 1.75])

            if height_iter == 1
                if col == 1
                    title('L-R WBA For Steady State Switch: 100 dps') 
                elseif col == 2
                    title('L-R WBA For Steady State Switch: 220 dps') 
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end             
            end
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'steady_state_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'steady_state_v04'),'-fig'); end
    
end

if edge_sweep_figure
    
    % Set up subplot dimensions
    nHigh       = 2;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([7 8])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            %switch_point = (size(graph.avg{i},2)/2) - 10;
            %plot(repmat(switch_point,3,1),-1:1,'--','Color',grey_map{2},'linewidth',1)

            tfPlot.timeseries(graph);
            box off
            
            axis([0 size(graph.avg{i},2) -1.5 1.5])
            
            if height_iter == 1
                if col == 1
                    title('L-R WBA For Edge Sweep 8 Pix Wide: 100 dps')
                elseif col == 2
                    title('L-R WBA For Edge Sweep 8 Pix Wide: 220 dps')
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end              
            end
            
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'edges_sweep_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'edges_sweep_v04'),'-fig'); end
end

if competing_edges
    
    % Set up subplot dimensions
    nHigh       = 2;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([5 6])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            %switch_point = (size(graph.avg{i},2)/2) - 10;
            %plot(repmat(switch_point,3,1),-1:1,'--','Color',grey_map{2},'linewidth',1)

            tfPlot.timeseries(graph);
            box off
            
            axis([0 size(graph.avg{i},2) -1.5 1.5])
            
            if height_iter == 1
                if col == 1
                    title('L-R WBA For Edge Sweep 8 Pix Wide: 100 dps') 
                elseif col == 2
                    title('L-R WBA For Edge Sweep 8 Pix Wide: 220 dps') 
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end        
            end

            
        end
    end

    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'competing_edges_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'competing_edges_v04'),'-fig'); end
end

if tuthill_opposed
    
    % Set up subplot dimensions
    nHigh       = 1;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([13])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            %switch_point = (size(graph.avg{i},2)/2) - 10;
            %plot(repmat(switch_point,3,1),-1:1,'--','Color',grey_map{2},'linewidth',1)

            tfPlot.timeseries(graph);
            box off
            
            axis([0 size(graph.avg{i},2) -1.25 1.25])
            
            if height_iter == 1
                if col == 1
                    title('L-R WBA For Opposing Edges: 15 dps')
                elseif col == 2
                    title('L-R WBA For Opposing Edges: 30 dps')
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end        
            end

            
        end
    end

    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'tuthill_competing_edges_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'tuthill_competing_edges_v04'),'-fig'); end
end

if tuthill_motion
    
    % Set up subplot dimensions
    nHigh       = 4;
    nWide       = 1;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024/2 684],...
                            'PaperOrientation','portrait');
	annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;

    for cn = curve_names([14 15 16 17])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide

            subplot('Position',sp_positions{height_iter,col})
            
            graph.avg{i}        = summ_data.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = summ_data.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            %switch_point = (size(graph.avg{i},2)/2) - 10;
            %plot(repmat(switch_point,3,1),-1:1,'--','Color',grey_map{2},'linewidth',1)

            tfPlot.timeseries(graph);
            box off
            
            axis([0 size(graph.avg{i},2) -1.25 1.25])
            
            title('L-R WBA') 
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off   
                end        
            end

            
        end
    end

    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'tuthill_on_off_motion_v04'),'-pdf'); end
    %if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'tuthill_on_off_motion_v04'),'-fig'); end
end