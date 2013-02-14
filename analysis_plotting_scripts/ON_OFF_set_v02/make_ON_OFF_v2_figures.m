% Script for making a figure for the unilateral flicker stimulus
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v02';
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

%% Use summary files to save specific subsets of data in tuning_curves.mat

if 01
    
    % Load in the summarized data if it isn't already done
    if ~exist('geno_data','var')

        addpath(genpath('/Users/stephenholtz/matlab-utils'))

        for g = 1:numel(geno_names)
            [summary_file,summary_filepath] = returnDirFileList(fullfile(data_location,geno_names{g}),'summary.mat');
            load(summary_filepath{:});

            geno_data{g} = tfAnalysis.ExpSet(eval(summary_file{1}(1:end-4))); %#ok<*AGROW>
        end
    end
    
    
    % Calculate normalization value per genotype
    for i = 1:numel(geno_names)
       mean_turning_resps(i) = geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end
    
    geno_norm_values = mean_turning_resps/mean(mean_turning_resps);
    
    [B,A]=butter(2,.05,'low');
    
    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:12
            % All of the individual tuning curves to be saved:
            if      condition_set_number == 1
                curve_name = 'ON_ON';
            elseif  condition_set_number == 2
                curve_name = 'ON_OFF';
            elseif  condition_set_number == 3
                curve_name = 'OFF_ON';
            elseif  condition_set_number == 4
                curve_name = 'OFF_OFF';
            elseif  condition_set_number == 5
                curve_name = 'on_off_edges_rear';
            elseif  condition_set_number == 6
                curve_name = 'on_off_edges_center';
            elseif  condition_set_number == 7
                curve_name = 'on_sweep';
            elseif  condition_set_number == 8
                curve_name = 'off_sweep';                
            elseif  condition_set_number == 9
                curve_name = 'on_expansion';
            elseif  condition_set_number == 10
                curve_name = 'off_expansion';
            elseif  condition_set_number == 11
                curve_name = 'on_sawtooth';
            elseif  condition_set_number == 12
                curve_name = 'off_sawtooth';
            end
            
            condition_numbers = geno_data{i}.grouped_conditions(condition_set_number).conds;
            
            % For each of these conditions will need to do things manually,
            % so only L-R timeseriesdata (normalized...) and X position data really
            % matter
            
            % L - R data normalized
            [avg_ts, variance_ts]                   = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i));
            tuning_curves.raw.(curve_name)(i).avg_ts    = avg_ts;
            tuning_curves.raw.(curve_name)(i).sem_ts    = variance_ts;
            
            [avg, variance]                         = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i));
            tuning_curves.raw.(curve_name)(i).avg       = avg;
            tuning_curves.raw.(curve_name)(i).sem       = variance;
            
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i));
            tuning_curves.raw.(curve_name)(i).all_ts            = avg_ts;
            
            % X position
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','yes','none',1);
            tuning_curves.raw.(curve_name)(i).all_x_avg_ts            = avg_ts;
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','no','all',geno_norm_values(i));
            tuning_curves.raw.(curve_name)(i).x_avg_ts            = avg_ts;
            
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'voltage_signal','none','no','none',1);
            tuning_curves.raw.(curve_name)(i).all_voltage_avg_ts            = avg_ts;
            
            tuning_curves.names{condition_set_number} = curve_name;
            try tuning_curves.raw.(curve_name)(i).speed = geno_data{i}.grouped_conditions(condition_set_number).speed; end
            try tuning_curves.raw.(curve_name)(i).bar_type = geno_data{i}.grouped_conditions(condition_set_number).bar_type; end
            
            if sum(strcmpi(curve_name,{'ON_ON','ON_OFF','OFF_ON','OFF_OFF'}))
                % L - R data normalized, aligned
                [lmr_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i));

                % X position
                [x_pos_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','yes','none',1);

                [volt_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'voltage_signal','none','no','none',1);

                buffer_amt = 20; % ms trimmed off of the end for shifting the responses to match each other

                shift_start_pos = 75; % all will be shifted to 'start' at x pos 270

                for sub_stim = 1:numel(lmr_ts)
                    
                trace_iter = 0;                    
                
                    for trace = 1:size(lmr_ts{sub_stim},1)

                        [~,flick_loc] = max(diff(x_pos_ts{sub_stim}(trace,70:100)));

                        shift_amt = flick_loc - 1 + 70 - shift_start_pos;
                        
                        % Something is wrong if the shift_amt is negative (i.e.
                        % the jump happened in a really strange place , or the
                        % sitmulus went to closed loop for some reason). Just
                        % ignore these.
                        if shift_amt < buffer_amt && shift_amt > 0

                            trace_iter = trace_iter + 1;    
                            tuning_curves.pruned.(curve_name)(i).ts{sub_stim}(trace_iter,:)            = lmr_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                            tuning_curves.pruned.(curve_name)(i).x_pos_ts{sub_stim}(trace_iter,:)      = x_pos_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                            tuning_curves.pruned.(curve_name)(i).voltage_ts{sub_stim}(trace_iter,:)    = volt_ts{sub_stim}(trace,(shift_amt:(end-buffer_amt+shift_amt)));
                        elseif shift_amt == 0
                            trace_iter = trace_iter + 1;
                            tuning_curves.pruned.(curve_name)(i).ts{sub_stim}(trace_iter,:)            = lmr_ts{sub_stim}(trace,1:(1+end-buffer_amt));
                            tuning_curves.pruned.(curve_name)(i).x_pos_ts{sub_stim}(trace_iter,:)      = x_pos_ts{sub_stim}(trace,1:(1+end-buffer_amt));
                            tuning_curves.pruned.(curve_name)(i).voltage_ts{sub_stim}(trace_iter,:)    = volt_ts{sub_stim}(trace,1:(1+end-buffer_amt));
                        end
                    end
                end
                
                % Filtered data
                for sub_stim = 1:size(tuning_curves.pruned.(curve_name)(i).ts,2)
                    for trace = 1:size(tuning_curves.pruned.(curve_name)(i).ts{sub_stim},1)
                        tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,:) = filter(B,A,tuning_curves.raw.(curve_name)(i).all_ts{sub_stim}(trace,:));
                    end
                    
                    tuning_curves.butter.(curve_name)(i).avg_ts{sub_stim} = mean(tuning_curves.butter.(curve_name)(i).ts{sub_stim});
                    tuning_curves.butter.(curve_name)(i).sem_ts{sub_stim} = std(tuning_curves.butter.(curve_name)(i).ts{sub_stim})/sqrt(size((tuning_curves.butter.(curve_name)(i).ts{sub_stim}),1));
                    
                end
                
                % Offset corrected
                for sub_stim = 1:size(tuning_curves.pruned.(curve_name)(i).ts,2)
                    for trace = 1:size(tuning_curves.pruned.(curve_name)(i).ts{sub_stim},1)

                        offset_amt = mean(tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,110:120));
                        tuning_curves.butter_offset.(curve_name)(i).ts{sub_stim}(trace,:) = tuning_curves.butter.(curve_name)(i).ts{sub_stim}(trace,:) - offset_amt;

                        offset_amt = mean(tuning_curves.pruned.(curve_name)(i).ts{sub_stim}(trace,245:270));
                        tuning_curves.offset.(curve_name)(i).ts{sub_stim}(trace,:) = tuning_curves.pruned.(curve_name)(i).ts{sub_stim}(trace,:) - offset_amt;                    
                    end
                    
                    tuning_curves.offset.(curve_name)(i).avg_ts{sub_stim}=mean(tuning_curves.offset.(curve_name)(i).ts{sub_stim});
                    tuning_curves.offset.(curve_name)(i).sem_ts{sub_stim}=std(tuning_curves.offset.(curve_name)(i).ts{sub_stim})./sqrt(size(tuning_curves.offset.(curve_name)(i).ts{sub_stim},1));
                    
                    tuning_curves.butter_offset.(curve_name)(i).avg_ts{sub_stim}=mean(tuning_curves.butter_offset.(curve_name)(i).ts{sub_stim});
                    tuning_curves.butter_offset.(curve_name)(i).sem_ts{sub_stim}=std(tuning_curves.butter_offset.(curve_name)(i).ts{sub_stim})./sqrt(size(tuning_curves.butter_offset.(curve_name)(i).ts{sub_stim},1));
                    
                end
            end
        end
    end
    
    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

