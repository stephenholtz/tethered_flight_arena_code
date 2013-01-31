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
            flick_off_point = geno_data{i}.grouped_conditions(condition_set_number).flick_time + 401;
            
            % L - R data normalized
            [avg, variance]                 = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i));
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i));
            
            tuning_curves.(curve_name)(i).avg               = cell2mat(avg);
            tuning_curves.(curve_name)(i).sem               = cell2mat(variance);
            tuning_curves.(curve_name)(i).avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).sem_ts            = variance_ts;
            
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i));

            tuning_curves.(curve_name)(i).all_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).all_sem_ts            = variance_ts;
            
            
            % L - R data not normalized (*_nn)            
            [avg_nn, variance_nn]                 = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',1);
            [avg_ts_nn, variance_ts_nn]           = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none','yes','all',1);
            
            tuning_curves.(curve_name)(i).avg_nn               = cell2mat(avg_nn);
            tuning_curves.(curve_name)(i).sem_nn               = cell2mat(variance_nn);
            tuning_curves.(curve_name)(i).avg_ts_nn            = avg_ts_nn;
            tuning_curves.(curve_name)(i).sem_ts_nn            = variance_ts_nn;
            
            % X position
            [avg, variance]                 = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','mean','yes','all',1);
            [avg_ts, variance_ts]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','yes','all',1);
            
            tuning_curves.(curve_name)(i).x_avg               = cell2mat(avg);
            tuning_curves.(curve_name)(i).x_sem               = cell2mat(variance);
            tuning_curves.(curve_name)(i).x_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).x_sem_ts            = variance_ts;            
            
            [avg_ts, ~]           = geno_data{i}.get_trial_data_set(condition_numbers,'x_pos','none','yes','none',1);
            tuning_curves.(curve_name)(i).all_x_avg_ts            = avg_ts;
            
            % All the stim data
            tuning_curves.(curve_name)(i).flick_time        = geno_data{i}.grouped_conditions(condition_set_number).flick_time;
            tuning_curves.(curve_name)(i).bar_width         = geno_data{i}.grouped_conditions(condition_set_number).bar_width;
            tuning_curves.(curve_name)(i).bar_len           = geno_data{i}.grouped_conditions(condition_set_number).bar_len;
            tuning_curves.(curve_name)(i).name              = geno_names{i};
            tuning_curves.(curve_name)(i).N                 = numel(geno_data{i}.experiment);
            
            % Get offset calculated portions
            [avg, variance]                 = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i),375:400,'median',301:1200);
            [avg_ts, variance_ts]           = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i),375:400,'median',301:1200);
            
            tuning_curves.(curve_name)(i).pre_flick_avg               = cell2mat(avg);
            tuning_curves.(curve_name)(i).pre_flick_sem               = cell2mat(variance);
            tuning_curves.(curve_name)(i).pre_flick_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).pre_flick_sem_ts            = variance_ts;
            
            % Get offset calculated portions
            [avg_ts, variance_ts]           = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','none','yes','none',geno_norm_values(i),381:400,'median',301:1200);
            
            tuning_curves.(curve_name)(i).all_pre_flick_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).all_pre_flick_sem_ts            = variance_ts;
            
            % Get offset calculated portions
            [avg, variance]                 = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','mean','yes','all',geno_norm_values(i),flick_off_point:(flick_off_point-20),'median',301:1200);
            [avg_ts, variance_ts]           = geno_data{i}.get_offset_calculated_turning_resps_set(condition_numbers,'lmr','none','yes','all',geno_norm_values(i),flick_off_point:(flick_off_point-20),'median',301:1200);
            
            tuning_curves.(curve_name)(i).post_flick_avg               = cell2mat(avg);
            tuning_curves.(curve_name)(i).post_flick_sem               = cell2mat(variance);
            tuning_curves.(curve_name)(i).post_flick_avg_ts            = avg_ts;
            tuning_curves.(curve_name)(i).post_flick_sem_ts            = variance_ts;
        end
        
    end
    
    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance avg_ts variance_ts
    
end

