% This will make a few screen-like summary figures for the ON OFF tethered
% flight stuff
%
% For now only timeseries in one large figure makes sense, with a second
% figure below with same subplot positions and space-time diagrams so we
% can easily flip between the two and see what stimuli were used
% 
% (Also try out my tuning curve + timeseries plot idea!!)
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
% 
% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06';
%data_location = '/Volumes/reiserlab/slh_fs/ON_OFF_set_v06';
summary_location = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06';

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';
%geno_names{2} = 'gmr_48a08ad_gal80ts_kir21';

% All of the tuning curves to be saved. Copied from the
% grouped_conditions struct in grouped_conds.m
curve_names = { 'edges_rear_ON_OFF',...     1
                'edges_center_ON_OFF',...   2
                'sweep_ON',...              3
                'sweep_OFF',...             4
                'steady_ON_ON',...          5
                'steady_ON_OFF',...         6
                'steady_OFF_ON',...         7
                'steady_OFF_OFF',...        8
                'lam_30_rotation',...       9
                'opposed_ON_OFF',...        10
                'expansion_ON',...          11
                'expansion_OFF',...         12
                'sawtooth_ON',...           13
                'sawtooth_OFF'};%           14

% Make space time diagrams in the figures
make_stds               = 1;

% Save figures as pdfs
save_figures            = 1;

% Make certain figures
all_raw_timeseries_figure  = 1;
tuning_curve_and_ts_figure = 1;

% Process initial pruned data and save summary.mat files
if 0
    tfAnalysis.save_geno_group_summary_files(geno_names,data_location);
end

if 0
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
    
    % MAKE SURE TO CHANGE THIS TO THE LATEST VERSION!
    conditions = ON_OFF_set_v06;
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:numel(curve_names)
            
            % Gets CW or CCW or flipped and averaged
            
            for sym = 1:3
                
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
                if 1
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
                
                summ_data.B = B;
                summ_data.A = A;
                
            end
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



if all_raw_timeseries_figure
    
    % Set up subplot dimensions
    nHigh       = 4;
    nWide       = 2;
    widthGap    = .02;
    heightGap   = .05;
    widthOffset = .1;
    heightOffset= .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    
    
    
end


















if 0

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
                            'Color',[1 1 1],'Position',[50 50 345 684],...
                            'PaperOrientation','portrait');    
    height_iter     = 0;

    for cn = curve_names([5 6 7 8])
        curve_name = cn{1};
        height_iter = height_iter+1;

        for col = 1:nWide
            
            subplot('Position',sp_positions{height_iter,col})
            
            for u = 1
                graph.line{u}        = summ_data.(curve_name).raw(u).avg_lmr_ts{col};
                graph.shade{u}       = summ_data.(curve_name).raw(u).sem_lmr_ts{col};
                graph.color{u}       = my_lr_colormap{u};
            end
            
            x_trace = summ_data.(curve_name).raw(i).avg_x_pos_ts{col};
            x_trace = x_trace-(mean(x_trace(1:10)));
            plot(x_trace/max(x_trace)*1.5,'Color',grey_map{2},'linewidth',2);
            
            hold on
            
            switch_point = (size(graph.line{i},2)/2) - 10;
            plot(repmat(switch_point,7,1),-3:3,'--','Color',grey_map{2},'linewidth',1)

            makeErrorShadedTimeseries(graph);
            box off
            
            axis([0 size(graph.line{i},2) -3 3])
            
            if height_iter == 1
                if col == 1
                    title({'L-R WBA Timeseries','Steady State Switch: 60 dps'}) 
                elseif col == 2
                    title({'L-R WBA Timeseries',' Steady State Switch: 120 dps'}) 
                end
            end
            
            if height_iter == nHigh
                xlabel('Time (ms)')
            else
                if col ~= 1
                    axis off
                end
            end
            
            if col == 1
                ylabel(['                                  ', curve_name],'interpreter','none','FontWeight','bold')
                if make_stds
                    subplot('Position',[0.015 sp_positions{height_iter,col}(2)-.05 .06 .06] )
                    subimage(summ_data.(curve_name).space_time_diagram{1})
                    title({'Space-','Time'})
                    axis off   
                end
            end
        end
    end
    
    lh=legend('x_pos','switch','LmR'); 
    set(lh,'interpreter','none','location','best');    
    if save_figures; export_fig(tuningFigHandle(1),fullfile(data_location,'steady_state_v06'),'-pdf'); end
end

