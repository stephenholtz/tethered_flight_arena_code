% Plot for each folder
%root_dir = '/Users/holtzs/Desktop/summary_files/';
%save_dir = '/Users/holtzs/Dropbox/holtz_data_dump/telethon_black/';

root_dir = '/Users/holtzs/Desktop/new_temp/summary_files/';
save_dir = '/Users/holtzs/Desktop/new_temp/summary_pdfs/';
% save_dir = '/Users/holtzs/Dropbox/holtz_data_dump/telethon_white/';

genotypes = dir(root_dir);
genotypes = genotypes(4:end);

control_str = '/Users/holtzs/Desktop/new_temp/summary_files/gmr_42f06_gal4/unshifted.mat';

for g = 1:numel(genotypes)
 %    cd(fullfile(root_dir,genotypes{g}));
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
    
%     if numel(str) == 1;
%         [P1, P2, P3] = tfPlot.plot_telethon_comparison_figure(str{1});
%     elseif numel(str) == 2;
%         [P1, P2, P3] = tfPlot.plot_telethon_comparison_figure(str{1},str{2});
%     end
[P1, P2, P3] = tfPlot.plot_telethon_comparison_figure(str{1},control_str);
    
    tmp_name = genotypes(g).name(1:14);
    geno_name = fullfile(save_dir,[tmp_name '_Summary_P1']);
    
%     cf=pwd;
%     cd(save_dir)
    export_fig(P1,geno_name,'-pdf')
    pause(.5)
    export_fig(P2,geno_name,'-pdf','-append')
    pause(.5)
    export_fig(P3,geno_name,'-pdf','-append')
%     cd(cf)
end