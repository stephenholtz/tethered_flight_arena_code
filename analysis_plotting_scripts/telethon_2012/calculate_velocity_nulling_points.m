% Make vel nulling fig
if 0

data_location = '/Users/holtzs/Desktop/telethon_experiment_2012';
geno_names{1} = 'gmr_14a11ad_50c10dbd_gal80ts_kir21';

for g = 1:numel(geno_names)
    stable_dir_name = dir(fullfile(data_location,[geno_names{g},'*']));
    location = fullfile(data_location,stable_dir_name.name);

    if exist(fullfile(location,'processed_data.mat'),'file')
        load(fullfile(location,'processed_data.mat'));
        fprintf(['Loaded: ' num2str(g) ' of ' num2str(numel(geno_names)) '\n']);
    else
        processed_data = load_data(location);
    end
    
    geno_data{g} = tfAnalysis.ExpSet(processed_data); %#ok<*AGROW>
    
    clear processed_data force
end

end


%for i = 1:numel(geno_data)
i = 1;
% gather three points for each of the test contrasts used at a given
% temporal frequency

stim_set{1} = [1 2 3];
stim_set{2} = [4 5 6];
stim_set{3} = [7 8 9];
stim_set{4} = [10 11 12];
stim_set{5} = [13 14 15];

for g = 1:numel(stim_set)
    
    % vel nulling is the 12th set
    condition_numbers = geno_data{i}.grouped_conditions{12}.list(stim_set{g});
    
    [null_contrast_vals{g} null_contrast_vals_sem{g}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');
    
end

for g = 1:numel(null_contrast_vals)
    
    null_contrast_line{g} = cell2mat(null_contrast_vals{g});
    
    zero_cross_point(g) = regress([1:numel(null_contrast_line{g})]',null_contrast_line{g}');
    
    null_contrast_line_sem{g} = cell2mat(null_contrast_vals_sem{g});
    
end

% calculate the zero crossing point linreg for each of the three point
% pairs



% make a line out of each for the genotype

%end

% plot the data
