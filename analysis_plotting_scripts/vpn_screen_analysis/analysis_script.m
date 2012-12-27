% VPN Analysis Script, mostly for organizational purposes.
%
% To get all the data into a format that makes sense for database upload
% and final analysis.
% 
% 
% Directories for pre processing
% raw_data_directory = '/Volumes/lacie-temp-external/vpn_screen_orig_backup/';
% screen_part_subfolders = {  'set_1_telethon_experiment_2012',...
%                             'set_2_telethon_experiment_2012',...
%                             'set_3_telethon_experiment_2012'};
% output_directory = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';
% 
%% PART 1
% Steps for analysis:
%
% Step 1 - Get the file names and metadata correct

update_fix_vpn_telethon_metadata % DONE

% Step 2 - Delete all of the experiments that failed for some reason

rename_genotype_folders % DONE

% Mid step, add a flag to the metadata files that don't have the velocity
%          nulling working correctly

update_fix_vpn_telethon_metadata_vel_null_flag % DONE

% Step 3 - Populate an excel spreadsheet with the names, numbers and dates
%          of experiments.

get_screen_vpn_telethon_status % DONE

make_screen_status_spreadsheet % TODO

%% PART 2

% Step 4/5 - Load in each genotype's lmr averages and sem's for some stimuli
%          as well as cross correlational data when appropriate. Save
%          summary .mat files for each genotype and the whole screen.
%          - Calculate overall and genotype specific turning responses for
%          potential normalization.

generate_per_genotype_summary_mat_files % DONE

get_screen_normalization_values % DONE

generate_raw_and_tuning_curve_summary_mat_files % DONE

% Step 6 - Make per genotype figures(compared to average across all, etc.,)

make_per_genotype_vpn_telethon_screen_figures  % DONE

% Step 7 - Make overall comparison figures

make_whole_vpn_telethon_screen_figures  % TODO
