% Load turning data to generate a normalization values

data_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';

geno_dir = dir(data_location);

geno_names = {geno_dir(4:end).name};

if 1
    for g = 1:numel(geno_names)
        stable_dir_name = dir(fullfile(data_location,[geno_names{g},'*']));
        location = fullfile(data_location,stable_dir_name.name);
        file_name = dir(fullfile(location,'*summary.mat'));
        
        if exist(fullfile(location,file_name.name),'file')
            load(fullfile(location,file_name.name));
            fprintf(['Loaded: ' num2str(g) ' of ' num2str(numel(geno_names)) '\n']);
        else
            disp('no processed summary data!')
        end
        
        geno_data = tfAnalysis.ExpSet(eval(file_name.name(1:end-4)));
        
        screen_turning_data(g).resps = geno_data.exp_set_turning_resp; %#ok<*SAGROW>
        
        screen_turning_data(g).names = geno_names{g};
        
        clear geno_data
        clear OL*
        
    end
end

temp_norm_vals = [screen_turning_data(:).resps]./mean([screen_turning_data(:).resps]);

for i = 1:numel(temp_norm_vals)
    
    screen_turning_data(i).norm_val = temp_norm_vals(i);
    
end

save(fullfile(data_location,'..','screen_turning_data'),'screen_turning_data');