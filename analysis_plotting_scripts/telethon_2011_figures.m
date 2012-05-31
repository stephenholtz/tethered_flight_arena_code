%% Make the Telethon_2011 Figures

file_loc = '/Users/holtzs/Dropbox/ReiserLab/box_hit_sub_geno_objects';

%% 11c07
shi = 'shifted_geno_11c07_kir21';
ushi = 'unshifted_geno_11c07_kir21';
mkdir(file_loc,shi(9:end));

shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_11c07_kir21,...
    unshifted_geno_11c07_kir21);

%% 13g04
shi ='shifted_geno_13g04_kir21';
ushi = 'unshifted_geno_13g04_kir21';
mkdir(file_loc,shi(9:end));

shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_13g04_kir21,...
    unshifted_geno_13g04_kir21);

%% 19c07
shi ='shifted_geno_19c07_kir21';
ushi = 'unshifted_geno_19c07_kir21';
mkdir(file_loc,shi(9:end));

shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_19c07_kir21,...
    unshifted_geno_19c07_kir21);

%% 22b02
shi ='shifted_geno_22b02_kir21';
ushi = 'unshifted_geno_22b02_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_22b02_kir21,...
    unshifted_geno_22b02_kir21);

%% 24g09
shi ='shifted_geno_24g09_kir21';
ushi = 'unshifted_geno_24g09_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_24g09_kir21,...
    unshifted_geno_24g09_kir21);

%% 42f06!!!!!!!!!!!!!!!!!!
shi ='shifted_geno_42f06_kir21';
ushi = 'unshifted_geno_55d05_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_42f06_kir21,...
    unshifted_geno_55d05_kir21);

%% 55d05
shi ='shifted_geno_55d05_kir21';
ushi = 'unshifted_geno_55d05_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_55d05_kir21,...
    unshifted_geno_55d05_kir21);

%% 67a04
shi ='shifted_geno_67a04_kir21';
ushi = 'unshifted_geno_67a04_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_67a04_kir21,...
    unshifted_geno_67a04_kir21);

%% 76e09
shi ='shifted_geno_76e09_kir21';
ushi = 'unshifted_geno_76e09_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_76e09_kir21,...
    unshifted_geno_76e09_kir21);

%% 89c04
shi ='shifted_geno_89c04_kir21';
ushi = 'unshifted_geno_76e09_kir21';
mkdir(file_loc,shi(9:end));
shi = fullfile(file_loc,shi);
ushi = fullfile(file_loc,ushi);
load(shi); load(ushi);

make_telethon_figure_comparison(...
    shifted_geno_89c04_kir21,...
    unshifted_geno_76e09_kir21);

