% This will make a few figures from a few different experiment type sources
% and combine everything where there are overlapping experimental
% conditions. The summary file generated from this should have all of the
% data necessary for making figures.

% I do not recommend trying to use this as example code.

deg = char(176);
extendd = @(in,ext)([in(1) in(2) in(3)*ext in(4)]);
addpath(genpath('/Users/stephenholtz/matlab-utils'))

% Locations for all of the experiment groupings
data_location       = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_final_set/ON_OFF_set_v06_MIXED';
summary_location    = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v06_figures';

% Names of all the folders with the different experiments
% [34C] ShiTS
num = 1; geno_folder_names{num} = 'shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';       colormap_ind{num} = 1;    proper_geno_names{num} = 'L1 (48a08AD;66A01DBD)/ShiTS';
num = 2; geno_folder_names{num} = 'shift_gmr_48a08ad_kitamoto_shibire';                colormap_ind{num} = 2;    proper_geno_names{num} = 'Ctrl (48a08AD;+)/ShiTS';
num = 3; geno_folder_names{num} = 'shift_ok371_vp16_ad_ort_c1_3_dbd_kitamoto_shibire'; colormap_ind{num} = 1;    proper_geno_names{num} = 'L1 (ok371vp16AD;ortC1-3DBD)/ShiTS';
num = 4; geno_folder_names{num} = 'shift_L1_c202a_kitamoto_shibire';                   colormap_ind{num} = 2;    proper_geno_names{num} = 'L1 (c202a)/ShiTS';
num = 5; geno_folder_names{num} = 'shift_iso_d1_kitamoto_shibire';                     colormap_ind{num} = 3;    proper_geno_names{num} = 'Ctrl (Iso-D1)/ShiTS';

% [34C] ShiTS DIM
num = 6; geno_folder_names{num} = 'dim_shift_gmr_48a08ad_66a01dbd_kitamoto_shibire';   colormap_ind{num} = 4;    proper_geno_names{num} = '(low cont) L1 (48a08AD;66A01DBD)/ShiTS';
num = 7; geno_folder_names{num} = 'dim_shift_gmr_48a08ad_kitamoto_shibire';            colormap_ind{num} = 5;    proper_geno_names{num} = '(low cont) Ctrl (48a08AD;+)/ShiTS';
num = 8; geno_folder_names{num} = 'dim_shift_ok371vp16ad_ortc3dbd_kitamoto_shibire';   colormap_ind{num} = 4;    proper_geno_names{num} = '(low cont) L1 (ok371vp16AD;ortC1-3DBD)/ShiTS';
num = 9; geno_folder_names{num} = 'dim_shift_L1_c202a_kitamoto_shibire';               colormap_ind{num} = 5;    proper_geno_names{num} = '(low cont) L1 (c202a)/ShiTS';
num = 10; geno_folder_names{num} = 'dim_shift_iso_d1_kitamoto_shibire';                colormap_ind{num} = 6;    proper_geno_names{num} = '(low cont) Ctrl (Iso-D1)/ShiTS';

% [25C] Kir2.1
num = 11; geno_folder_names{num} = 'gmr_48a08ad_66a01dbd_gal80ts_kir21';               colormap_ind{num} = 1;    proper_geno_names{num} = 'L1 (48a08AD;66A01DBD)/Kir2.1';
num = 12; geno_folder_names{num} = 'gmr_48a08ad_gal80ts_kir21';                        colormap_ind{num} = 2;    proper_geno_names{num} = 'Ctrl (48a08AD;+)/Kir2.1';

% [25C] Kir2.1 DIM
num = 13; geno_folder_names{num} = 'dim_combined_gmr_48a08ad_66a01dbd_gal80ts_kir21';  colormap_ind{num} = 4;    proper_geno_names{num} = '(low cont) L1 (48a08AD;66A01DBD)/Kir2.1';
num = 14; geno_folder_names{num} = 'dim_gmr_48a08ad_gal80ts_kir21';                    colormap_ind{num} = 5;    proper_geno_names{num} = '(low cont) Ctrl (48a08AD;+)/Kir2.1';
num = 15; geno_folder_names{num} = 'dim_retest_gmr_48a08ad_66a01dbd_gal80ts_kir21';    colormap_ind{num} = 4;    proper_geno_names{num} = '(low cont) L1 (48a08AD;66A01DBD)/Kir2.1';

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
combined_figure                 = 0;

optomotor_tune_figure           = 0;
sawtooth_expansion_tune_figure  = 0;
optomotor_ts_figure             = 0;
sawtooth_expansion_ts_figure    = 0;

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
    
    % Calculate normalization value per genotype
    for i = numel(geno_folder_names)
       mean_turning_resps(i) = 1;%geno_data{i}.exp_set_turning_resp; %#ok<*SAGROW>
    end
    
    [B,A] = butter(2,.0695,'low');
    
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
                
                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','trapz',flip,'all',geno_norm_values(i));
                
                summ_data.(curve_name).(['raw' symmetry])(i).avg_lmr = a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_lmr = v;
                
                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'all',geno_norm_values(i));
                
                for c = 1:size(a,2)
                for r = 1:size(a,1)
                for t = 1:size(a{r,c},1)
                    temp_a{r,c}(t,:) = filter(B,A,a{r,c}(t,:));
                    temp_v{r,c}(t,:) = filter(B,A,v{r,c}(t,:));
                end
                end
                end
                
                summ_data.(curve_name).(['raw' symmetry])(i).avg_lmr_ts = temp_a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_lmr_ts = temp_v;
                clear temp_*
                
                [a, v] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'exp',geno_norm_values(i));
                
                for c = 1:size(a,2)
                for r = 1:size(a,1)
                for t = 1:size(a{r,c},1)
                    temp_a{r,c}(t,:) = filter(B,A,a{r,c}(t,:));
                    temp_v{r,c}(t,:) = filter(B,A,v{r,c}(t,:));
                end
                end
                end
                
                summ_data.(curve_name).(['raw' symmetry])(i).avg_per_fly_lmr_ts = temp_a;
                summ_data.(curve_name).(['raw' symmetry])(i).sem_per_fly_lmr_ts = temp_v;
                clear temp_*
                
                [a, ~] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','none',flip,'none',geno_norm_values(i));
                
                for c = 1:size(a,2)
                for r = 1:size(a,1)
                for t = 1:size(a{r,c},1)
                    temp_a{r,c}(t,:) = filter(B,A,a{r,c}(t,:));
                end
                end
                end
                
                summ_data.(curve_name).(['raw' symmetry])(i).all_lmr_ts = temp_a;
                clear temp_*
                
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

