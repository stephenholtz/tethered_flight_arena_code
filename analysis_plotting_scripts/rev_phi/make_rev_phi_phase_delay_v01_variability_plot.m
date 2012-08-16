% make_rev_phi_phase_delay_4_wide_v01_varaibility_plot


% Make local mat file of all data, if needed.
cd /Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01

if ~exist('gmr_11d03ad_gal80ts_kir21','file')
    gmr_11d03ad_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01/gmr_11d03ad_gal80ts_kir21','all');
    save('gmr_11d03ad_gal80ts_kir21','gmr_11d03ad_gal80ts_kir21')
elseif ~exist('gmr_11d03ad_gal80ts_kir21','var')
    disp('already imported, loading mat file')
    load('gmr_11d03ad_gal80ts_kir21')
end

exp_set = tfAnalysis.ExpSet(gmr_11d03ad_gal80ts_kir21);
num_exps = numel(exp_set.experiment);

% Pull out raw data for each individual experiment
for g = 1:numel(exp_set.grouped_conditions{1}.list)
    means{g} = nan(1,num_exps);
end

iter = 1;
for i = 1; %:numel(exp_set.grouped_conditions)
    cond_list = exp_set.grouped_conditions{i}.list;
    for c = 1:numel(cond_list);
        [temp_means sems{c}]= exp_set.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','fly'); %#ok<*SAGROW>
        means{c}(1:numel(temp_means)) = temp_means;
    end
    title_array{iter} = exp_set.grouped_conditions{i}.name;
    iter = iter + 1;
end

% Pull out all possible sets of 3 and 3 experiments. Also plot those with
% the highest difference in mean tuning curve data.

for choose = [1 3 6 9 12];
    subsets.(['choose_' num2str(choose)]) = nchoosek(1:num_exps,choose);
    % max_num_combos.(['choose_' num2str(choose)]) = factorial(num_exps)/(factorial(choose)*factorial(num_exps-choose));
end

% For each of the subsets of experiments determine means, and figure out
% which are the most different.
s = fieldnames(subsets);
figure
for sub = 1:numel(s);
    combos = getfield(subsets,s{sub});
    for c = 1:size(combos,1)
        for cond = 1:numel(exp_set.grouped_conditions{1}.list)
            combo_data.(s{sub}).mean(c,cond) = mean(means{cond}(combos(c,:)));
            combo_data.(s{sub}).exps(c,:) = combos(c,:)';
        end
    end
    subplot(numel(s),1,sub)
    plot(combo_data.(s{sub}).mean');
    title(s{sub},'interpreter','none')
end

figure;
plot(combo_data.choose_6.mean'); hold all
plot(combo_data.choose_12.mean','linewidth',3,'color',[0 0 0])


% This code does not work below this point! In progress!
% Diff of all possible combinations
s = fieldnames(subsets);
for sub = 1:numel(s);
    
    num_combos = numel(combo_data.(s{sub}).mean);
    
    for c = 1:num_combos
        all_differences = repmat(combo_data.(s{sub}).mean(c),num_combos,1) - combo_data.(s{sub}).mean(1:num_combos)';
        [~,max_ind] = max(abs(all_differences));
        combo_data.(s{sub}).max_diff(c,:) = [c, max_ind];
    end
end

% Maximum of all these
for sub = 1:numel(s);
    comparison_pair = combo_data.(s{sub}).mean((combo_data.(s{sub}).max_diff));
    
    [~,max_ind] = max(sum(abs(all_differences),2));
    combo_data.(s{sub}).max_diff_pair = [c, (max_ind(1))];
end

% Something useless
s = fieldnames(subsets);
for sub = 1:numel(s);
    
    all_mean_diffs = combo_data.(s{sub}).mean(combo_data.(s{sub}).max_diff_pair);
    [~, max_max_ind] = max(abs(all_mean_diffs(:,1)-all_mean_diffs(:,2)));
    combo_data.(s{sub}).max_max_diff_pair = combo_data.(s{sub}).max_diff(max_max_ind,:);
    
    combo_data.(s{sub}).abs_diff_bn_max_maxs = abs(combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(1))-combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(2)));
    combo_data.(s{sub}).diff_bn_max_maxs = combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(1))-combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(2));
    
    subplot(numel(s),1,sub)
    plot(combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(1))'); 
    hold all
    plot(combo_data.(s{sub}).mean(combo_data.(s{sub}).max_max_diff_pair(2))');
    
    plot(combo_data.(s{sub}).abs_diff_bn_max_maxs')
    
    title(['Maximally different behavior for ' s{sub}],'interpreter','none')
    
end

% legend(handle_array,title_array)
% xlabel('Flicker Offset [ms]')
% ylabel('Mean LmR [V]')
