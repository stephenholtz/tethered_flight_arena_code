% Add a flag to the experiments that do not have an updated version of the protocol where velocity nulling works
screen_name_file = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/vpn_screen_names';
load(screen_name_file);
post_processing_loc = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';
    
subfolder_filepath = fullfile(post_processing_loc);

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
                load(fullfile(experiment_paths,'conditions.mat'))
                
                disp(metadata.Line)
                disp(conditions(1).Gains)
                
                % Look at the change that was made
                if conditions(1).Gains(3)
                    metadata.note = 'vel_null_working';
                else
                    metadata.note = 'no_vel_null';
                end
                
                disp(metadata.note)

%             reply = input('save? [Y/n]','s');
%             
%             switch reply
%                 case {'Y','','y'}
                 save(fullfile(experiment_paths,'metadata.mat'),'metadata')
%                 otherwise
%             end
            
            clear metadata conditions
        end


    end

end
