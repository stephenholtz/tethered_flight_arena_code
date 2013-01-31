% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/Bar_flicker_orientation_test_v01';
exp_dir = data_location;

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';

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
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:16
            % All of the individual tuning curves to be saved:
            if      condition_set_number == 1
                curve_name = 'Off_shortflick_thicklong';
            elseif  condition_set_number == 2
                curve_name = 'Off_shortflick_thickshort';
            elseif  condition_set_number == 3
                curve_name = 'Off_shortflick_thinlong';
            elseif  condition_set_number == 4
                curve_name = 'Off_shortflick_thinshort';
            elseif  condition_set_number == 5
                curve_name = 'Off_longflick_thicklong';
            elseif  condition_set_number == 6
                curve_name = 'Off_longflick_thickshort';
            elseif  condition_set_number == 7
                curve_name = 'Off_longflick_thinlong';
            elseif  condition_set_number == 8
                curve_name = 'Off_longflick_thinshort';
            elseif  condition_set_number == 9
                curve_name = 'On_shortflick_thicklong';
            elseif  condition_set_number == 10
                curve_name = 'On_shortflick_thickshort';
            elseif  condition_set_number == 11
                curve_name = 'On_shortflick_thinlong';
            elseif  condition_set_number == 12
                curve_name = 'On_shortflick_thinshort';
            elseif  condition_set_number == 13
                curve_name = 'On_longflick_thicklong';
            elseif  condition_set_number == 14
                curve_name = 'On_longflick_thickshort';
            elseif  condition_set_number == 15
                curve_name = 'On_longflick_thinlong';
            elseif  condition_set_number == 16
                curve_name = 'On_longflick_thinshort';
            end
            
            condition_numbers = geno_data{i}.grouped_conditions(condition_set_number).non_sym_list;
            condition_numbers = condition_numbers([1 2 3 4 6 7 8]);
            
            % For each of these conditions will need to do things manually,
            % so only L-R timeseriesdata (normalized...) and X position data really
            % matter
            
            % L - R data normalized
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','no','none',geno_norm_values(i));
            tuning_curves.(curve_name)(i).all_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).all_sem_ts            = variance_ts;
            
            % X position
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','yes','none',1);
            tuning_curves.(curve_name)(i).all_x_avg_ts            = avg_ts;
            
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'voltage_signal','none','no','none',1);
            tuning_curves.(curve_name)(i).all_voltage_avg_ts            = avg_ts;
            
            % Get offset calculated portions
            [avg_ts, variance_ts]           = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','none','no','none',geno_norm_values(i),381:400,'median',1:1200);
            
            tuning_curves.(curve_name)(i).all_pre_flick_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).all_pre_flick_sem_ts            = variance_ts;
            
            tuning_curves.names{condition_set_number} = curve_name;
            tuning_curves.(curve_name)(i).flick_time = geno_data{i}.grouped_conditions(condition_set_number).flick_time;
        end
    end
    
    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

%% Make short figure

