function save_geno_group_summary_files(geno_names,data_location,overwrite)

    for i = 1:numel(geno_names) %#ok<*UNRCH>
        
        summary_filename = [geno_names{i} '_summary'];
        save_location = fullfile(data_location,geno_names{i},summary_filename);
        
        if overwrite && exist([save_location '.mat'],'file')
            delete(save_location)
        end
        
        if ~exist([save_location '.mat'],'file')
            geno = tfAnalysis.import(fullfile(data_location,geno_names{i}),'all'); %#ok<*NASGU>
            eval([summary_filename ' = geno;']);
            save(save_location,summary_filename);
        end
    
    end
    
end