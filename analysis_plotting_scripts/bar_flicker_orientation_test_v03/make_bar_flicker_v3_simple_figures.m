% Script for making a figure for the unilateral flicker stimulus
% Relies on +tfAnalysis

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/Bar_flicker_orientation_test_v03';
exp_dir = data_location;

geno_names{1} = 'gmr_48a08ad_gal80ts_kir21';

if 0
    % Process initial raw data and save summary.mat files
    tfAnalysis.save_geno_group_summary_files(geno_names,data_location);
end

if 0
    % Load in summary files
    geno_data = tfAnalysis.load_geno_group_summary_files(geno_names,data_location);
end

%% Use summary files to save specific subsets of data in tuning_curves.mat

if 0
    
    % Calculate normalization value per genotype
    for i = 1:numel(geno_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    [B,A]=butter(2,.05,'low');

    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:4
            % All of the individual tuning curves to be saved:
            if      condition_set_number == 1
                curve_name = 'Off_short_flick';
            elseif  condition_set_number == 2
                curve_name = 'Off_long_flick';
            elseif  condition_set_number == 3
                curve_name = 'On_short_flick';
            elseif  condition_set_number == 4
                curve_name = 'On_long_flick';
            end
            
            condition_numbers = geno_data{i}.grouped_conditions(condition_set_number).non_sym_list;
            
            % For each of these conditions will need to do things manually,
            % so only L-R timeseriesdata (normalized...) and X position data really
            % matter
            
            % L - R data normalized, aligned
            [lmr_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','no','none',geno_norm_values(i));

            % X position
            [x_pos_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','none',1);

            [volt_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'voltage_signal','none','no','none',1);
            
            buffer_amt = 20; % ms trimmed off of the end for shifting the responses to match each other
            
            shift_start_pos = 270; % all will be shifted to 'start' at x pos 270
            
            trace_iter = 0;
            
            for sub_stim = 1:numel(lmr_ts)
                for trace = 1:size(lmr_ts{sub_stim},1)
                    
                    [~,flick_loc] = max(diff(x_pos_ts{sub_stim}(trace,100:end)));
                    
                    shift_amt = flick_loc - 1 + 100 - shift_start_pos;
                    
                    % Something is wrong if the shift_amt is negative (i.e.
                    % the jump happened in a really strange place , or the
                    % sitmulus went to closed loop for some reason). Just
                    % ignore these.
                    if shift_amt < buffer_amt && shift_amt >= 0

                        trace_iter = trace_iter + 1;    
                        tuning_curves.raw.(curve_name)(i).ts{sub_stim}(trace_iter,:)            = lmr_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                        tuning_curves.raw.(curve_name)(i).x_pos_ts{sub_stim}(trace_iter,:)      = x_pos_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                        tuning_curves.raw.(curve_name)(i).voltage_ts{sub_stim}(trace_iter,:)    = volt_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                    end
                end
            end
            
            % Filtered data
            for sub_stim = 1:size(tuning_curves.raw.(curve_name)(i).ts,2)
                for trace = 1:size(tuning_curves.raw.(curve_name)(i).ts{sub_stim},1)
                    tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,:) = filter(B,A,tuning_curves.raw.(curve_name)(i).ts{sub_stim}(trace,:));
                end
            end
            
            % Offset corrected
            for sub_stim = 1:size(tuning_curves.raw.(curve_name)(i).ts,2)
                for trace = 1:size(tuning_curves.raw.(curve_name)(i).ts{sub_stim},1)
                    % What is up with the timing????
                    offset_amt = mean(tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,245:270));
                    tuning_curves.butter_offset.(curve_name)(i).ts{sub_stim}(trace,:) = tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,:) - offset_amt;
                    
                    offset_amt = mean(tuning_curves.raw.(curve_name)(i).ts{sub_stim}(trace,245:270));
                    tuning_curves.offset.(curve_name)(i).ts{sub_stim}(trace,:) = tuning_curves.raw.(curve_name)(i).ts{sub_stim}(trace,:) - offset_amt;                    
                end
            end
            
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
    
	
    nHigh = 4;
    nWide = 3;
    widthGap = .02;
    heightGap = .05;
    widthOffset = .15;
    heightOffset = .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    
    i = 1;    
    
    for cn = tuning_curves.names
                
        curve_name = cn{1};

        tuningFigHandle(1) = figure( 'name' ,curve_name,'NumberTitle','off',...
                                'Color',[1 1 1],'Position',[50 50 1024 684],...
                                'PaperOrientation','portrait');        
        
        for bar_pos = 1:3
            
            subplot('Position',sp_positions{1,bar_pos})
            
            graph.avg{i} = mean(tuning_curves.butter_offset.(curve_name)(i).ts{bar_pos});
            graph.variance{i} = std(tuning_curves.butter_offset.(curve_name)(i).ts{bar_pos});
            graph.color{i} =  my_colormap{i};
            tfPlot.timeseries(graph);
            axis([0 1000 -1.25 1.25])
            clear graph
            
            subplot('Position',sp_positions{2,bar_pos})
            plot(tuning_curves.raw.(curve_name)(i).x_pos_ts{bar_pos}');
            box off
            axis([0 1000 0 12])

            % Raw Data
            subplot('Position',sp_positions{3,bar_pos})
            plot(tuning_curves.raw.(curve_name)(i).ts{bar_pos}');
            hold on; box off
            mean_resp = nanmean(tuning_curves.raw.(curve_name)(i).ts{bar_pos});
            plot(mean_resp,'k','linewidth',3)           
            axis([0 1000 -6 6])
            
            % Smoothed and 'offset corrected' data
            subplot('Position',sp_positions{4,bar_pos})
            plot(tuning_curves.butter_offset.(curve_name)(i).ts{bar_pos}');
            mean_offset_resp = mean(tuning_curves.butter_offset.(curve_name)(i).ts{bar_pos});
            hold on; box off
            plot(mean_offset_resp,'k','linewidth',3)
            axis([0 1000 -4 4])
            
        end
        
        annotation('textbox','position',[ .3 .8 .2 .2],'string',curve_name,'interpreter','none','EdgeColor','none','fontsize',14);
        
        annotation('textbox','position',[.01 sp_positions{1,1}(2:end)],...
        'string',{'Smoothed','Adjusted LmR',' (Mean / std)'},'interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{2,1}(2:end)],...
        'string','X Pos','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{3,1}(2:end)],...
        'string','Raw LmR','interpreter','none','EdgeColor','none','fontsize',14);
        annotation('textbox','position',[.01 sp_positions{4,1}(2:end)],...
        'string',{'Smoothed',' Adjusted LmR'},'interpreter','none','EdgeColor','none','fontsize',14);
        
        export_fig(gcf,fullfile(data_location,filesep,[curve_name '_figure']),'-pdf') 

    end
end
