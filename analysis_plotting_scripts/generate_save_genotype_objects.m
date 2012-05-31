%% Generate mat files, proc for now
tic
% example:
% gmr_11c07_ae_01 = tfAnalysis.import('/Users/holtzs/Desktop/telethon_experiment_2011/11c07-11c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21/','all');

root_location = '/Users/holtzs/Desktop/new_temp/telethon_experiment_2011/';
save_root = '/Users/holtzs/Desktop/new_temp/summary_files/';

% genotype{1} = '55d05-55d05_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{2} = '22b02-22b02_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{3} = '76e09-76e09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{4} = '24g09-24g09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{5} = '67a04-67a04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{6} = '19c07-19c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{7} = '89c04-89c04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{8} = '13g04-13g04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{9} = '42f06-42f06_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{10} = '11c07-11c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';

genotypes = dir(root_location);
genotypes = genotypes(3:end);

% for i = 1:10
for i = 9:numel(genotypes);
    
    % IMPORT
%     geno = tfAnalysis.import(fullfile(root_location,genotype{i}),'all');
    geno = tfAnalysis.import(fullfile(root_location,genotypes(i).name),'all');    
    geno = tfAnalysis.Genotype(geno.experiment);
    
    
    % GENERATE MAT FILE for shifted and unshifted...
    geno.select('shifted');
    geno = geno.calculate_channel_means_sems;
    shifted = tfPlot.generate_mat_file_for_telethon_genotype(geno);
    
    try
    geno.select('unshifted');
    geno = geno.calculate_channel_means_sems;    
    unshifted = tfPlot.generate_mat_file_for_telethon_genotype(geno);
    catch mERR
        disp('Cannot make unshifted...')
    end
    
    % AND SAVE MATS + GENO
%     filepath = fullfile(save_root,genotype{i});
    filepath = fullfile(save_root,genotypes(i).name);
    mkdir(filepath)    
    filename = fullfile(filepath,'shifted');
    save(filename,'shifted')
    try
    filename = fullfile(filepath,'unshifted');
    save(filename,'unshifted')
    catch sERR
        disp('Cannot save unshifted...')
    end
    
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