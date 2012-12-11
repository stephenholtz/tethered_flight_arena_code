function progress_struct = track_progress(experiment_folder,ts_flag)
% function [progress_struct] = track_progress(experiment_folder)
% returns a struct with the number of experiments perfomed on each
% genotype within the folder and the total number.
%
% Pretty handy.

if ~exist('ts_flag','var')
    ts_flag = false;
end

geno_dir = dir(experiment_folder);

geno_iter = 1;
% For each of the genotypes
for i = 1:numel(geno_dir)
    
    if geno_dir(i).isdir && ~sum(strcmpi(geno_dir(i).name,{'.','..','.DS_Store','.thumbsdb'}))
        
        exp_dir = dir(fullfile(experiment_folder,geno_dir(i).name));
        
        rt_exp_count = 0;
        
        if ts_flag 
            ts_exp_count = 0;
        end
        
        % For all of one genotype's experiments
        for g = 1:numel(exp_dir)
            
            if exp_dir(g).isdir && ~sum(strcmpi(geno_dir(i).name,{'.','..','.DS_Store','.thumbsdb'}))
                
                % Add up the number of .daq files for temp shift and room
                % temp experiments
                if ~isempty(dir(fullfile(experiment_folder,geno_dir(i).name,exp_dir(g).name,'*.daq')))
                    
                    load(fullfile(experiment_folder,geno_dir(i).name,exp_dir(g).name,'metadata.mat'))
                    if metadata.temp_experiment < 30
                        rt_exp_count = rt_exp_count + 1;
                    else
                        if ts_flag 
                            ts_exp_count = ts_exp_count + 1;
                        end
                    end
                end
                
            end
            % not good practice...
            progress_struct.([geno_dir(i).name '_rt']) = rt_exp_count;
            
            if ts_flag 
                progress_struct.([geno_dir(i).name '_ts']) = ts_exp_count;
            end
        end

        geno_iter = 1 + geno_iter;
    end
end

end