%% Make a simple timseries matrix for the on and off minimal motion
if 0
    
    load(fullfile(data_location,'tuning_curves'));
    
    % Set up subplot dimensions
    nHigh = 4;
    nWide = 5;
    widthGap = .02;
    heightGap = .05;
    widthOffset = .1;
    heightOffset = .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map        = {[205 201 201]/255,[125 125 125]/255};
    height_iter     = 0;
    
    i = 1;
    tuningFigHandle(1) = figure( 'name' ,'Minimal Motion TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');

                        for cn = {'ON_ON','ON_OFF','OFF_ON','OFF_OFF'}
    
        curve_name = cn{1};
        height_iter = height_iter+1;
        
        for row = 1:5
            
            subplot('Position',sp_positions{height_iter,row})
            
            graph.avg{i}        = mean(tuning_curves.butter_offset.(curve_name)(i).ts{row});
            graph.variance{i}   = std(tuning_curves.butter_offset.(curve_name)(i).ts{row})/sqrt(3);
            graph.color{i}      = my_colormap{i};
            
            tfPlot.timeseries(graph);
            box off
            axis([0 500 -1.25 1.25])
            
            hold on
            plot((((tuning_curves.raw.(curve_name)(i).x_pos_ts{row})/14)-.01)')
        end
    end 
end

%% Make a simple timseries matrix for the on and off edges
if 0
    
    load(fullfile(data_location,'tuning_curves'));
    
    % Set up subplot dimensions
    nHigh = 8;
    nWide = 2;
    widthGap = .02;
    heightGap = .05;
    widthOffset = .1;
    heightOffset = .05;
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map        = {[205 201 201]/255,[125 125 125]/255};
    height_iter     = 0;
    
    i = 1;
    tuningFigHandle(1) = figure( 'name' ,'ON OFF Edges TS Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 1024 684],...
                            'PaperOrientation','portrait');
                        
    for cn =  {'on_off_edges_rear','on_off_edges_center','on_sweep','off_sweep','on_expansion','off_expansion','on_sawtooth','off_sawtooth'}
        curve_name = cn{1};
        height_iter = height_iter+1;
        
        for row = 1:2
            
            subplot('Position',sp_positions{height_iter,row})
            try            
            graph.avg{i}        = tuning_curves.raw.(curve_name)(i).avg_ts{row};
            graph.variance{i}   = tuning_curves.raw.(curve_name)(i).sem_ts{row};
            graph.color{i}      = my_colormap{i};
            
            tfPlot.timeseries(graph);
            plot((tuning_curves.raw.(curve_name)(i).x_avg_ts{row})/10)
            end
            box off
            %axis([0  -3.5 3.5])
            
            hold on
            
            %plot((tuning_curves.(curve_name)(i).all_ts{row})')
            
            
        end
        
    end 
end
