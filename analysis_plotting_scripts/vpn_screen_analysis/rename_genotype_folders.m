% rename the folders to reflect the metadata.new_folder_name field but only
% move the experiments that are not crappy

raw_data_directory = '/Volumes/lacie-temp-external/preprocessed_vpn_screen';
screen_part_subfolders = {  'set_1_telethon_experiment_2012',...
                            'set_2_telethon_experiment_2012',...
                            'set_3_telethon_experiment_2012'};

output_directory = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';                        
                        
% screen_name_file = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/vpn_screen_names';
% load(screen_name_file);

for subfolder_iter = 1:numel(screen_part_subfolders)
    
    subfolder_filepath = fullfile(raw_data_directory,screen_part_subfolders{subfolder_iter});
    
    subfolder_genotype_folders = dir(subfolder_filepath);
    
    subfolder_genotype_folders = subfolder_genotype_folders(3:end);
    
    for g = 1:numel(subfolder_genotype_folders)
        
        genotype_folder_contents = dir(fullfile(subfolder_filepath,subfolder_genotype_folders(g).name));
        
        for geno_iter = 1:numel(genotype_folder_contents)
            
            fprintf('folder contents %d of %d \n',geno_iter,numel(genotype_folder_contents))
            
            experiment_paths = fullfile(subfolder_filepath,subfolder_genotype_folders(g).name,genotype_folder_contents(geno_iter).name);
            
            experiment_folder_contents = dir(experiment_paths);
            
            if  sum(strcmpi(genotype_folder_contents(geno_iter).name,{'.','..','.DS_Store'}))
                % Skip the nav folders
                disp(genotype_folder_contents(geno_iter).name)
                disp('Folder skipped.')
            elseif sum(strcmpi({experiment_folder_contents(:).name},'metadata.mat'));
                % Load in the metadata file.
                
                load(fullfile(experiment_paths,'metadata.mat'))
                
                disp(metadata.new_folder_name)
                
                % Make a directory for each (already done)
                if ~isdir(fullfile(output_directory,metadata.new_folder_name))
                    mkdir(fullfile(output_directory,metadata.new_folder_name))
                end
                
                tmp = tfAnalysis.import(experiment_paths);
                success = 1;
                
                % hackishly determine quality of experiments
                try tmp.experiment{1}.cond_rep_index(end)
                    
                catch 
                    success = 0;                    
                end
                
                if success
                    unix_mv_cmd = (['cp -r ' experiment_paths ' ' fullfile(output_directory,metadata.new_folder_name,genotype_folder_contents(geno_iter).name)]);
                    disp(unix_mv_cmd)
                    unix(unix_mv_cmd);
                else
                    disp('**************************************')                    
                    disp('experiment unworthy*******************')
                end
                
                clear metadata tmp success unix_mv_cmd
                
            else
                error('Directory error?')
            end

        end

    end
end