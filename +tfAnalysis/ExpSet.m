classdef ExpSet < handle
    % ExpSet will aggregate experiments of one kind (for now). 
    % This class is used to populate vectors for plotting, and sorting
    % through experiments
    
    properties
        protocol
        grouped_conditions        
        sym_conditions
        
        % scaling factors for each experiment
        exp_scaling_factors
        mean_turning_resp
        
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
            [self.exp_scaling_factors, self.mean_turning_resp] = self.get_scaling_factors();
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
            % outdated... and not necessary for current analysis
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
        
        function [exp_scaling_factors, mean_turning_resp] = get_scaling_factors(self)
            % Scaling factor is a per experiment scaling factor determined
            % by the whole genotype's mean turning
            
            daq_channel = 'lmr';
            
            % get all of the condition numbers, except for the closed loop
            % portion (the last condition number)
            for i = 1:(numel(self.experiment{1}.cond_rep_index)-1)
                condition_matrix{i} = i;
            end
            
            overall_turning = mean(abs(cell2mat(get_trial_data_set(self,condition_matrix,daq_channel,'mean','no','exp',0))),2);
            
            mean_turning_resp = mean(overall_turning);
            
            for exp_num = 1:numel(self.experiment)
                exp_scaling_factors(exp_num) = overall_turning(exp_num)/mean_turning_resp;
            end
            
        end
        
        function [cond_data, sem] = get_trial_data(self,...
                cond_num_mat,daq_channel,computation,use_sym_conds,average_type,normalization_flag,num_samples)
            % [cond_data sem] = get_trial_data(self,cond_num_mat,daq_channel,computation,use_sym_conds,average_type)
            
            if ~exist('num_samples','var')
                get_samples = @(vec)(vec(:));
            else
                get_samples = @(vec)(vec(num_samples));
            end
            
            % Get all of the data in one giant cell array to work on
            % if the daq field is something that cannot simply be flipped
            % and averaged (i.e. wbf, left wba, right wba) to get symmetry,
            % need to pull out the correct fields for comparison
            switch use_sym_conds
                % If looking at left_amp, then the proper average is
                % right_amp in the symmetric condition
                case {1,'yes','true'}
                    switch daq_channel
                        case {'left_amp'}
                            temp_cond_data(:,1) = return_multi_experiment_cond_data(self,cond_num_mat(:,1),'left_amp',normalization_flag,get_samples);
                            temp_cond_data(:,2) = return_multi_experiment_cond_data(self,cond_num_mat(:,2),'right_amp',normalization_flag,get_samples);
                        case {'right_amp'}
                            temp_cond_data(:,1) = return_multi_experiment_cond_data(self,cond_num_mat(:,1),'right_amp',normalization_flag,get_samples);
                            temp_cond_data(:,2) = return_multi_experiment_cond_data(self,cond_num_mat(:,2),'left_amp',normalization_flag,get_samples);
                        otherwise
                            temp_cond_data = return_multi_experiment_cond_data(self,cond_num_mat,daq_channel,normalization_flag,get_samples);
                    end
                    
                otherwise
                    temp_cond_data = return_multi_experiment_cond_data(self,cond_num_mat,daq_channel,normalization_flag,get_samples);
            end

            % Proper symmetric conditions depends on what field is being
            % used
            switch use_sym_conds
                case {1,'yes','true'}
                    switch daq_channel
                        case {'lmr','x_pos','y_pos'}
                            if size(temp_cond_data,2) == 2
                                for j = 1:size(temp_cond_data,1)
                                    temp_cond_data{j,2} = -temp_cond_data{j,2};
                                end
                            end
                        case {'left_amp','right_amp','wbf'}
                            % Nothing needs to ge changed, averaging etc.,
                            % happens below.
                        otherwise
                            error('Symmetric conditions not defined for specified daq_channel')
                    end
            end
            
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
                    sem = std(cond_data)/(size(cond_data,1)^(1/2));
                    
                case {'exp','experiment','fly',1}
                    % Return per experiment averages (over sym conds if specified)
                    cond_data = [];
                    sem = [];
                    
                    switch use_sym_conds
                        case {1,'yes','true'}
                            if size(temp_cond_data,2) == 2
                                temp_cell_array = [];
                                for j = 1:size(temp_cond_data,1)
                                    if ~isempty(temp_cond_data{j,2});
                                    temp_cell_array{j,1} = [temp_cond_data{j,1}; temp_cond_data{j,2}];
                                    end
                                end
                                % Is there a way to delete cells?
                                temp_cond_data = temp_cell_array;
                            end
                    end
                    
                    exp_iter = 0;
                    for g = 1:numel(temp_cond_data)
                        if ~isempty(temp_cond_data{g})
                            exp_iter = exp_iter + 1;
                            if size(temp_cond_data{g},1) > 1
                                sem(exp_iter,:) = std(temp_cond_data{g})/(size(temp_cond_data{g},1)^(1/2));
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
        
        function [cond_data sem] = get_trial_data_set(self,...
                cond_num_mat,daq_channel,computation,use_sym_conds,average_type,normalization_flag,num_samples)
        % Return a set of points from the get_trial_data method.
        % gets rid of my innermost for loop of several figure making
        % functions... output works directly with tfPlot.timeseries and
        % tfPlot.tuning_curve
            
            if ~exist('num_samples','var')
                
                for i = 1:numel(cond_num_mat)
                    [cond_data{i}, sem{i}] = self.get_trial_data(cond_num_mat{i},daq_channel,computation,use_sym_conds,average_type,normalization_flag);
                end
                
            else
                
                for i = 1:size(cond_num_mat,1)
                    [cond_data{i}, sem{i}] = self.get_trial_data(cond_num_mat{i},daq_channel,computation,use_sym_conds,average_type,normalization_flag,num_samples);
                end
                
            end
        
        end
        
        function [cond_data sem] = get_corr_trial_data(self,...
                cond_num_mat,daq_channel_1,daq_channel_2,average_type,num_samples)
            % average_type is either:
            %   {'none',0} (returns each trial),
            %   {'exp','experiment','fly',1} (returns each experiment averaged)
            %   {'all',2} (returns all experiments averaged)
            % all of the average types calculate the correlation of each
            % trial first and then perform averaging (the only correct way to do this!!)
            %
            % corr_type is just a placeholder variable, will add other
            % functions if needed
            
            
            % Function performed before averaging
            computation = 'mean';
            switch computation
                case {'mean',2}
                    resp_func = @mean;
                case {'median','med',3}
                    resp_func = @median;
                otherwise
                    resp_func = @mean;
            end
            
            if ~exist('num_samples','var')
                get_samples = @(vec)(vec(:));
            else
                get_samples = @(vec)(vec(num_samples));
            end
            
            % Get all of the data in two arrays to do a corr of each
            % component on
            temp_cond_data_1 = return_multi_experiment_cond_data(self,cond_num_mat,daq_channel_1,0,get_samples);
            
            temp_cond_data_2 = return_multi_experiment_cond_data(self,cond_num_mat,daq_channel_2,0,get_samples);
            
            % Calculate the cross correlation on a trial by trial basis and
            % then use this value for the rest of the computations in the
            % function.
            % This is the way john did it in his telethon: file
            % called stripe_figure_11_26_2011.m ... his window was
            % 75 because he downsampled, I still have full res.
            
            normalize = @(vec)(vec-mean(vec))/(max(abs(vec))-mean(vec));
            
            for g = 1:numel(temp_cond_data_1)
                
                for k = 1:size(temp_cond_data_1{g},1)
                    
                    norm_sig_1 = normalize(get_samples(temp_cond_data_1{g}(k,:)));
                    norm_sig_2 = normalize(get_samples(temp_cond_data_2{g}(k,:)));
                    
                    [corr_coef, lags] = xcorr(norm_sig_1,norm_sig_2,150,'coeff');
                    
                    [max_corr{g}{k}, max_corr_ind] = max(corr_coef);
                    
                    % Currently unused. The lag b/n the stim and the
                    % response in absolute time.
                    max_corr_lag{g}{k} = lags(max_corr_ind(1));
                    
                end
            end
            
            switch average_type
                
                case {'none',0}
                    % No averaging return all trials
                    cond_data = [];
                    
                    row_iter = 0;
                    for g = 1:numel(max_corr)
                        for k = 1:numel(max_corr{g})
                            row_iter = row_iter + 1;
                            cond_data(row_iter,:) = max_corr{g}{k};
                        end
                    end
                    sem = 0;
                    
                case {'exp','experiment','fly',1}
                    % Return per experiment averages
                    cond_data = [];
                    sem = [];
                    
                    exp_iter = 0;
                    for g = 1:numel(max_corr)
                        if ~isempty(max_corr{g})
                            exp_iter = exp_iter + 1;
                            if numel(max_corr{g}) > 1
                                sem(exp_iter,:) = std([max_corr{g}{:}])/(numel(max_corr{g})^(1/2));
                                cond_data(exp_iter,:) = mean(resp_func([max_corr{g}{:}]));
                            else
                                sem(exp_iter,:) = zeros(1,numel(max_corr{g}));
                                cond_data(exp_iter,:) = resp_func(max_corr{g});
                            end
                        end
                    end                  
                    
                case {'all',2}
                    % Return averaged experiments (over sym conds if present)                       
                    exp_iter = 0;
                    cond_data = [];
                    
                    for e = 1:numel(max_corr)
                        
                    % average an experiment's trials
                        if size(max_corr{e},1) > 1
                            cond_data(e) = nanmean(resp_func([max_corr{e}{:}])); %#ok<*AGROW>
                        elseif size(max_corr{e},1) == 1
                            cond_data(e) = resp_func([max_corr{e}{:}]);
                        end
                    end
                    
                    % average all of the experiments together
                    if numel(cond_data) > 1
                        sem = nanstd(cond_data)/sqrt(numel(cond_data));                        
                        cond_data = nanmean(cond_data);                       
                    elseif size(cond_data,1) == 1
                        sem = zeros(1,numel(cond_data));
                    end
                    
                otherwise
                    error('Invalid average_type selection')
            end                
        end
        
        function [cond_data sem] = get_corr_trial_data_set(self,...
                cond_num_mat,daq_channel_1,daq_channel_2,average_type,num_samples)
            
            if ~exist('num_samples','var')
                
                for i = 1:size(cond_num_mat,1)
                    [cond_data{i} sem{i}] = self.get_corr_trial_data(cond_num_mat{i},daq_channel_1,daq_channel_2,average_type);
                end
                
            else
                
                for i = 1:size(cond_num_mat,1)
                    [cond_data{i} sem{i}] = self.get_corr_trial_data(cond_num_mat{i},daq_channel_1,daq_channel_2,average_type,num_samples);
                end
                
            end        
        
        
        end
        
        function cond_data = return_multi_experiment_cond_data(self,...
                cond_num_mat,daq_channel,normalization_flag,get_samples)
            cond_data = {};
            for g = 1:numel(cond_num_mat)
                exp_iter = 0;
                for i = 1:numel(self.experiment)
                    if ~isempty(self.experiment{i})
                        exp_iter = exp_iter + 1;
                        rep_idx = self.experiment{i}.cond_rep_index{cond_num_mat(g)};
                        
                        for j = 1:numel(rep_idx);
                            % Check for isvalid
                            if self.experiment{exp_iter}.trial{rep_idx(j)}.data{1}.isvalid
                                if ~normalization_flag
                                    cond_data{i,g}(j,:) = get_samples(getfield(self.experiment{exp_iter}.trial{rep_idx(j)}.data{1},daq_channel)); %#ok<*FNDSB,*GFLD>
                                else
                                    cond_data{i,g}(j,:) = get_samples(getfield(self.experiment{exp_iter}.trial{rep_idx(j)}.data{1},daq_channel))/self.exp_scaling_factors(exp_iter);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end