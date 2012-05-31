function Push(folder_selection, assay_type, varargin)
%TFPUSH Push all experiments in a given folder to the database
%   function Push(folder_selection, assay_type, num_experiments)
%
%   As long as the file system looks like the following this will work:
%       SELECTED FOLDER > SUBDIVISION FOLDERS > INDIVIDUAL EXPERIMENT
%       FOLDERS
%       The subdivision doesn't matter as long as what is in the bottom
%       level has everything 
    try
        condition_file = folder_selection;
        genotypes = dir(condition_file); genotypes = {genotypes.name}; 
        genotypes = genotypes(3:end);
    catch fsErr
        disp(fsErr.message)
        disp('Possible bad folder selection')
        error(fsErr)
    end
    
    % Get all the individual experiments, add to a list
    experiments = [];
    for i = 1:numel(genotypes)        
        genotype_file = fullfile(condition_file,genotypes{i});
        exps = dir(genotype_file); exps = {exps.name}; 
        exps = exps(3:end);
        for e = 1:numel(exps)
            experiments = [experiments, {fullfile(genotype_file, exps{e})}];
        end
    end
    
    if nargin > 2 && varargin{1} <= numel(experiments)
        exp_range = 1:varargin{1};
    elseif nargin > 2 && varargin{1} > numel(experiments)
        error('There are not that many experiments in the selected folder')
    else
        exp_range = 1:numel(experiments);
    end
    
    disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    disp('                              FlyNet                                    ')
    fprintf('\n %d experiments to process from folder: %s \n',numel(experiments),condition_file');
    for i = exp_range
        fprintf('Loading %d of %d (selected)...', i, numel(exp_range))
        switch assay_type
            case 'tf'
            exp = tfAnalysis.import(experiments{i});
            case 'ff'
            exp = ffAnalysis.import(experiments{i});
            otherwise
                error('Assay type must be specified in the second argument: tf or ff')
        end
        fprintf('uploading with %s import... ',assay_type)        
        FlyNet.Add(exp);
        fprintf('done! \n')
    end
end