% Load in the data
if ~exist('summ_data','var')
    load(fullfile(summary_location,'summ_data'));
end

% Figure out when the ON rotation starts turning and doesn't turn back
% (make an NaN if the fly turns back..)
curve_name = 'sawtooth_ON';
thresh = .33;

offset = 1000;

for geno_ind = 1:numel(geno_folder_names)
    avg_curr_ts_set = cell2mat(summ_data.(curve_name).raw(geno_ind).avg_lmr_ts);
    
    avg_integ_resp = cumsum(avg_curr_ts_set(offset+1:end));
    thresh_val(geno_ind) = avg_integ_resp(end)*thresh;
end
thresh_val = mean(thresh_val);

for geno_ind = 1:numel(geno_folder_names)

    curr_ts_set = cell2mat(summ_data.(curve_name).raw(geno_ind).avg_per_fly_lmr_ts);
    avg_curr_ts_set = cell2mat(summ_data.(curve_name).raw(geno_ind).avg_lmr_ts);
    
    avg_integ_resp = cumsum(avg_curr_ts_set(offset+1:end));
    %thresh_val = avg_integ_resp(end)*thresh;
    
    fly_thresh_pts = [];
    
    for exp = 1:size(curr_ts_set,1)
        curr_ts_set(exp,:) = curr_ts_set(exp,:)-mean(curr_ts_set(exp,1:50));
        
        integ_resps(exp,:) = cumsum(curr_ts_set(exp,offset+1:end));
        
        above_thresh_logical = integ_resps(exp,:) > thresh_val;
        
        potential_thresh_pts = min(find(above_thresh_logical==1));
        
        if isempty(potential_thresh_pts)
            fly_thresh_pts(exp,:) = 3000;
        else
            fly_thresh_pts(exp,:) = potential_thresh_pts(end) + (offset-1);
        end
        
        %disp(potential_thresh_pts)
        
    end
    
    summ_data.sawtooth_ON.raw(geno_ind).avg_integ_resp = avg_integ_resp;
    for ii = 1:size(integ_resps,1)
        prepended_integ_responses(ii,:) = [0*ones(1,offset) integ_resps(ii,:)];
    end
    
    summ_data.sawtooth_ON.raw(geno_ind).integ_resp = prepended_integ_responses;
    summ_data.sawtooth_ON.raw(geno_ind).all_turning_thresh_times = fly_thresh_pts;
    summ_data.sawtooth_ON.raw(geno_ind).mean_turning_thresh_times = nanmean(fly_thresh_pts);
    summ_data.sawtooth_ON.raw(geno_ind).sem_turning_thresh_times = nanstd(fly_thresh_pts)./sqrt(numel(fly_thresh_pts));
    
    clear fly_thresh_pts integ_resp avg_total_turn avg_integ_resp curr_ts_set exp
    
end


% Use a normalized threshold and integration to try and find the data's
% time to turn

thresh = .33;
for geno_ind = 1:numel(geno_folder_names)

    curr_ts_set = cell2mat(summ_data.(curve_name).raw(geno_ind).avg_per_fly_lmr_ts);
    integ_thresh_pts = [];
    
    for exp = 1:size(curr_ts_set,1)
        exp_ts = curr_ts_set(exp,500:end);
        
        [max_val,max_ind] = max(exp_ts);
        
        max_ind = max_ind(end);
        
        exp_resp_sum = sum(exp_ts(1:max_ind));
        
        found_thresh = 0;
        
        integ_thresh_pts(exp) = NaN;

        thresh_cross_val = inf;
        
        for i = 1:numel(exp_ts)
            
            if abs((thresh*max_val)-exp_ts(i)) < thresh_cross_val && i < max_ind && i > 1200
                thresh_cross_val = abs((thresh*max_val)-exp_ts(i));
                integ_thresh_pts(exp) = i + 500;
            end
        end
        
    end
    
    summ_data.sawtooth_ON.raw(geno_ind).integ_thresh_time = integ_thresh_pts;
    summ_data.sawtooth_ON.raw(geno_ind).mean_integ_thresh_time = nanmean(integ_thresh_pts);
    summ_data.sawtooth_ON.raw(geno_ind).sem_integ_thresh_time = nanstd(integ_thresh_pts)/sqrt(numel(integ_thresh_pts));
    clear integ_thresh_pts running_sum exp_ts
    
end

% Do ON-expansion analysis as well (shift to the first 3 bumps and then see
% what the response peaks are within then)

% all of the inds that correspond to a step in the stimulus (ms), based
% on the median responses... seems to align well in 95% of the cases
% where I actually have x_position data...
%expansion_inds = [25 363 701 1039 1376 1713 2051 2388 2726];
expansion_inds = [25 375 350 700 675 1025];
tsm = @(ts,inds)(ts(inds)-mean(ts(inds(1)-20:inds(1)-1)));

