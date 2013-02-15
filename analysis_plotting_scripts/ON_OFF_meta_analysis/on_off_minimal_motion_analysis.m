% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

data_location{1} = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v01';
data_location{2} = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v02';
data_location{3} = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v03';
data_location{4} = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v04';

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';

version_groups(1).cond_groups = [1 2 3 4 5 6];
version_groups(1).curve_names = {'v1_ON_OFF_44ms','v1_OFF_ON_44ms','v1_ON_OFF_76ms','v1_OFF_ON_76ms','v1_ON_OFF_116ms','v1_OFF_ON_116ms'};
version_groups(2).cond_groups = [1 2 3 4];
version_groups(2).curve_names = {'v2_ON_ON','v2_ON_OFF','v2_OFF_ON','v2_OFF_OFF'};
version_groups(3).cond_groups = [13 14 15 16 17 18 19 20];
version_groups(3).curve_names = {'v3_ON_ON_80','v3_ON_ON_160','v3_ON_OFF_80','v3_ON_OFF_160','v3_OFF_ON_80','v3_OFF_ON_160','v3_OFF_OFF_80','v3_OFF_OFF_160'};
version_groups(4).cond_groups = [18 19 20 21 22 23 24 25];
version_groups(4).curve_names = {'v4_ON_ON_short','v4_ON_ON_long','v4_ON_OFF_short','v4_ON_OFF_long','v4_OFF_ON_short','v4_OFF_ON_long','v4_OFF_OFF_short','v4_OFF_OFF_long'};

all_curve_names = {version_groups.curve_names};
all_curve_names = [all_curve_names{1:end}];

% Make space time diagrams in the figures
make_stds           = 1;

minimal_v1_figure   = 1;
minimal_v2_figure   = 1;
minimal_v3_figure   = 1;

% Save those figures as pdfs
save_figures        = 1;

% Process initial data and save summary.mat files
if 0
    for i = 1:numel(data_location) %#ok<*UNRCH>
        tfAnalysis.save_geno_group_summary_files(geno_names,data_location{i});
    end
end

if 0
    % Use summary files to save specific subsets of data in minimal_motion.mat
    
    addpath(genpath('/Users/stephenholtz/matlab-utils'))
    
    [B,A]=butter(2,.05,'low');

    for ver = 1:numel(version_groups)

        geno_data = tfAnalysis.load_geno_group_summary_files(geno_names,data_location{ver});

        % Calculate normalization value per genotype
        for i = 1:numel(geno_names)
           mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
        end
        
        geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
        
        [~,e_statement] = fileparts(data_location{ver});
        conditions = eval(e_statement);
        
        for i = 1:numel(geno_names)

            curve_names = version_groups(ver).curve_names;

            for condition_set_number = 1:numel(curve_names)

                curve_name = curve_names{condition_set_number};

                condition_group_numbers = version_groups(ver).cond_groups(condition_set_number);
                
                condition_numbers = geno_data{i}.grouped_conditions(condition_group_numbers).conds;
                
                minimal_motion.names{condition_set_number} = curve_name;

                % add an example space time diagram to the minimal_motion
                if 1
                    std_hand = tfPlot.arenaSimulation('small',conditions(condition_numbers{1,1}(1,1)));
                    fig_hand = std_hand.MakeSimpleSpaceTimeDiagram('green');
                    frame_info = getframe(fig_hand);
                    minimal_motion.(curve_name).space_time_diagram = frame_info.cdata;
                    clear std_hand fig_hand frame_info
                    close all
                end

                minimal_motion.(curve_name).raw(i).grouped_conditions = geno_data{i}.grouped_conditions(condition_set_number);

                % Pull out L-R, and X Data for each experiment: averages,
                % average timeseries, per-fly timeseries, all timeseries

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).avg_lmr = a;
                minimal_motion.(curve_name).raw(i).sem_lmr = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).avg_lmr_ts = a;
                minimal_motion.(curve_name).raw(i).sem_lmr_ts = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','exp',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).avg_per_fly_lmr_ts = a;
                minimal_motion.(curve_name).raw(i).sem_per_fly_lmr_ts = v;

                [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).all_lmr_ts = a;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','all',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).avg_x_pos_ts = a;
                minimal_motion.(curve_name).raw(i).sem_x_pos_ts = v;

                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','exp',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).avg_per_fly_x_pos_ts = a;
                minimal_motion.(curve_name).raw(i).sem_per_fly_x_pos_ts = v;

                [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','none',geno_norm_values(i));

                minimal_motion.(curve_name).raw(i).all_x_pos_ts = a;

                minimal_motion.note = '';

            end

        end
    
    end
    
    save(fullfile(data_location{end},'minimal_motion'),'minimal_motion')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

% colormaps
my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
grey_map        = {[205 201 201]/255,[125 125 125]/255};

if ~exist('minimal_motion','var')
    load(fullfile(data_location{end},'minimal_motion'));
end

if minimal_v1_figure
    
    % Set up subplot dimensions
    nHigh       = 6;
    nWide       = 5;
    widthGap    = .02;
    heightGap   = .02;
    widthOffset = .1;
    heightOffset= .02;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 1024],...
                            'PaperOrientation','portrait');
	%annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;
    iter = 0;
    
    for cn = version_groups(1).curve_names
        curve_name = cn{1};
        height_iter = height_iter+1;
        
        bar_loc = linspace(-90,90,5);
        
        for col = 1:nWide
            iter = iter + 1;
            subplot('Position',sp_positions{height_iter,col})
            
            x_trace = minimal_motion.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            graph.avg{i}        = minimal_motion.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = minimal_motion.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};

            tfPlot.timeseries(graph);
            box off
            axis([0 size(graph.avg{i},2) -1.25 1.25])

            if height_iter == 1
                title(['Pos: ' num2str(bar_loc(col))])
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 sp_positions{height_iter,col}(4)/1.2] )
                    subimage(minimal_motion.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off
                end
            end
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location{end},'minimal_motion_v01'),'-pdf'); end
end

