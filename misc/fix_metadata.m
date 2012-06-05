function fix_metadata(top_level_folder)
    start_pos = 1;
    geno_folders = dir(top_level_folder);
    geno_folders = geno_folders(3:end);
    experiment_folders = [];
    for g = 1:numel(geno_folders)
        temp_names = dir(fullfile(top_level_folder,geno_folders(g).name));
        experiment_paths = [];
        
        for a = 1:numel(temp_names)
            experiment_paths = fullfile(top_level_folder,geno_folders(g).name,temp_names(a).name);
            experiment_folder_contents = dir(experiment_paths);
            
            if  sum(strcmpi(temp_names(a).name,{'.','..','.DS_Store'}))
                disp('skipped')
                
            elseif sum(strcmpi({experiment_folder_contents(:).name},'metadata.mat'));
                load(fullfile(experiment_paths,'metadata.mat'))
                
                % e_shift = metadata.TempShift;
                % shift_unshift = regexpi(e_shift,'\d+.\d+.\d+','match');

                % pre_converted_times_shifted = (regexpi(shift_unshift{1},'\d+','match'));
                % pre_converted_times_unshifted = (regexpi(shift_unshift{2},'\d+','match'));
                titl = {'temp_unshift_time','temp_shift_time'};
                metadata.DateTime
                (experiment_paths)
                metadata
                out = inputdlg(titl,metadata.DateTime,1);
                if isempty(out)
                    return
                end
                
                
                metadata.temp_unshift_time           = out{1};
                metadata.temp_shift_time             = out{2};
                metadata.temp_unshifted              = 18;
                metadata.temp_shifted                = 30;
                metadata.temp_experiment             = 20.5;
                metadata.temp_ambient                = 20.5;
                metadata.humidity_ambient            = 60; 
                metadata.fly_tag                     = '';
                metadata.note                        = '';
                % p1 = regexpi(metadata.Chromo2,'\S+-','match');
                % p2 = regexpi(metadata.Chromo3,'\S+-','match');
                
                % Chromo2 = ['gmr_', p1{1}(1:end-1),'_gal4', '; ', p2{1}(1:end-1)];
                
                % p1 = regexpi(metadata.Chromo2,'-\S+','match');
                % p2 = regexpi(metadata.Chromo3,'-\S+','match');
                
                % Chromo3 = ['gmr_', p1{1}(2:end),'_gal4', '; ', p2{1}(2:end)];  
                
                % metadata.Chromo3                     = Chromo3;
                % metadata.Chromo2                     = Chromo2;
                
                metadata
                
                choice = questdlg('Save','SAVE??','yes','no','no');
                
                if strcmpi(choice,'yes')
                filename = fullfile(experiment_paths,'metadata.mat');
                save(filename,'metadata');
                disp(filename);
                mkdir(fullfile('/Volumes/reiserlab/slh_fs/TEMP_telethon_2011/telethon_experiment_2011/',geno_folders(g).name))
                movefile(experiment_paths,fullfile('/Volumes/reiserlab/slh_fs/TEMP_telethon_2011','telethon_experiment_2011',geno_folders(g).name,metadata.DateTime))
                else
                    disp('NOT SAVED, STOPPING')
                    return
                end
                p=0;
            else
                disp('summin''s up')
            end

         

        end
    end
end