%%%%%%h1=figure;
%%%%%%h2=figure;
for geno_ind = 1:numel(geno_folder_names)

    curr_ts_set = cell2mat(summ_data.expansion_ON.raw(geno_ind).avg_per_fly_lmr_ts);
    mean_aligned_responses = [];
    for exp = 1:size(curr_ts_set,1)

        % I will only use the first few bumps in the respones
        aligned_responses = [];
        
        aligned_responses(1,:) = tsm(curr_ts_set(exp,:),expansion_inds(1):(expansion_inds(2)));
        aligned_responses(2,:) = tsm(curr_ts_set(exp,:),expansion_inds(3):(expansion_inds(4)));
        aligned_responses(3,:) = tsm(curr_ts_set(exp,:),expansion_inds(5):(expansion_inds(6)));

        aligned_responses_no_offset_red(1,:) = curr_ts_set(exp,expansion_inds(1):(expansion_inds(2)));
        aligned_responses_no_offset_red(2,:) = curr_ts_set(exp,expansion_inds(3):(expansion_inds(4)));
        aligned_responses_no_offset_red(3,:) = curr_ts_set(exp,expansion_inds(5):(expansion_inds(6)));

        if 0
        
        figure(h1); clf
        for uu = 1:3
            subplot(1,3,uu)
            plot(aligned_responses(uu,:)); hold all
            plot(aligned_responses_no_offset_red(uu,:));
            
        end
        
        figure(h2); clf
        plot(summ_data.expansion_ON.raw(geno_ind).avg_lmr_ts{1});hold all;
        plot(curr_ts_set(exp,:));
        plot(25:375,mean(aligned_responses))
        title(proper_geno_names{geno_ind})
                
        pause() 
        
        end
        %
