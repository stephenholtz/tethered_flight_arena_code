classdef ExpSet < handle
    % ExpSet will aggregate experiments of one kind (for now). 
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
        function self = ExpSet(varargin)
            if nargin
                self.main(varargin{1});
            end

        end
        
        function self = main(self,tf_analysis_object)
            if  ~isprop(tf_analysis_object,'experiment') || numel(tf_analysis_object.experiment) < 1 || ~isa(tf_analysis_object.experiment{1},'tfAnalysis.Experiment') 
                error('ExpSet must take an object holding a cell array of tfAnalysis.Experiment objects of size > 0')
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
        
        function [cond_data sem] = get_trial_data(self,...
                cond_num_mat,daq_channel,computation,use_sym_conds,average_type,num_samples)
            % [cond_data sem] = return_trial_response(self,cond_num_mat,daq_channel,computation,use_sym_conds,average_type)
            
            if ~exist('num_samples','var')
                get_samples = @(vec)(vec(:));
            else
                get_samples = @(vec)(vec(num_samples));
            end
            
            % Get all of the data in one giant cell array to work on
            temp_cond_data = return_multi_experiment_cond_data(self,cond_num_mat,daq_channel,get_samples);
            
            % Function performed before averaging i.e. nothing, trapz, etc.
            switch computation
                case {'none',0}
                    resp_func = @(x,~)x;
                case {'trapz',1}
                    resp_func = @trapz;
                case {'mean',2}
                    resp_func = @mean;
                case {'median','med',3}
                    resp_func = @median;
                case {'sum','total',4}
                    resp_func = @sum;
                otherwise
                    resp_func = @(x)x;
                    disp(resp_func)
            end
            
            % If specified, 'flip' the second condition of cond_num_mat
            switch use_sym_conds
                case {1,'yes','true'}
                    if size(temp_cond_data,2) == 2
                        for j = 1:size(temp_cond_data,1)
                            temp_cond_data{j,2} = -temp_cond_data{j,2};
                        end
                    end
            end
            
            switch average_type
                case {'none',0}
                    % No averaging
                    cond_data = [];
                    
                    row_iter = 0;
                    for g = 1:numel(temp_cond_data)
                        for k = 1:size(temp_cond_data{g},1)
                            row_iter = row_iter + 1;
                            cond_data(row_iter,:) = resp_func(temp_cond_data{g}(k,:));
                        end
                    end
                    sem = std(cond_data)/(size(cond_data,1)^-2);
                    
                case {'exp','experiment',1}
                    % Return per experiment averages
                    cond_data = [];
                    sem = [];
                    
                    exp_iter = 0;
                    for g = 1:numel(temp_cond_data)
                        if ~isempty(temp_cond_data{g})
                            exp_iter = exp_iter + 1;
                            if size(temp_cond_data{g},1) > 1
                                sem(exp_iter,:) = std(temp_cond_data{g})/(size(temp_cond_data{g},1)^-2);
                                cond_data(exp_iter,:) = mean(resp_func(temp_cond_data{g}));
                            else
                                sem(exp_iter,:) = zeros(1,numel(temp_cond_data{g}));
                                cond_data(exp_iter,:) = resp_func(temp_cond_data{g});
                            end
                        end
                    end
                    
                case {'all',2}
                    % Return averaged experiments (over sym conds if present)                       
                    exp_iter = 0;
                    temp_mean_mat = [];
                    
                    for e = 1:size(temp_cond_data,1)
                        
                        % average an experiment's trials
                        for c = 1:size(temp_cond_data(e,:),2)
                            if size(temp_cond_data{e,c},1) > 1
                                temp_mean_mat(c,:) = nanmean(resp_func(temp_cond_data{e,c},2)); %#ok<*AGROW>
                            elseif size(temp_cond_data{e,c},1) == 1
                                temp_mean_mat(c,:) = resp_func(temp_cond_data{e,c},2);
                            end
                        end
                        
                        % average across an experiment's sym trials
                        if ~isempty(temp_mean_mat)
                            exp_iter = exp_iter + 1;
                            if size(temp_mean_mat,1) > 1 
                                cond_data(exp_iter,:) = nanmean(temp_mean_mat,1);
                            else
                                cond_data(exp_iter,:) = temp_mean_mat;
                            end
                        end
                        
                        temp_mean_mat = [];
                    end
                    
                    % average all of the experiments together
                    if size(cond_data,1) > 1
                        sem = nanstd(cond_data)/sqrt(size(cond_data,1));                        
                        cond_data = nanmean(cond_data);                       
                    elseif size(cond_data,1) == 1
                        sem = zeros(1,numel(cond_data));
                    end
                    
                otherwise
                    error('Invalid average_type selection')
            end
        end
        
        function cond_data = return_multi_experiment_cond_data(self,...
                cond_num_mat,daq_channel,get_samples)
            cond_data = {};
            for g = 1:numel(cond_num_mat)
                for i = 1:numel(self.experiment)
                    rep_idx = self.experiment{i}.cond_rep_index{cond_num_mat(g)};
                    for j = 1:numel(rep_idx);
                        if self.experiment{i}.trial{rep_idx(j)}.data{1}.isvalid
                            cond_data{i,g}(j,:) = get_samples(getfield(self.experiment{i}.trial{rep_idx(j)}.data{1},daq_channel)); %#ok<*FNDSB,*GFLD>
                        end
                    end
                end
            end
        end
    end
end