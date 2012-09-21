%%
if 0
data_location = '/Users/holtzs/Desktop/telethon_experiment_2012';

geno_names{1} = 'gmr_26a03dbd_gal80ts_kir21';
geno_names{2} = 'gmr_35b06dbd_gal80ts_kir21';
geno_names{3} = 'gmr_35d04ad_gal80ts_kir21';
geno_names{4} = 'gmr_91b01dbd_gal80ts_kir21';

folder_name = 'control_comparison';

make_telethon_2012_comparison_figure(data_location,geno_names,folder_name)

close all force

end

%%
data_location = '/Users/holtzs/Desktop/telethon_experiment_2012';
% 
geno_names{1} = 'gmr_14a11ad_50c10dbd_gal80ts_kir21';
geno_names{2} = 'gmr_19g02ad_75g12dbd_gal80ts_kir21';
geno_names{3} = 'gmr_21d03ad_65c12dbd_gal80ts_kir21';
geno_names{4} = 'gmr_22a07ad_91b01dbd_gal80ts_kir21';
geno_names{5} = 'gmr_22h02ad_20g06dbd_gal80ts_kir21';
geno_names{6} = 'gmr_24a02ad_26a03dbd_gal80ts_kir21';
geno_names{7} = 'gmr_26a03ad_54a05dbd_gal80ts_kir21';
geno_names{8} = 'gmr_35d04ad_65b05dbd_gal80ts_kir21';
geno_names{9} = 'gmr_35d04ad_91b01dbd_gal80ts_kir21';
geno_names{10} = 'gmr_64g09ad_37h04dbd_gal80ts_kir21';
%geno_names{11} = 'gmr_67e03ad_94d12dbd_gal80ts_kir21';
geno_names{12} = 'gmr_71f06ad_35b06dbd_gal80ts_kir21';
geno_names{13} = 'gmr_75h09ad_35b06dbd_gal80ts_kir21';
geno_names{14} = 'gmr_87d07ad_59b03dbd_gal80ts_kir21';
geno_names{15} = 'gmr_92b02ad_91b01dbd_gal80ts_kir21';
geno_names{16} = 'gmr_92b11ad_82d11dbd_gal80ts_kir21';

% geno_names{1} = 'gmr_92b11ad_82d11dbd_gal80ts_kir21';
% geno_names{2} = 'gmr_71f06ad_35b06dbd_gal80ts_kir21';
% geno_names{3} = 'gmr_75h09ad_35b06dbd_gal80ts_kir21';
% geno_names{4} = 'gmr_87d07ad_59b03dbd_gal80ts_kir21';
% geno_names{5} = 'gmr_92b02ad_91b01dbd_gal80ts_kir21';

for g = 1:numel(geno_names)
    disp(geno_names{g});
    
    gn{1} = geno_names{g};
%     gn{2} = 'gmr_91b01dbd_gal80ts_kir21';
%     gn{3} = 'gmr_35b06dbd_gal80ts_kir21';

    folder_name = [gn{1} '_vs_control'];

    make_telethon_2012_comparison_figure(data_location,gn,folder_name)
    
    close all force

end