%         clf
%         subplot(1,2,1)
%         plot(curr_ts_set)
%         subplot(1,2,2)
%         
%         plot(aligned_responses')
%         hold all
%         plot(mean(aligned_responses))
%         title(proper_geno_names{geno_ind})
%         pause()
%         clf
        
        mean_aligned_responses(exp,:) = mean(aligned_responses);
    end
    
    summ_data.expansion_ON.raw(geno_ind).all_mean_aligned_subresponse_ts = (mean_aligned_responses);
    summ_data.expansion_ON.raw(geno_ind).mean_aligned_subresponse_ts = 	mean(mean_aligned_responses); 
    summ_data.expansion_ON.raw(geno_ind).sem_aligned_subresponse_ts = std(mean_aligned_responses)/sqrt(size(mean_aligned_responses,1));
    
    summ_data.expansion_ON.raw(geno_ind).mean_aligned_subresponse = trapz(summ_data.expansion_ON.raw(geno_ind).mean_aligned_subresponse_ts);
    summ_data.expansion_ON.raw(geno_ind).sem_aligned_subresponse = std(trapz(summ_data.expansion_ON.raw(geno_ind).all_mean_aligned_subresponse_ts,2))/sqrt(size(summ_data.expansion_ON.raw(geno_ind).all_mean_aligned_subresponse_ts,1));
    
    clear aligned_responses mean_aligned_responses
end

% Do stats on the data
if 1
    
    % hard coded comparisons... oh well
    comparison_groups{1} = [11 12]; comp_kind{1} = 'ctrl';
    comparison_groups{2} = [11 13]; comp_kind{2} = 'dim';
    comparison_groups{3} = [13 14]; comp_kind{3} = 'ctrl';
    comparison_groups{4} = [1 2];   comp_kind{4} = 'ctrl';
    comparison_groups{5} = [1 6];   comp_kind{5} = 'dim';
    comparison_groups{6} = [6 7];   comp_kind{6} = 'ctrl';
    comparison_groups{7} = [3 5];   comp_kind{7} = 'ctrl';
    comparison_groups{8} = [3 8];   comp_kind{8} = 'dim';
    comparison_groups{9} = [4 5];   comp_kind{9} = 'ctrl';
    comparison_groups{10} = [4 9];  comp_kind{10} = 'dim';
    comparison_groups{11} = [8 10]; comp_kind{11} = 'ctrl';
    comparison_groups{12} = [9 10]; comp_kind{12} = 'ctrl';
    
    for curve_name_ind = [3 4 9 10 11 12 13 14]

        for i = 1:numel(comparison_groups)

            for k = 1:numel(summ_data.(curve_names{curve_name_ind}).raw(comparison_groups{i}(1)).avg_per_fly_lmr_ts)

                s1 = summ_data.(curve_names{curve_name_ind}).raw(comparison_groups{i}(1)).avg_per_fly_lmr_ts{k};
                s2 = summ_data.(curve_names{curve_name_ind}).raw(comparison_groups{i}(2)).avg_per_fly_lmr_ts{k};

                [h, p] = ttest2(mean(s1,2),mean(s2,2));

                summ_data.(curve_names{curve_name_ind}).stats(i).comp_names = [proper_geno_names{comparison_groups{i}(1)} ' v ' proper_geno_names{comparison_groups{i}(2)}];
                summ_data.(curve_names{curve_name_ind}).stats(i).comp_kind = comp_kind{i};
                summ_data.(curve_names{curve_name_ind}).stats(i).h(k) = h;
                summ_data.(curve_names{curve_name_ind}).stats(i).p(k) = p;

                [h, p] = ttest2(mean(s2,2),mean(s1,1));

                summ_data.(curve_names{curve_name_ind}).stats2(i).comp_names = [proper_geno_names{comparison_groups{i}(2)} ' v ' proper_geno_names{comparison_groups{i}(1)}];
                summ_data.(curve_names{curve_name_ind}).stats2(i).comp_kind = comp_kind{i};
                summ_data.(curve_names{curve_name_ind}).stats2(i).h(k) = h;
                summ_data.(curve_names{curve_name_ind}).stats2(i).p(k) = p;
                
            end
            
            % expansion_ON
            s1 = summ_data.expansion_ON.raw(comparison_groups{i}(1)).all_mean_aligned_subresponse_ts;
            s2 = summ_data.expansion_ON.raw(comparison_groups{i}(2)).all_mean_aligned_subresponse_ts;
            
            [h,p] = ttest2(mean(s1,2),mean(s2,2));
            
            summ_data.expansion_ON.s_stats(i).comp_names = [proper_geno_names{comparison_groups{i}(1)} ' v ' proper_geno_names{comparison_groups{i}(2)}];
            summ_data.expansion_ON.s_stats(i).comp_kind = comp_kind{i};
            summ_data.expansion_ON.s_stats(i).h(1) = h;
            summ_data.expansion_ON.s_stats(i).p(1) = p;
            
            % sawtooth_ON
            s1 = summ_data.sawtooth_ON.raw(comparison_groups{i}(1)).all_turning_thresh_times;
            s2 = summ_data.sawtooth_ON.raw(comparison_groups{i}(2)).all_turning_thresh_times;
            
            [h,p] = ttest2(s1,s2);
            
            summ_data.sawtooth_ON.s_stats(i).comp_names = [proper_geno_names{comparison_groups{i}(1)} ' v ' proper_geno_names{comparison_groups{i}(2)}];
            summ_data.sawtooth_ON.s_stats(i).comp_kind = comp_kind{i};
            summ_data.sawtooth_ON.s_stats(i).h(1) = h;
            summ_data.sawtooth_ON.s_stats(i).p(1) = p;
            
            
        end
    end

end

% Make the figures
for plotting_group = [6 7 8]
    
    if plotting_group == 1
        % ShiTS regular
        geno_inds_to_plot = 1:5;
        isdim = 0;
        graph_name = 'ShiTS';
    elseif plotting_group == 2
        % ShiTS dim
        geno_inds_to_plot = 6:10;
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
    elseif plotting_group == 6
        
        geno_inds_to_plot = [1 2 6 7];
        isdim = 2;
        graph_name = {['New L1 Driver > Shibire^T^S (34C' deg '), Multiple Closed-Loop Fixation Contrasts']};
        fig_file_name = 'new_L1_drivers_shibire';
    elseif plotting_group == 7
        
        geno_inds_to_plot = [3 4 5 8 9 10];
        isdim = 2;
        graph_name = {['Literature L1 Drivers > Shibire^T^S (34C' deg '),  Multiple Closed-Loop Fixation Contrasts']};
        fig_file_name = 'lit_L1_drivers_shibire';
    elseif plotting_group == 8
        
        geno_inds_to_plot = [11 12 13 14];
        isdim = 2;
        graph_name = {['New L1 Drivers > Kir2.1 (24C' deg '),  Multiple Closed-Loop Fixation Contrasts']};
        fig_file_name = 'new_L1_drivers_kir';
    end
    
    figure_color = [1 1 1];
    font_color = [0 0 0];
    axis_color = figure_color;
    zero_line_color = font_color;
    xy_color = [0 0 0];
    grid = 'off';
    fig_name_prefix = '';
    font_size_1 = 7;
    font_size_2 = 8;
    
    dim = .4;

%     my_bright_colormap  = {[235 225 2]/255,[30 144 255]/255,[255 5 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255,[0 0 210]/255};
%     my_dim_colormap     = {dim*[235 225 2]/255,dim*[30 144 255]/255,dim*[255 5 0]/255,dim*[238 0 238]/255,dim*[0 238 0]/255,dim*[255 44 44]/255,dim*[0 0 210]/255};
% 
%     my_colormap = [my_bright_colormap my_dim_colormap];

    my_bright_colormap= {[40 154 255]/255,[248 0 248]/255,[0 238 0]/255};
    my_dim_colormap     = {dim*[40 154 255]/255,dim*[248 0 248]/255,dim*[0 238 0]/255};

    my_colormap = [my_bright_colormap my_dim_colormap];

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
        graph.zero_line = 0;
        makeErrorbarTuningCurve(graph);

        title({curve_name,graph_name},'interpreter','none')
        ylabel({'Integrated \DeltaWBA'},'color',font_color)
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
                %graph.shade{i}  = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts{speed});

                graph.color{i}  = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

            end

            graph.zero_line_color = [.27 .27 .27];

            makeErrorShadedTimeseries(graph);

            title({curve_name,graph_name},'interpreter','none')
            ylabel({'Mean L-R',' WBA (V*s)'},'color',font_color)
            xlabel('Temporal Frequency','color',font_color)        
            graph.zero_line = 1;
            if plot_iter == 3
                legend_hand = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
                %set(legend_hand,'location','Best')
            end
            
            axis([0 2500 -1.5 3.5])
            
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
                    graph.shade{i}      = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr);
                    
                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

                end
                
                graph.zero_line_color = [.27 .27 .27];
                graph.zero_line = 0;
                makeErrorbarTuningCurve(graph,.5+(1:numel(geno_inds_to_plot))/10);

                %title({curve_name,graph_name},'interpreter','none')
                ylabel({'Integrated \DeltaWBA'},'color',font_color)
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
                    %graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts);
                    
                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};
                    
                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;

                end
                
                graph.zero_line_color = [.27 .27 .27];
                graph.zero_line = 1;
                makeErrorShadedTimeseries(graph);
                
                title({curve_name,graph_name},'interpreter','none')
                ylabel({'Mean L-R',' WBA (V)'},'color',font_color)
                axis([0 3000 -1 3])
                
                if plot_iter == 4
                    [legend_hand] = add_legend_with_N(names_plotted,n_for_names_plotted,'NorthEastOutside');
                    set(legend_hand,'Position',[.75 .2 .2 .6])
                end
                
                clear graph names_plotted n_for_names_plotted
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nudge = @(pos,x_dir,y_dir)([pos(1)+x_dir pos(2)+y_dir pos(3) pos(4)]);
    ff = @(hand)(ff(hand));
    combined_figure_handle(plotting_group) = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 590 285],...
                                    'PaperOrientation','portrait');    
    
    % Set up subplot dimensions
    nHigh       = 3;
    nWide       = 4;
    widthGap    = .0625;
    heightGap   = .1;
    widthOffset = .1;
    heightOffset= .085;
    
    sp_positions_1 = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    % Set up subplot dimensions
    nHigh       = 3;
    nWide       = 4;
    widthGap    = .0725;
    heightGap   = .1;
    widthOffset = .16;
    heightOffset= .085;

    sp_positions_2 = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
        
    % Set up subplot dimensions
    nHigh       = 3;
    nWide       = 7;
    widthGap    = .05;
    heightGap   = .1;
    widthOffset = .18;
    heightOffset= .085;

    sp_positions_mid_bot = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);

    % Set up subplot dimensions
    nHigh       = 3;
    nWide       = 5;
    widthGap    = .1;
    heightGap   = .1;
    widthOffset = -.412;
    heightOffset= .085;

    sp_positions_right = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    text_offset = .03;
    
    handles_iter = 1;
    
    clear graph names_plotted n_for_names_plotted
    
    annotation('Textbox','Position',[text_offset+.075 .775 .8 .167],'String',graph_name,'Edgecolor','none','fontsize',font_size_2)
    
    % Plot the optomotor stimuli timeseries
        curve_name = 'lam_30_rotation';

        deg = char(176);
        annotation('Textbox','Position',[text_offset sp_positions_1{1,1}(2:4)],'String',{'Rotation',['  \lambda = 30' deg]},'Edgecolor','none','fontsize',font_size_1)
    
        for speed = 1:3

                subplot('Position',sp_positions_1{1,speed})
                if speed == 2 || speed == 3
                    subplot('Position',nudge(sp_positions_1{1,speed},-.025,0))
                elseif  speed == 1
                    subplot('Position',nudge(sp_positions_1{1,speed},-.015,0))
                end

                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i} 	= (summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{speed});
                    %graph.shade{i}  = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts{speed});

                    graph.color{i}  = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
                    
                end
                
                graph.zero_line_color = [.27 .27 .27];
                
                makeErrorShadedTimeseries(graph);
                
                axis([0 2250 -.5 4])
                
                if speed == 1
                    ylabel('\DeltaWBA (V)','color',font_color,'fontsize',font_size_1)
                    %xlabel('Time (ms)','color',font_color,'fontsize',font_size_1)
                    title('F_t = .5 Hz','fontsize',font_size_1)
                    
                    set(gca,'XTick',[0 2250],'XTickLabel',{'0','2.25(s)'},'fontsize',font_size_1)
                elseif speed == 2
                    title('F_t = 1.5 Hz','fontsize',font_size_1)
                    set(gca,'XTick',[0 2250])
                    axis off
                elseif speed == 3
                    title('F_t = 9 Hz','fontsize',font_size_1)
                    set(gca,'XTick',[0 2250])
                    axis off
                end
                
        end
        
        clear graph names_plotted n_for_names_plotted
        
    % Plot the optomotor stimuli tuning curve
        
        subplot('Position',nudge(sp_positions_2{1,4},-.05,0))
    
        curve_name = 'lam_30_rotation';
        graph.zero_line = 0;
        graph.zero_line_color = [.27 .27 .27];
        
        plot(-10:10,zeros(21,1),'Color',graph.zero_line_color,'LineWidth',1)
        hold on
        
        % Just make a tuning curve with the correct color
        for i = 1:numel(geno_inds_to_plot)
            graph.line{i}   = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr);
            graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr);
            
            graph.color{i}  = my_colormap{colormap_ind{geno_inds_to_plot(i)}};
            
            names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
            n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
            
        end
        
        makeErrorbarTuningCurve(graph);
        
        axis([.8 3.2 -1000 7000])
        
        box off
        set(gca,'YAxisLocation','right')
        set(gca,'YTick',[0 2000 4000 6000],'YTickLabel',{'0','2','4','6'},'fontsize',font_size_1)
        set(gca,'XTickLabel',{'.5','1.5','9'},'fontsize',font_size_1)
        ylabel({'Integrated \Delta WBA'},'color',font_color,'fontsize',font_size_1)
        xlabel('F_t (Hz)','color',font_color,'fontsize',font_size_1)        
        fix_errorbar_tee_width(3.85)
        
        clear graph names_plotted n_for_names_plotted p_for_plotted
        
    % Plot the ON Sawtooth timeseries
        annotation('Textbox','Position',[text_offset sp_positions_1{2,1}(2:4)],'String',{'   ON-','Rotation'},'Edgecolor','none','fontsize',font_size_1)
        annotation('Textbox','Position',[text_offset sp_positions_1{3,1}(2:4)],'String',{'   ON-','Expansion'},'Edgecolor','none','fontsize',font_size_1)

        for pos_loc = 2:3
                        
            subplot('Position',nudge(sp_positions_1{pos_loc,1},-.015,0))
            
            if pos_loc == 2
                curve_name = 'sawtooth_ON';
            elseif pos_loc == 3
                curve_name = 'expansion_ON';
            end
                            
                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i}       = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts);
                    %graph.shade{i}  = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr_ts);
                    
                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
                    
                end
                
                graph.zero_line_color = [.27 .27 .27];
                
                makeErrorShadedTimeseries(graph);
                
                %xlabel('Time (ms)','color',font_color,'fontsize',font_size_1) 
                ylabel('\DeltaWBA (V)','color',font_color,'fontsize',font_size_1)
                axis([0 3000 -.5 2])
                set(gca,'XTick',[0 3000],'XTickLabel',{'0','3(s)'},'fontsize',font_size_1)                
                clear graph names_plotted n_for_names_plotted p_for_plotted
        end
        
    % Plot the On Sawtooth + Expansion Tuning curve

        for pos_loc = 2:3
            
            if pos_loc == 2
                curve_name = 'sawtooth_ON';
            elseif pos_loc == 3
                curve_name = 'expansion_ON';
            end
            
            subplot('Position',extendd(sp_positions_mid_bot{pos_loc,2},1.2))

            
            if pos_loc == 3 && 1
                clear graph
                
                curve_name = 'expansion_ON';            

                graph.zero_line = 0;
                graph.zero_line_color = [.27 .27 .27];

                plot(-1000:1000,zeros(2001,1),'Color',graph.zero_line_color,'LineWidth',1)
                hold on

                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i}       = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).mean_aligned_subresponse_ts);
                    %graph.shade{i}      = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_aligned_subresponse);

                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
                    color_for_names_plotted{i} = graph.color{i};

                end

                makeErrorShadedTimeseries(graph);

                box off
                axis([-15 350 -.1 .4])
                set(gca,'YAxisLocation','right')
                set(gca,'YTick',[0 .2 .4],'YTickLabel',{'0','.2','.4'},'fontsize',font_size_1)
                set(gca,'XTick',[0 340],'XTickLabel',{'0','0.34(s)'},'fontsize',font_size_1)
                ylabel({'Aligned Mean \DeltaWBA','Subresponses (V)'},'color',font_color,'fontsize',font_size_1)
                

            else
                
                graph.zero_line = 0;
                graph.zero_line_color = [.27 .27 .27];

                plot(-10:10,zeros(21,1),'Color',graph.zero_line_color,'LineWidth',1)
                hold on

                % Just make a tuning curve with the correct color
                for i = 1:numel(geno_inds_to_plot)
                    graph.line{i}       = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr);
                    graph.shade{i}      = cell2mat(summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_lmr);

                    graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

                    names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
                    n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
                    color_for_names_plotted{i} = graph.color{i};

                end

                graph.zero_line_color = [.27 .27 .27];

                x_distrib=.5+(1:numel(geno_inds_to_plot))/10;

                makeErrorbarTuningCurve(graph,1:numel(geno_inds_to_plot));

                box off

                set(gca,'XTickLabel',{''},'XTick',0,'fontsize',font_size_1)
                set(gca,'YTick',[0 1500 3000],'YTickLabel',{'0','1.5','3'},'fontsize',font_size_1)
                set(gca,'YAxisLocation','right')
                ylabel({'Integrated',' \DeltaWBA (V*s)'},'color',font_color,'fontsize',font_size_1)            
                axis([-1 2+numel(geno_inds_to_plot) -500 3200])
                fix_errorbar_tee_width(7)
                
                clear graph
            end
        end

    % Plot the On Sawtooth response-thing curve
    
    subplot('Position',extendd(nudge(sp_positions_mid_bot{2,3},0.028,0),1.2))
    
        curve_name = 'sawtooth_ON';            

        graph.zero_line = 0;
        graph.zero_line_color = [.27 .27 .27];

        plot(-10:10,zeros(21,1),'Color',graph.zero_line_color,'LineWidth',1)
        hold on

        % Just make a tuning curve with the correct color
        for i = 1:numel(geno_inds_to_plot)
            graph.line{i}       = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).mean_turning_thresh_times);
            graph.shade{i}      = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_turning_thresh_times);

            graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

            names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
            n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
            color_for_names_plotted{i} = graph.color{i};
            
        end

        makeErrorbarTuningCurve(graph,1:numel(geno_inds_to_plot));
        
        box off
        set(gca,'YAxisLocation','right')
        set(gca,'XTickLabel',{''},'XTick',0,'fontsize',font_size_1)
        set(gca,'YTick',[1500 2000 2500 3000],'YTickLabel',{'1.5','2.0','2.5','3.0'},'fontsize',font_size_1)
        ylabel({'Time of Response',' Start (s)'},'color',font_color,'fontsize',font_size_1)
        axis([-1 2+numel(geno_inds_to_plot) 1500 3000])
        fix_errorbar_tee_width(7)
        
        clear graph
        
    % Plot the On expansion response-thing curve
    
    if 1
        subplot('Position',extendd(nudge(sp_positions_mid_bot{3,3},0.028,0),1.2))
    
        curve_name = 'expansion_ON';            

        graph.zero_line = 0;
        graph.zero_line_color = [.27 .27 .27];

        plot(-1000:1000,zeros(2001,1),'Color',graph.zero_line_color,'LineWidth',1)
        hold on
        
        % Just make a tuning curve with the correct color
        for i = 1:numel(geno_inds_to_plot)
            graph.line{i}       = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).mean_aligned_subresponse);
            graph.shade{i}      = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_aligned_subresponse);

            graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

            names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
            n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
            color_for_names_plotted{i} = graph.color{i};
            
        end
        
        %makeErrorShadedTimeseries(graph);
        
        %makeErrorbarTuningCurve(graph,.5+(1:numel(geno_inds_to_plot))/10);
        makeErrorbarTuningCurve(graph,1:numel(geno_inds_to_plot));
        
        box off
        set(gca,'YAxisLocation','right')
        set(gca,'XTickLabel',{''},'XTick',0,'fontsize',font_size_1)        
        set(gca,'YTick',[0 50 100],'YTickLabel',{'0','.05','.1'},'fontsize',font_size_1)        
        %set(gca,'XTick',[-5 340],'XTickLabel',{'0','0.34(s)'},'fontsize',font_size_1)
        ylabel({'Integrated \DeltaWBA','Subresponses (V*s)'},'color',font_color,'fontsize',font_size_1)
        %axis([0 338 -.2 .5])
        %axis([.25 1.25 -.1 .4])
        axis([-1 2+numel(geno_inds_to_plot) 0 100])
        fix_errorbar_tee_width(7)
        
    else
        
        subplot('Position',nudge(sp_positions_mid_bot{3,3},0.023,0))
    
        curve_name = 'expansion_ON';            

        graph.zero_line = 0;
        graph.zero_line_color = [.27 .27 .27];

        plot(-1000:1000,zeros(2001,1),'Color',graph.zero_line_color,'LineWidth',1)
        hold on
        
        % Just make a tuning curve with the correct color
        for i = 1:numel(geno_inds_to_plot)
            graph.line{i}       = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).mean_aligned_subresponse_ts);
            %graph.shade{i}      = (summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_aligned_subresponse);

            graph.color{i}     = my_colormap{colormap_ind{geno_inds_to_plot(i)}};

            names_plotted{i} = proper_geno_names{geno_inds_to_plot(i)};
            n_for_names_plotted(i) = summ_data.(curve_name).raw(geno_inds_to_plot(i)).N;
            color_for_names_plotted{i} = graph.color{i};
            
        end
        
        makeErrorShadedTimeseries(graph);
                
        box off
        set(gca,'YAxisLocation','right')
        set(gca,'XTick',[0 340],'XTickLabel',{'0','0.34(s)'},'fontsize',font_size_1)
        ylabel({'Aligned Mean \DeltaWBA','Subresponses (V)'},'color',font_color,'fontsize',font_size_1)
        axis([-15 350 -.2 .5])
        
    end
