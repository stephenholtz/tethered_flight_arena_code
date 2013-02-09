function save_geno_group_summary_files(geno_names,data_location)

    for i = 1:numel(geno_names) %#ok<*UNRCH>
        geno = tfAnalysis.import(fullfile(data_location,geno_names{i}),'all'); %#ok<*NASGU>
        summary_filename = [geno_names{i} '_summary'];
        eval([summary_filename ' = geno;']);
        save(fullfile(data_location,geno_names{i},summary_filename),summary_filename);
    end
    
    
end