%% Make short figure for MR
if 1
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map = {[205 201 201]/255,[125 125 125]/255};

    tuningFigHandle(1) = figure(  'Name','Bar Flicker Summary Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 755 500],...
                            'PaperOrientation','portrait');
	
    nHigh = 4;
    nWide = 4;
    widthGap = .02;
    heightGap = .005;
    widthOffset = .1;
    heightOffset = .05;
    
    [B,A]=butter(2,.05,'low');
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    
    i = 1;
    curve_name = 'Off_shortflick_thickshort';

    % X positions
    for bar_pos = 1:4
        subplot('Position',sp_positions{1,bar_pos})
        x_poss = tuning_curves.(curve_name)(i).all_x_avg_ts{bar_pos}';
        plot(x_poss)
        hold on
        plot(max(x_poss'))
        
        subplot('Position',sp_positions{2,bar_pos})
        lmr = tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}';
        plot(lmr)
        hold on
        plot(lmr)
        plot(max(x_poss'))
        
        subplot('Position',sp_positions{3,bar_pos})
        lmr_f = filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}');
        plot(lmr_f)
        hold on
        plot(lmr_f)
        plot(max(x_poss'))
        
        subplot('Position',sp_positions{4,bar_pos})
        lmr_f = filter(B,A,tuning_curves.(curve_name)(i).all_avg_ts{bar_pos}');
        plot(lmr_f)
        hold on
        plot(max(x_poss'))
     end
     
end

%% Make a complete summary figure
if 0
    
    % Load in data (path in first cell of script)
    load(fullfile(data_location,'tuning_curves'));
    
    % Some meh colors
    my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};
    my_lr_colormap  = {[238 0 238]/255,[0 238 0]/255}; %,[0 178 238]/255};
    grey_map = {[205 201 201]/255,[125 125 125]/255};

    tuningFigHandle(1) = figure(  'Name','Bar Flicker Summary Figure','NumberTitle','off',...
                            'Color',[1 1 1],'Position',[50 50 755 500],...
                            'PaperOrientation','portrait');
	
    cond_nums = [3 8];
       
    nHigh = numel(cond_nums);
    nWide = 4;
    widthGap = .02;
    heightGap = .005;
    widthOffset = .1;
    heightOffset = .05;
    
    [B,A]=butter(2,.05,'low');
    
    % ph = @(X,N)((filter(B,A,tuning_curves.(X).all_avg_ts{N})'))
    
    sp_positions = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);    
    
    cond_iter = 0;
    
    for condition_set_number = cond_nums
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
        
        cond_iter = cond_iter +1;
        
        for bar_pos = 1:4
            sp(bar_pos + (4*cond_iter-1)) = subplot('Position',sp_positions{cond_iter,bar_pos});

%             graph.avg{1}        = (tuning_curves.(curve_name)(i).x_avg_ts{bar_pos}-1.25)/10;
%             graph.variance{1}   = zeros(numel(tuning_curves.(curve_name)(i).x_sem_ts{bar_pos}-1.25)/10,1);
%             graph.color{1}      = grey_map{1};
        
            for i = 1:numel(geno_names)
                
                stim_end = tuning_curves.(curve_name)(i).flick_time;
                graph.avg{i}        = filter(B,A,tuning_curves.(curve_name)(i).pre_flick_avg_ts{bar_pos});
                graph.variance{i}   = filter(B,A,tuning_curves.(curve_name)(i).pre_flick_sem_ts{bar_pos});
                graph.color{i}      = my_colormap{i};
                
                pre_responses{cond_iter}(1,bar_pos) = mean(graph.avg{i}(101:120));
                pre_responses{cond_iter}(2,bar_pos) = mean(graph.avg{i}(101:140));
                pre_responses{cond_iter}(3,bar_pos) = mean(graph.avg{i}(101:160));
                pre_responses{cond_iter}(4,bar_pos) = mean(graph.avg{i}(101:180));
                
%                 pre_mean_mean = mean(tuning_curves.(curve_name)(i).avg_ts{bar_pos}(1:400));
%                 graph.avg{i}        = pre_mean_mean-tuning_curves.(curve_name)(i).avg_ts{bar_pos}(400+(1:(stim_end+50)));
%                 pre_sem_mean = mean(tuning_curves.(curve_name)(i).sem_ts{bar_pos}(1:400));
%                 graph.variance{i}   = pre_sem_mean-tuning_curves.(curve_name)(i).sem_ts{bar_pos}(400+(1:(stim_end+50)));
%                 
%                 graph.color{i}      = my_colormap{i};
                
            end
            
            graph.avg{i+1}      = (tuning_curves.(curve_name)(i).x_avg_ts{bar_pos}(301:1200)-1.2)/10;
            graph.variance{i+1} = zeros(1,numel(graph.avg{i+1}));
            graph.color{i+1}    = grey_map{2};
            
            tfPlot.timeseries(graph);
            
            title(num2str(bar_pos))
            
            if bar_pos == 1
                axis on
            else
                axis off
            end
            box off
            axis([0 900 -1.5 1.5])
            %axis('tight')
        end
        
        clear graph  

    end
    
    cond_iter = 0;
    
    for condition_set_number = cond_nums        
        bar_pos = 1;
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
        
        cond_iter = cond_iter + 1;
        
        annotation('textbox','position',[0 sp_positions{cond_iter,bar_pos}(2:4)],...
                'string',{curve_name(1:13),curve_name(14:end)},'interpreter','none','EdgeColor','none','fontsize',11);
        
    end
	
    export_fig(gcf,fullfile(data_location,filesep,'summary_OFF_flicker_figure'),'-pdf') 

end


