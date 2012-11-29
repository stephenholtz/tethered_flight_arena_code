% Make single to median plotting function - should take a set of
% experiments and use either all or a subset of them to compare each to the
% median. 
%
% Takes a cell array of ExpSet objects, saves the median data from the set
% as median_of_exp_sets. OR just use as a script (below)
%
geno_names{1} = 'gmr_OL00XX_gal80ts_kir21';
geno_names{2} = 'gmr_OL0001_gal80ts_kir21';
geno_names{3} = 'gmr_OL0004_gal80ts_kir21';
geno_names{4} = 'gmr_OL0008_gal80ts_kir21';
geno_names{5} = 'gmr_OL0011_gal80ts_kir21';
geno_names{6} = 'gmr_OL0013_gal80ts_kir21';
geno_names{7} = 'gmr_OL0016_gal80ts_kir21';
geno_names{8} = 'gmr_OL0017_gal80ts_kir21';
geno_names{9} = 'gmr_OL0018_gal80ts_kir21';
geno_names{10} = 'gmr_OL0020_gal80ts_kir21';
geno_names{11} = 'gmr_OL0021_gal80ts_kir21';
geno_names{12} = 'gmr_OL0023_gal80ts_kir21';
geno_names{13} = 'gmr_OL0025_gal80ts_kir21';
geno_names{14} = 'gmr_OL0028_gal80ts_kir21';
geno_names{15} = 'gmr_OL0030_gal80ts_kir21';
geno_names{16} = 'gmr_OL0031_gal80ts_kir21';
geno_names{17} = 'gmr_OL0033_gal80ts_kir21';
geno_names{18} = 'gmr_OL0035_gal80ts_kir21';
geno_names{19} = 'gmr_OL0038_gal80ts_kir21';

data_location = '/Volumes/STEPHEN32SD/telethon_experiment_2012';

if 0
    
    for g = 1:numel(geno_names)
        file_name = [];
        stable_dir_name = dir(fullfile(data_location,[geno_names{g},'*']));
        location = fullfile(data_location,stable_dir_name.name);
        file_name = dir(fullfile(location,'*summary.mat'));
        
        if exist(fullfile(location,file_name.name),'file')
            load(fullfile(location,file_name.name));
            fprintf(['Loaded: ' num2str(g) ' of ' num2str(numel(geno_names)) '\n']);
        else
            disp('no processed summary data!')
        end
        
        geno_data{g} = tfAnalysis.ExpSet(eval(file_name.name(1:end-4))); %#ok<*AGROW>

    end
    
end