if 1
    
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map        = {[205 201 201]/255,[125 125 125]/255};

	
    [B,A]=butter(2,.05,'low');
	
    nHigh = 5;
    nWide = 7;
    widthGap = .02;
    heightGap = .05;
    widthOffset = .1;
    heightOffset = .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    

    i = 1;
    N = 7;
	plot_this = 1;
    for cn = tuning_curves.names
        curve_name = cn{1};
        if plot_this
        tuningFigHandle(1) = figure( 'name' ,curve_name,'NumberTitle','off',...
                                'Color',[1 1 1],'Position',[50 50 1024 684],...
                                'PaperOrientation','portrait');
        end
        for bar_pos = 1:7

            for trace = 1:size(tuning_curves.(curve_name)(i).all_avg_ts{bar_pos},1)
                if max(diff(tuning_curves.(curve_name)(i).all_x_avg_ts{bar_pos}(trace,:))) > .5
                    x_does_move = 1;
                else
                    x_does_move = 0;
                end

                if x_does_move
                    filtered_responses.(curve_name)(i).all_avg_ts{bar_pos}(trace,:) = filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}(trace,:));
                    offset_responses.(curve_name)(i).all_avg_ts{bar_pos}(trace,:) = filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}(trace,:)) - median(filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}(trace,381:400)));
                    
                else
                    filtered_responses.(curve_name)(i).all_avg_ts{bar_pos}(trace,:) = nan(1200,1);
                    offset_responses.(curve_name)(i).all_avg_ts{bar_pos}(trace,:) = nan(1200,1);
                    tuning_curves.(curve_name)(i).all_x_avg_ts{bar_pos}(trace,:) = nan(1200,1);
                end
            end
            
            filtered_responses.(curve_name)(i).avg_ts{bar_pos}=nanmean(filtered_responses.(curve_name)(i).all_avg_ts{bar_pos});
            offset_responses.(curve_name)(i).avg_ts{bar_pos}=nanmean(offset_responses.(curve_name)(i).all_avg_ts{bar_pos});

            filtered_responses.(curve_name)(i).sem_ts{bar_pos}=nanstd(filtered_responses.(curve_name)(i).all_avg_ts{bar_pos})/sqrt(N);
            offset_responses.(curve_name)(i).sem_ts{bar_pos}=nanstd(offset_responses.(curve_name)(i).all_avg_ts{bar_pos})/sqrt(N);
            
            pre_flick_val = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(397:399));
            
            offset_responses_impuse.(curve_name)(1,bar_pos) = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(400:420)) - pre_flick_val;
            offset_responses_impuse.(curve_name)(2,bar_pos) = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(400:440)) - pre_flick_val;
            offset_responses_impuse.(curve_name)(3,bar_pos) = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(400:460)) - pre_flick_val;
            offset_responses_impuse.(curve_name)(4,bar_pos) = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(400:480)) - pre_flick_val;
            offset_responses_impuse.(curve_name)(5,bar_pos) = mean(filtered_responses.(curve_name)(i).avg_ts{bar_pos}(400:500)) - pre_flick_val;
            
            %fake_filtered_responses.(curve_name)(i).all_avg_ts{bar_pos} = filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos});
        end

        if plot_this
        for bar_pos = 1:7
            
            subplot('Position',sp_positions{1,bar_pos})
            
            graph.avg{i} = offset_responses.(curve_name)(i).avg_ts{bar_pos};
            graph.variance{i} = offset_responses.(curve_name)(i).sem_ts{bar_pos};
            graph.color{i} =  my_colormap{i};
            
            tfPlot.timeseries(graph);
            
            axis([0 1200 -1.25 1.25])
            clear graph
            
            subplot('Position',sp_positions{2,bar_pos})
            plot(tuning_curves.(curve_name)(i).all_x_avg_ts{bar_pos}');
            box off
            axis([0 1200 0 12])

            % Raw Data
            subplot('Position',sp_positions{3,bar_pos})
            plot(tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}');
            hold on; box off
            mean_resp = nanmean(tuning_curves.(curve_name)(i).all_avg_ts{bar_pos});
            plot(mean_resp,'k','linewidth',3)           
            axis([0 1200 -6 6])

            % Smoothed Data
            subplot('Position',sp_positions{4,bar_pos})
            plot(filtered_responses.(curve_name)(i).all_avg_ts{bar_pos}');
            hold on; box off
            mean_smooth_resp = nanmean(filtered_responses.(curve_name)(i).all_avg_ts{bar_pos});
            plot(mean_smooth_resp,'k','linewidth',3)        
            axis([0 1200 -4 4])

            % Smoothed and 'offset corrected' data
            subplot('Position',sp_positions{5,bar_pos})
            plot(offset_responses.(curve_name)(i).all_avg_ts{bar_pos}');
            hold on; box off
            mean_offset_resp = nanmean(offset_responses.(curve_name)(i).all_avg_ts{bar_pos});
            plot(mean_offset_resp,'k','linewidth',3)
            axis([0 1200 -4 4])
        end
        
        annotation('textbox','position',[ .3 .8 .2 .2],'string',curve_name,'interpreter','none','EdgeColor','none','fontsize',14);
        
        annotation('textbox','position',[.01 sp_positions{1,1}(2:end)],...
        'string','Smoothed Adjusted LmR (Mean / SEM)','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{2,1}(2:end)],...
        'string','X Pos','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{3,1}(2:end)],...
        'string','Raw LmR','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{4,1}(2:end)],...
        'string','Smoothed LmR','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{5,1}(2:end)],...
        'string','Smoothed Adjusted LmR','interpreter','none','EdgeColor','none','fontsize',14);
        
        export_fig(gcf,fullfile(data_location,filesep,[curve_name '_figure']),'-pdf') 

        end
    end
    
        tuningFigHandle(2) = figure( 'name' ,curve_name,'NumberTitle','off',...
                                'Position',[50 50 1024 684],...
                                'PaperOrientation','portrait');    nHigh = 4;
    nWide = 4;
    widthGap = .02;
    heightGap = .05;
    widthOffset = .2;
    heightOffset = .05;

    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    iter = 0;
    
    for cn = tuning_curves.names
        curve_name = cn{1};
        
        iter = iter + 1;
        subplot('Position',sp_positions{iter})
        
        plot(offset_responses_impuse.(curve_name)')
        title(curve_name,'interpreter','none','fontweight','bold','background',[1 1 1])
        ylabel('Mean LmR')
        
        if iter == 1
            lh=legend('20ms','40ms','60ms','80ms','100ms');
            set(lh,'Position',[0.0540752351097179 0.497872340425532 0.111686997141876 0.404255319148936]);

        end
        
    end
    
    export_fig(gcf,fullfile(data_location,filesep,'all_curves_figure'),'-pdf') 
    
end