%     % Plot the On Expansion response-thing curve
%     subplot('Position',sp_positions_right{3,4})
%     
%     plot(1:10,1:10,'k--',1:10,10:-1:1,'k--')
%     title('placeholder for ON analysis','fontsize',font_size_1)
%     axis off
%     box on
	
    % Make a legend with all of the correct names and usefully sized color
    % boxes

    legend_rectangle_loc = [.66 .482 .02 .0075];
    legend_text_loc = [.675 .445 .4 .07];
    text_decrement = .07;
    
    for i = 1:numel(names_plotted)
        
        %subplot('Position',legend_rectangle_loc)
        h=annotation('Rectangle','Position',legend_rectangle_loc,'EdgeColor',color_for_names_plotted{i},'facecolor',color_for_names_plotted{i});
                
        name_with_n = {[names_plotted{i} ' N = ' num2str(n_for_names_plotted(i))]};
        
        annotation('textbox','position',legend_text_loc,'string',name_with_n,...
            'interpreter','none','EdgeColor','none','fontsize',font_size_1); %

        
        legend_rectangle_loc    = [legend_rectangle_loc(1) legend_rectangle_loc(2)-text_decrement legend_rectangle_loc(3:4)];
        legend_text_loc         = [legend_text_loc(1) legend_text_loc(2)-text_decrement legend_text_loc(3:4)];
        
    end

    export_fig(combined_figure_handle(plotting_group),fullfile(summary_location,fig_file_name),'-pdf')


