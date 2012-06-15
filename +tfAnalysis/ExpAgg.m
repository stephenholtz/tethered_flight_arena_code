classdef ExpAgg < handle
    % ExpAgg will aggregate experiments of one kind (for now). 
    % This class is used to populate vectors for plotting, and sorting
    % through experiments
    
    properties
        protocol
        grouped_conditions        
        sym_conditions
        
        % cell array of experiments
        experiment
    end
    
    methods
        function self = ExpAgg(tf_analysis_object)
            if  ~isprop(tf_analysis_object,'experiment') || numel(tf_analysis_object.experiment) < 1 || ~isa(tf_analysis_object.experiment{1},'tfAnalysis.Experiment') 
                error('ExpAgg must take an object holding a cell array of tfAnalysis.Experiment objects of size > 0')
            end
            
            self.protocol = tf_analysis_object.experiment{1}.protocol;
            self.experiment = tf_analysis_object.experiment;
            self = populate_condition_properties(self);
            
        end
        
        function self = populate_condition_properties(self)
            % load the symmetric conditions from the protocol's folder
            found_file = 0;
            
            path_to_cond_func = which(self.protocol);
            protocol_folder = fileparts(path_to_cond_func);
            folder_contents = dir(protocol_folder);
            for i = 1:numel(folder_contents)
                if strcmp(folder_contents(i).name,'grouped_conds.m')
                    found_file = 1;
                end
            end
            
            if found_file
                cf = pwd;
                cd(protocol_folder)
                eval('grouped_conds'); % drop the .m to evaluate .m file...
                self.grouped_conditions = grouped_conditions; %#ok<*CPROP>
                self.sym_conditions = sym_conditions; %#ok<*CPROP>                
                cd(cf)
            end
        end
        
        function self = select(self,selection)
            switch lower(selection)
                case 'all'
                    for i = 1:numel(self.experiment)
                        self.experiment{i}.selected = 1;
                    end
                    
                case 'none'
                    for i = 1:numel(self.experiment)
                        self.experiment{i}.selected = 0;
                    end
                
                case 'arena5'
                    for i = 1:numel(self.experiment)
                        if strcmpi(self.experiment{i}.arena,'arena5');
                            self.experiment{i}.selected = 1;
                        else
                            self.experiment{i}.selected = 0;
                        end
                    end
                
                case 'arena6'
                    for i = 1:numel(self.experiment)
                        if strcmpi(self.experiment{i}.arena,'arena6');
                            self.experiment{i}.selected = 1;
                        else
                            self.experiment{i}.selected = 0;
                        end
                    end
                
                otherwise
                    error('Invalid selection')
            end
        end
        
        function [cond_data varargout] = return_trial_timeseries(self,cond_num_mat,daq_channel,average_type,use_sym_conds,sem_type)
            % return_trial_timeseries will return timeseries of trials,
            % averages, standard errors of multiple conditions across
            % experiments. It also will flip and average symmetrical
            % conditions if desired.
            %
            % average_type 1, all raw trials w/sym conds if use_sym_conds
            % average_type 2, per fly means w/sym conds if use_sym_conds
            % average_type 3, mean of fly means w/sym conds if use_sym_conds
            %
            % use_sym_conds tells the function what to do with other
            % elemings in cond_num_mat (i.e. use as symmmetric conds)
            % only works with TWO conditions now... (change to vector?)
            %
            % use_sym_conds 0, only return condition specified
            % use_sym_conds 1, also return/use negative of sym_conditions
            %
            % sem_type 0, do not return sem's
            % sem_type 1, if possible return sem's
            % sem_type 2, if possible return sem's as +/- the means

            temp_cond_data = {};
            for p = 1:numel(cond_num_mat)
            for i = 1:numel(self.experiment)
                % the number of reps within an experiment's condition
                for g = self.experiment{i}.cond_rep_index{p};
                    if self.experiment{i}.trial{cond_num_mat(p)}.data{1}.isvalid
                    temp_cond_data{i,p}(find(self.experiment{i}.cond_rep_index{p}==g),:) ...
                            = getfield(self.experiment{i}.trial{g}.data{1},daq_channel); %#ok<*FNDSB,*GFLD,AGROW>
                    end
                end
            end
            end
            
            % if possible.. work with potential symmetrical conditions
            if numel(cond_num_mat) > 1
                switch use_sym_conds
                    case 0
                        % do nothing
                    case 1
                        % change the symmetric conditions to negatives
                        for j = 1:size(temp_cond_data,2)
                            temp_cond_data{j,2} = -temp_cond_data{j,2};
                        end
                    otherwise
                        error('Invalid use_sym_conds selection')
                end
            end
            
            switch average_type
                case {0,1}
                    % No averaging, just clump it up, dog.
                    row_num = 0;
                    for g = 1:numel(temp_cond_data)
                        row_num = row_num + size(temp_cond_data{g},1);
                    end
                    cond_data = zeros(row_num,size(temp_cond_data{1},2));
                    
                    row_iter = 0;
                    for g = 1:numel(temp_cond_data)
                        for k = 1:size(temp_cond_data{g},1)
                            row_iter = row_iter + 1;
                            cond_data(row_iter,:) = temp_cond_data{g}(k,:);
                        end
                    end
                    if sem_type
                        sem = std(cond_data)/(size(cond_data,1)^-2);
                    end
                case 2
                    % Average the flies
                    cond_data = []; %% cannot preallocate, don't know how many are succsesfull!
                    sem = [];
                    
                    exp_iter = 0;
                    for g = 1:numel(temp_cond_data)
                        if ~isempty(temp_cond_data{g})
                            exp_iter = exp_iter + 1;
                            sem(exp_iter,:) = std(temp_cond_data{g})/(size(temp_cond_data{g},1)^-2);
                            cond_data(exp_iter,:) = mean(temp_cond_data{g});
                        end
                    end
                case 3
                    % Average flies (and sym conds together)
                    if size(temp_cond_data,2) == 2
                        exp_iter = 0;
                        for c = 1:size(temp_cond_data,1)
                            if ~isempty(temp_cond_data{g,1}) && ~isempty(temp_cond_data{g,2})
                                exp_iter = exp_iter + 1;
                                cond_data(exp_iter,:) = mean([temp_cond_data{1}; temp_cond_data{2}]);
                            end
                        end
                        sem = std(cond_data)/(size(cond_data,1)^-2);                        
                        cond_data = mean(cond_data);
                    else
                        error('number of conds not equal to two')
                    end
                otherwise
                    error('Invalid average_type selection')
            end

            switch sem_type
                case 0
                case 1
                    varargout{1} = sem;
                case 2
                    varargout{1} = cond_data + sem;
                    varargout{2} = cond_data - sem;
                otherwise
                    error('Invalid sem_type selection')
            end
                    
            end
        end
end