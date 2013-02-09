function geno_data = load_geno_group_summary_files(geno_names,data_location)

addpath(genpath('/Users/stephenholtz/matlab-utils'))

for g = 1:numel(geno_names)
    [summary_file,summary_filepath] = returnDirFileList(fullfile(data_location,geno_names{g}),'summary.mat');
    load(summary_filepath{:});

    geno_data{g} = tfAnalysis.ExpSet(eval(summary_file{1}(1:end-4))); %#ok<*AGROW>
end

end