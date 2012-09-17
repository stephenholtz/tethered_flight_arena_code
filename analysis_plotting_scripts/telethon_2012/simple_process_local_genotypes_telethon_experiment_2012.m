% cd to the data folder

exp_dir = '/Users/holtzs/Desktop/telethon_experiment_2012';
cd(exp_dir);
genotypes = dir(exp_dir);

for i = 1:numel(genotypes)
    disp(genotypes(i).name)
    if ~sum(strcmpi(genotypes(i).name,{'.','..','.DS_STORE','thumbs'}))
        stable_dir_name = dir(fullfile(cd,[genotypes(i).name,'*']));
        location = fullfile(cd,stable_dir_name.name);
        experiment_files = dir(location);
        if ~sum(strfind([experiment_files.name],'processed_data'))
            processed_data = tfAnalysis.import(location,'all');
            save(fullfile(location,'processed_data.mat'),'processed_data')
            clear processed_data force
        end
    end
end