% Make summary files of each genotype.

exp_dir = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';

cd(exp_dir); %#ok<*UNRCH>
genotypes = dir(exp_dir);

for i = 1:numel(genotypes);
    if genotypes(i).isdir && ~sum(strcmpi(genotypes(i).name,{'.','..','.DS_STORE','DS_Store','.thumbs'}))
        exp_dir_contents = dir(fullfile(exp_dir,genotypes(i).name));
        exp_dir_contents = {exp_dir_contents.name};
        if ~sum(cell2mat(strfind(exp_dir_contents,'_summary')))
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

clear genotypes i