%% Generate mat files, proc for now
tic
% example:
% gmr_11c07_ae_01 = tfAnalysis.import('/Users/holtzs/Desktop/telethon_experiment_2011/11c07-11c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21/','all');

% root_location = '/Users/holtzs/Desktop/new_temp/telethon_experiment_2011/';
root_location = '/Volumes/reiserlab/slh_fs/telethon_experiment_2011/';
save_root = '/Users/holtzs/Desktop/new_temp/summary_files/';

genotypes = dir(root_location);
genotypes = genotypes(3:end);

% for i = 1:10
for i = 1:numel(genotypes);
    
    % IMPORT
%     geno = tfAnalysis.import(fullfile(root_location,genotype{i}),'all');
    geno = tfAnalysis.import(fullfile(root_location,genotypes(i).name),'all');    
    geno = tfAnalysis.Genotype(geno.experiment);
    
    
    % GENERATE MAT FILE for shifted and unshifted...
    geno.select('shifted');
    geno = geno.calculate_channel_means_sems;
    shifted = tfPlot.generate_mat_file_for_telethon_genotype(geno);
    
%     try
    geno.select('unshifted');
    geno = geno.calculate_channel_means_sems;    
    unshifted = tfPlot.generate_mat_file_for_telethon_genotype(geno);
%     catch mERR
%         disp('Cannot make unshifted...')
%     end
    
    % AND SAVE MATS + GENO
%     filepath = fullfile(save_root,genotype{i});
    filepath = fullfile(save_root,genotypes(i).name);
    mkdir(filepath)    
    filename = fullfile(filepath,'shifted');
    save(filename,'shifted')
%     try
    filename = fullfile(filepath,'unshifted');
    save(filename,'unshifted')
%     catch sERR
%         disp('Cannot save unshifted...')
%     end
    
%     geno_name = ['geno_gmr_' genotype{i}(1:5)];
%     
%     eval([geno_name '= geno']);
    clear geno; geno = [];
%     try
%     filename = fullfile(filepath,geno_name);
%     save(filename,geno_name);
%     catch barf
%         disp(barf)
%         disp(geno_name);
%     end
%     eval(['clear ' geno_name]);
    clear shifted
end

toc