if minimal_v2_figure
    
    % Set up subplot dimensions
    nHigh       = 4;
    nWide       = 5;
    widthGap    = .02;
    heightGap   = .02;
    widthOffset = .1;
    heightOffset= .02;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 1024],...
                            'PaperOrientation','portrait');
	%annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;
    iter = 0;
    
    for cn = version_groups(2).curve_names
        curve_name = cn{1};
        height_iter = height_iter+1;
        
        bar_loc = linspace(-90,90,5);
        
        for col = 1:nWide
            iter = iter + 1;
            subplot('Position',sp_positions{height_iter,col})
            
            x_trace = minimal_motion.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            graph.avg{i}        = minimal_motion.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = minimal_motion.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};

            tfPlot.timeseries(graph);
            box off
            axis([0 size(graph.avg{i},2) -1.25 1.25])

            if height_iter == 1
                title(['Pos: ' num2str(bar_loc(col))])
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 sp_positions{height_iter,col}(4)/1.2] )
                    subimage(minimal_motion.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off
                end
            end
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location{end},'minimal_motion_v02'),'-pdf'); end
end

if minimal_v3_figure
    
    % Set up subplot dimensions
    nHigh       = 8;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .02;
    widthOffset = .1;
    heightOffset= .02;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    i = 1;
    
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024/2 1024],...
                            'PaperOrientation','portrait');
	
	%annotation('textbox','Position',[0 0 1 1],'BackgroundColor',my_lr_colormap{1})
    
    height_iter     = 0;
    iter = 0;
    
    for cn = version_groups(3).curve_names
        curve_name = cn{1};
        height_iter = height_iter+1;
        
        bar_loc = [0 15];
        
        for col = 1:nWide
            iter = iter + 1;
            subplot('Position',sp_positions{height_iter,col})
            
            x_trace = minimal_motion.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace),'Color',grey_map{2},'linewidth',2);

            hold on
            
            graph.avg{i}        = minimal_motion.(curve_name).raw(i).avg_lmr_ts{col};
            graph.variance{i}   = minimal_motion.(curve_name).raw(i).sem_lmr_ts{col};
            graph.color{i}      = my_colormap{i};

            tfPlot.timeseries(graph);
            box off
            axis([0 size(graph.avg{i},2) -1.25 1.25])

            if height_iter == 1
                title(['Pos: ' num2str(bar_loc(col))])
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            end
            
            if col == 1
                ylabel(curve_name,'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.01 sp_positions{height_iter,col}(2) .06 sp_positions{height_iter,col}(4)/1.2] )
                    subimage(minimal_motion.(curve_name).space_time_diagram)
                    title('Space-Time')
                    axis off
                end
            end
        end
    end
    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location{end},'minimal_motion_v03'),'-pdf'); end
end