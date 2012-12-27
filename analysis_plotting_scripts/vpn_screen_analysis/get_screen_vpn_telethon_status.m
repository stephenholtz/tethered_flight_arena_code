% Get the status of the screen by looking at a master list of lines. Put in
% cell array that can be easily sent to an excel spreadsheet.

%function progress_struct = track_progress(experiment_folder,ts_flag)
% function [progress_struct] = track_progress(experiment_folder)
% returns a struct with the number of experiments perfomed on each
% genotype within the folder and the total number.

experiment_folder = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';

geno_dir = dir(experiment_folder);

geno_iter = 1;

% For each of the genotypes
for i = 1:numel(geno_dir)
    
    if geno_dir(i).isdir && ~sum(strcmpi(geno_dir(i).name,{'.','..','.DS_Store','.thumbsdb'}))
        
        exp_dir = dir(fullfile(experiment_folder,geno_dir(i).name));
        exp_count = 0;
        vel_null_working_count = 0;
        no_vel_null_count = 0;
        
        % For all of one genotype's experiments
        for g = 1:numel(exp_dir)
            
            if exp_dir(g).isdir && ~sum(strcmpi(geno_dir(i).name,{'.','..','.DS_Store','.thumbsdb'}))
            
                % Add up the number of .daq files
                if ~isempty(dir(fullfile(experiment_folder,geno_dir(i).name,exp_dir(g).name,'*.daq')))
                    
                    load(fullfile(experiment_folder,geno_dir(i).name,exp_dir(g).name,'metadata.mat'))
                    
                    exp_count = exp_count + 1;
                    
                    if strcmpi(metadata.note,'vel_null_working')
                        vel_null_working_count = vel_null_working_count + 1;
                    elseif strcmpi(metadata.note,'no_vel_null')
                        no_vel_null_count = no_vel_null_count + 1;
                    else
                        disp('metadata.note field not helpful here')
                    end
                    
                end
            end
            
            progress_struct.(geno_dir(i).name).count = exp_count;
            progress_struct.(geno_dir(i).name).vell_null_count = vel_null_working_count;
            progress_struct.(geno_dir(i).name).no_vell_null_count = no_vel_null_count;
            
        end
        
        geno_iter = 1 + geno_iter;
        
    end
end