if 0

% make a bunch of subplots for MR
    
    mr_subplots(plotting_group) = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 750 1250],...
                                    'PaperOrientation','portrait');    
    % Set up subplot dimensions
    nHigh       = 6;
    nWide       = 20;
    widthGap    = .01;
    heightGap   = .02;
    widthOffset = .05;
    heightOffset= .025;
    
    subplots_for_single_fly = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    curve_name = 'sawtooth_ON';
    
    annotation('Textbox','Position',[text_offset+.075 .8875 .8 .167],'String',graph_name,'Edgecolor','none','fontsize',font_size_2)

    for i = 1:numel(geno_inds_to_plot)
        for fly = 1:(size(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1},1)+1)
            if fly <= size(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1},1)
            
                subplot('Position',subplots_for_single_fly{i,fly})

                plot(0*ones(1,numel(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1})),'Color',[.5 .5 .5],'linewidth',1,'linestyle','--');
                hold all
                plot(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,:));
                plot(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,:)-mean(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,1:50)));
                ma=max(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,:));
                mi=min(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,:));

                plot(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).integ_resp(fly,:)/max(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).integ_resp(fly,:)));
                plot(repmat(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).all_turning_thresh_times(fly,:),2,1),[mi ma])

                axis([0 3000 -1 3])

                box off

                if fly ~= 1
                    axis off
                else
                    ylabel('\DeltaWBA (V)')
                end

                if fly == 3
                    title(proper_geno_names{geno_inds_to_plot(i)})
                elseif fly == 8
                   title(curve_name,'interpreter','none') 

                end

                clear graph

            else
                
                % plot the average fly

                subplot('Position',subplots_for_single_fly{i,fly})

                plot(0*ones(1,numel(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1})),'Color',[.5 .5 .5],'linewidth',1,'linestyle','--');
                hold all
                plot(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1}(1,:),'Color',[1 0 1]);
                ma=max(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1}(1,:));
                mi=min(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1}(1,:));

                plot(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).avg_integ_resp(1,:)/max(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).avg_integ_resp(1,:)));
                plot(repmat(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).mean_turning_thresh_times,2,1),[mi ma])

                axis([0 3000 -1 3])

                box off                
                axis off

            end
        end
    end
    
    export_fig(mr_subplots(plotting_group),fullfile(summary_location,['sawtooth_ON_subplots_for_' fig_file_name]),'-pdf')
    
    summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).avg_integ_resp;
    summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).integ_resp;
    
    summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).all_turning_thresh_times;
    summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).mean_turning_thresh_times;
    summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).sem_turning_thresh_times;
    
    if 0
        
