% Plot for each folder
%root_dir = '/Users/holtzs/Desktop/summary_files/';
%save_dir = '/Users/holtzs/Dropbox/holtz_data_dump/telethon_black/';

% genotype{1}     = '55d05-55d05_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{2}     = '22b02-22b02_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{3}     = '76e09-76e09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{4}     = '24g09-24g09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{5}     = '67a04-67a04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{6}     = '19c07-19c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{7}     = '89c04-89c04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{8}     = '11c07-11c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{9}     = '13g04-13g04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
% genotype{10}    = '42f06-42f06_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';

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

root_dir = '/Users/holtzs/Desktop/new_temp/summary_files/';
% save_dir = '/Users/holtzs/Dropbox/new_temp/summary_pdfs/';
save_dir = '/Users/holtzs/Dropbox/holtz_data_dump/telethon_white/';

genotypes = dir(root_dir);
genotypes = genotypes(4:end);

for g = 1:numel(genotypes)
%     cd(fullfile(root_dir,genotype{g}));
    cd(fullfile(root_dir,genotypes(g).name));

    files = dir(cd);
    files = {files(3:end).name};
    str = [];

    if sum(strcmpi(files,'shifted.mat'))
    str{1} = 'shifted.mat';
    end
    if sum(strcmpi(files,'unshifted.mat'))
    str{2} = 'unshifted.mat';
    end
    
    if numel(str) == 1;
    [P1, P2, P3] = tfPlot.plot_telethon_comparison_figure(str{1});
    elseif numel(str) ==2;
    [P1, P2, P3] = tfPlot.plot_telethon_comparison_figure(str{1},str{2});
    end
%     geno_name = fullfile(save_dir,[genotype{g}(1:5) '_Summary_P1']);
    tmp_name = genotypes(g).name;
    geno_name = fullfile(save_dir,[tmp_name(1:5) '_Summary_P1']);

    % saveas(P1,geno_name,'fig') 
    export_fig(P1,geno_name,'-pdf')
    pause(.5)
    % geno_name = fullfile(save_dir,[genotype{g}(1:5) '_Summary_P2']);
    % saveas(P2,geno_name,'fig')
    export_fig(P2,geno_name,'-pdf','-append')
    pause(.5)
    export_fig(P3,geno_name,'-pdf','-append')
end