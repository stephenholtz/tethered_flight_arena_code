classdef ExpAgg < handle
    % ExpAgg will aggregate experiments of one kind (for now).
    
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
                eval('grouped_conds'); % drop the .m to evaluate it
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
        
        function [cond_data varargout] = return_trials(self,cond_num_cell,daq_channel,average_type,use_sym_conds,sem_flag)
            % average_type 1, all raw trials w/sym conds if use_sym_conds
            % average_type 2, per fly means w/sym conds if use_sym_conds
            % average_type 3, mean of fly means w/sym conds if use_sym_conds
            %
            % use_sym_conds tells the function what to do with other
            % elemings in cond_num_cell (i.e. use as symmmetric conds)
            % only works with TWO conditions now... (change to vector?)
            %
            % use_sym_conds 0, only return condition specified
            % use_sym_conds 1, also return/use negative of sym_conditions
            %
            % sem_flag 0, do not return sem's
            % sem_flag 1, if possible return sem's
            % sem_flag 2, if possible return sem's as +/- the means
            
            for i = 1:numel(self.experiment)
                if self.experiment{i}.selected
                    
                    
                    switch use_sym_conds
                        case 0
                            cond_data{1} = getfield(self.experiment{i}.trial{cond_num_cell{1}}.data{1},daq_channel); %#ok<*GFLD>
                        case 1
                            cond_data{1} = getfield(self.experiment{i}.trial{cond_num_cell{1}}.data{1},daq_channel); %#ok<*GFLD>
                        otherwise
                            error('Invalid use_sym_conds selection')
                    end
                    
                    switch average_type
                        case {0,1}
                            cond_data = [];
                        case 2
                            cond_data = [];
                        case 3
                            cond_data = [];
                        otherwise
                            error('Invalid average_type selection')
                    end
                    
                    switch sem_flag
                        case 0
                        case 1
                            varargout{1} = sem;
                        case 2
                            varargout{1} = sem + mean;
                            varargout{2} = sem + mean;
                        otherwise
                            error('Invalid sem_flag selection')
                    end
                end
            end
        end
        
    end
end