% make a bunch of subplots for MR
    
    mr_subplots2(plotting_group) = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                                    'Color',figure_color,'Position',[50 50 750 1250],...
                                    'PaperOrientation','portrait');    
    % Set up subplot dimensions
    nHigh       = 6;
    nWide       = 16;
    widthGap    = .01;
    heightGap   = .05;
    widthOffset = .05;
    heightOffset= .025;
    
    subplots_for_single_fly = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);
    
    curve_name = 'sawtooth_ON';
    clear graph
    annotation('Textbox','Position',[text_offset+.075 .8875 .8 .167],'String',graph_name,'Edgecolor','none','fontsize',font_size_2)

    for i = 1:numel(geno_inds_to_plot)
        for fly = 1:size(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1},1)
            if fly < 17

            subplot('Position',subplots_for_single_fly{i,fly})
            
            plot(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1},'Color',[.5 .5 .5],'linewidth',2); hold all;
            plot(0*ones(1,numel(summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_lmr_ts{1})),'Color',[.5 .5 .5],'linewidth',1,'linestyle','--');            
            plot(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).integ_thresh_time(fly)*ones(2,1),[-1000 1000],'color',[0 .75 1],'linewidth',2);
            %plot(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).running_sum{fly}/1000,'color',[0 .75 1],'linewidth',2);
            
            graph.line{1}  = summ_data.(curve_name).raw(geno_inds_to_plot(i)).avg_per_fly_lmr_ts{1}(fly,:);
            graph.shade{1} = summ_data.(curve_name).raw(geno_inds_to_plot(i)).sem_per_fly_lmr_ts{1}(fly,:);
            graph.color{1} = [1 .09 .09];
            
            graph.zero_line_color = [.27 .27 .27];
            graph.zero_line = 0;
            
            makeErrorShadedTimeseries(graph);
            
            axis([0 3000 -2.5 3])
            
            box off
            
            if fly ~= 1
                axis off
            else
                ylabel('LmR WBA (V)')
                xlabel('Time (s)')
            end
            
            if fly == 5
                title(proper_geno_names{geno_inds_to_plot(i)})
            elseif fly == 9
               title(curve_name,'interpreter','none') 
            elseif fly == 12
                title('(means underlayed)')
            end
            
            clear graph
            
            text(1100,2,[num2str(summ_data.sawtooth_ON.raw(geno_inds_to_plot(i)).integ_thresh_time(fly)) 'ms'])
            
            end
        end
    end
    
    export_fig(mr_subplots2(plotting_group),fullfile(summary_location,['turn_thresh_subplots_for_' fig_file_name]),'-pdf')
    
    end
