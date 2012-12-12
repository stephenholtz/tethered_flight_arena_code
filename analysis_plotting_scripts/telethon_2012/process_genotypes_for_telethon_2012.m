% Process the files for the VPN telethon
% exp_dir = '/Users/holtzs/Desktop/telethon_experiment_2012';
% exp_dir = '/Volumes/STEPHEN32SD/telethon_experiment_2012';
% exp_dir = '/Volumes/STEPHEN32SD/telethon_experiment_2012_testing';
exp_dir = '/Volumes/lacie-temp-external/vpn_screen/set_2_telethon_experiment_2012';
exp_dir = '/Volumes/lacie-temp-external/vpn_screen/set_1_telethon_experiment_2012';
cd(exp_dir);
genotypes = dir(exp_dir);

for i = 1:numel(genotypes);
    if ~sum(strcmpi(genotypes(i).name,{'.','..','DS_STORE','thumbs'}))
        if ~sum(strcmpi([genotypes(i).name '_summary'],dir(fullfile(exp_dir,genotypes(i).name))));
            try
                geno = tfAnalysis.import(fullfile(exp_dir,genotypes(i).name),'all');
                eval([genotypes(i).name '_summary = geno;'])
                save(fullfile(exp_dir,genotypes(i).name,[genotypes(i).name '_summary']),[genotypes(i).name '_summary']);
            catch proc_err
                disp(proc_err)
                genotypes(i).name
            end
        else
            disp([genotypes(i).name ' already processed'])
        end
    end
end