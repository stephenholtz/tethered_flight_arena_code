% Fix the metadata and naming iteratively, quick and dirty-like

raw_data_directory = '/Volumes/lacie-temp-external/preprocessed_vpn_screen';
screen_part_subfolders = {  'set_1_telethon_experiment_2012',...
                            'set_2_telethon_experiment_2012',...
                            'set_3_telethon_experiment_2012'};
screen_name_file = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/vpn_screen_names';
load(screen_name_file);

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
            elseif sum(strfind(genotype_folder_contents(geno_iter).name,'summary'))
                
                % delete the summary mat files if they still exist!
                unix(['rm ' fullfile(experiment_paths)],'-echo');
                
            elseif sum(strcmpi({experiment_folder_contents(:).name},'metadata.mat'));
                % Load in the metadata file.
                
                load(fullfile(experiment_paths,'metadata.mat'))
                
                vpn_screen_name_ind = 0;
                
                for name_iter = 1:numel(vpn_screen_names.Stablelinename)
                    if ~isempty(strfind(lower(metadata.Line),lower(vpn_screen_names.AD{name_iter}(1:5)))) &&...
                       ~isempty(strfind(lower(metadata.Line),lower(vpn_screen_names.DBD{name_iter}(1:5))))
                   
                        vpn_screen_name_ind = name_iter;
                        
                        
                        % Fix the AD DBD naming stuff
                        disp('metadata.Line')
                        disp(metadata.Line)
                        disp('')
                        disp('vpn_screen_names.AD')
                        disp(vpn_screen_names.AD{name_iter})
                        disp('')
                        disp('vpn_screen_names.DBD')
                        disp(vpn_screen_names.DBD{name_iter})
                        disp('')
                        disp('vpn_screen_names.Stablelinename{vpn_screen_name_ind}')
                        disp(vpn_screen_names.Stablelinename{vpn_screen_name_ind})
                        disp('')
                                                
                        metadata.Line = vpn_screen_names.Stablelinename{vpn_screen_name_ind};
                        
                    elseif ~isempty(strfind(lower(metadata.Line),lower(vpn_screen_names.Stablelinename{name_iter})))
                        % Fix close matches?
                        vpn_screen_name_ind = name_iter;
                        
                        disp('metadata.Line')
                        disp(metadata.Line)
                        disp('vpn_screen_names.Stablelinename{vpn_screen_name_ind}')
                        disp(vpn_screen_names.Stablelinename{vpn_screen_name_ind})
                        vpn_screen_name_ind = name_iter;
                        
                        metadata.Line = vpn_screen_names.Stablelinename{vpn_screen_name_ind};
                        
                    end
                end
                
                if vpn_screen_name_ind == 0;
                    if strcmpi('gmr_24z02ad_26a03dbd',metadata.Line)
%                         metadata.Line = 'gmr_24a02ad_26a03dbd';
                    elseif numel(metadata.Line) < 17;                        
%                         if ~strcmpi(metadata.Line(end),'B') || ~strcmpi(metadata.Line(end),'C')
%                             metadata.Line = [metadata.Line 'B'];
%                         end
%                         
%                         if strcmpi(metadata.Line(1:6),'gmr_OL')
%                            metadata.Line = metadata.Line(5:end);
%                            disp(metadata.Line)
%                         elseif ~isempty(strfind(metadata.Line(1:4),'gmr_'))
%                             disp('*****************************')                            
%                             disp(metadata.Line)
%                             metadata.Line = metadata.Line(1:11);
%                             if strcmpi(metadata.Line(end),'b')
%                                 metadata.Line = [metadata.Line 'd'];
%                             end
%                         end

                    else
                        error('vpn name not found!')
                    end
                end
%                 if ~isempty(strfind(metadata.Line,'OL0034'))
%                     metadata.Line = 'OL0034B';
%                     disp(metadata.Line)
%                 end
                if ~isempty(strfind(metadata.Line,'OL0013'))
                    metadata.Line = 'OL0013C';
                    disp(metadata.Line)
                end     
                if ~isempty(strfind(metadata.Line,'OL0034'))
                    metadata.Line = 'OL0034C';
                    disp(metadata.Line)
                end                     
                metadata.Chromo2 = '';
                metadata.Chromo3 = '';
                
                % Show comparison pre post change
                disp(metadata.ExperimentName)
                metadata.ExperimentName = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Line];
                disp(metadata.ExperimentName)
                
                % for the next step in my curation...
                metadata.new_folder_name = [metadata.Line '_' metadata.Effector];
                metadata.Experimenter = 'holtzs';
%               
%                 reply = input('save? [Y/n]','s');
%                 
%                 switch reply
%                     case {'Y','','y'}
                          save(fullfile(experiment_paths,'metadata.mat'),'metadata')
%                     otherwise
%                         % implied continue
%                 end
                
                clear metadata
                
            else
                % Something went wrong, extra folder maybe?
                disp(genotype_folder_contents(geno_iter).name)
                disp('No metadata? Check above folder')
            end

        end

    end
end