end

if 1

    if ~exist('cf_hand','var')

        % Set up subplot dimensions
        nHigh       = 3;
        nWide       = 3;
        widthGap    = .01;
        heightGap   = .05;
        widthOffset = .05;
        heightOffset= .025;

        subplot_cf = getFullPageSubplotPositions(nWide,nHigh,widthGap,heightGap,widthOffset,heightOffset);

        sp_iter = 1;
        
        cf_hand = figure( 'name' ,'Summary Figure','NumberTitle','off',...
                    'Color',figure_color,'Position',[50 50 750/2 1250/4],...
                    'PaperOrientation','portrait');    

    else

        sp_iter = sp_iter + 1;

    end
    
    figure(cf_hand)
    
    clear graph
        
    if sp_iter == 1
        annotation('Textbox','Position',subplot_cf{2,1},'String',graph_name,'Edgecolor','none','fontsize',font_size_2)
        subplot('Position',subplot_cf{2,2})
        kk = [1 2];
        colors_to_use = {[1 0 0], [0 0 0]};
    elseif sp_iter == 2
        annotation('Textbox','Position',subplot_cf{3,1},'String',graph_name,'Edgecolor','none','fontsize',font_size_2)
        subplot('Position',subplot_cf{3,2})        
        kk = [1 2 3];
        colors_to_use = {[1 0 0], [0 .5 0], [0 0 0]};
    else
        annotation('Textbox','Position',subplot_cf{1,1},'String',graph_name,'Edgecolor','none','fontsize',font_size_2)
        subplot('Position',subplot_cf{1,2})        
        kk = [1 2];
        colors_to_use = {[1 0 0], [0 0 0]};
    end

    
    graph.zero_line_color = [.27 .27 .27];
    plot(-10:10,zeros(21,1),'Color',graph.zero_line_color,'LineWidth',1)
    
    for i = kk
        graph.line{i}       = cell2mat(summ_data.opposed_ON_OFF.raw(geno_inds_to_plot(i)).avg_lmr_ts);
        %graph.shade{i}      = cell2mat(summ_data.opposed_ON_OFF.raw(geno_inds_to_plot(i)).sem_lmr_ts);
        graph.color{i}      = colors_to_use{i};
        %plot(graph.line{i},'Color',colors_to_use{i});
        %hold all
    end
    
    makeErrorShadedTimeseries(graph);
    
    ylabel('\DeltaWBA (V)')
    axis([0 2000 -.5 1])
    set(gca,'YTick',[0 1],'YTickLabel',{'0','1'},'fontsize',font_size_1,'ticklength',2*get(gca,'ticklength'))     
    set(gca,'XTick',[0 2000],'XTickLabel',{'0','2(s)'},'fontsize',font_size_1,'ticklength',2*get(gca,'ticklength'))
    clear graph
    box off

    % integrated part
    
    if sp_iter == 1
        subplot('Position',extendd(nudge(subplot_cf{2,3},.05,0),.3))
        kk = [1 2];
        colors_to_use = {[1 0 0], [0 0 0]};
    elseif sp_iter == 2
        subplot('Position',extendd(nudge(subplot_cf{3,3},.05,0),.3))        
        kk = [1 2 3];
        colors_to_use = {[1 0 0], [0 .5 0], [0 0 0]};
    else
        subplot('Position',extendd(nudge(subplot_cf{1,3},.05,0),.3))        
        kk = [1 2];
        colors_to_use = {[1 0 0], [0 0 0]};
    end
    
    for i = kk
        graph.line{i}       = cell2mat(summ_data.opposed_ON_OFF.raw(geno_inds_to_plot(i)).avg_lmr);
        graph.shade{i}      = cell2mat(summ_data.opposed_ON_OFF.raw(geno_inds_to_plot(i)).sem_lmr);
        graph.color{i}      = colors_to_use{i};
    end
    
    graph.zero_line_color = [.27 .27 .27];
    plot(-10:10,zeros(21,1),'Color',graph.zero_line_color,'LineWidth',1)
    
    makeErrorbarTuningCurve(graph,1:numel(kk));
    graph.zero_line_color = [.27 .27 .27];
    ylabel({'Integrated',' \DeltaWBA (V*s)'})
    set(gca,'YAxisLocation','right')
    set(gca,'XTickLabel',{''},'XTick',0,'fontsize',font_size_1,'ticklength',2*get(gca,'ticklength'))
    set(gca,'YTick',[0 500 1000],'YTickLabel',{'0','.5','1'},'fontsize',font_size_1,'ticklength',2*get(gca,'ticklength')) 
    axis([0 1+numel(kk) -200 1000])
    fix_errorbar_tee_width(7)
    box off
    clear graph
	
    if sp_iter == 3
        export_fig(cf_hand,fullfile(summary_location,'clark_turning_responses'),'-pdf')
    end
end

end
% %%%%% clone to one figure
% newFigHand = figure( 'name' ,'Summary Figure','NumberTitle','off',...
%                                     'Color',figure_color,'Position',[50 50 590 3*285],...
%                                     'PaperOrientation','portrait');
% for i = [6 7 8]
%     CloneFig(combined_figure_handle(plotting_group),newFigHand)
% end









