function fix_metadata_protocol_name(top_level_folder)
    geno_folders = dir(top_level_folder);
    geno_folders = geno_folders(3:end);
    for g = 1:numel(geno_folders)
        temp_names = dir(fullfile(top_level_folder,geno_folders(g).name));
        
        for a = 1:numel(temp_names)
            experiment_paths = fullfile(top_level_folder,geno_folders(g).name,temp_names(a).name);
            experiment_folder_contents = dir(experiment_paths);
            
            if  sum(strcmpi(temp_names(a).name,{'.','..','.DS_Store'}))
                disp('skipped')
                
            elseif sum(strcmpi({experiment_folder_contents(:).name},'metadata.mat'));
                load(fullfile(experiment_paths,'metadata.mat'))
                disp(metadata.Protocol)
                metadata.Protocol = 'rev_phi_phase_delay_8_wide';
                disp(metadata.Protocol)
                
                try
                metadata.Arena = deblank(metadata.Arena);
                metadata.Experimenter = deblank(metadata.Experimenter);
                catch
                    metadata.Arena = metadata.Arena(1:10);
                    metadata.Experimenter = 'holtzs';
                end
                
                load(fullfile(experiment_paths,'conditions.mat'))
                
                disp('Old Pat')
                disp(conditions(1).PatternID)
                disp(conditions(1).PatternName)
                
                for i = 1:numel(conditions)-1
                   conditions(i).PatternName    = 'Pattern_004_full_field_rot_8_wide';
                   conditions(i).PatternID      = 4;
                end
                conditions(numel(conditions)).PatternID = 49;
                
                disp('New Pat')
                disp(conditions(1).PatternID)
                disp(conditions(1).PatternName)
                disp(metadata.ExperimentName)
                
%                 reply = input('save? [Y/n]','s');
%                 
%                 switch reply
%                     case {'Y','','y'}
%                         save(fullfile(experiment_paths,'metadata.mat'))
%                         save(fullfile(experiment_paths,'conditions.mat'))
%                     otherwise
%                         % implied continue
%                 end
                clear metadata conditions
            else
                error('summin''s up')
            end

         

        end
    end
end