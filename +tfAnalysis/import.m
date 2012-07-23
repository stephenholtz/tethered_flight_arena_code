classdef import < handle
 % Expects a data file path, or several comma-separated paths
 % will also take a top level (i.e. genotype) file and all
 % contents if the second argument is 'all'. Populate the file
 % information/meta/cond information
    properties (Access = private)
        %------------------------------------------------------------------
        % Files with local, temporary fs information
        temp_info
        data_root_path
        data_file_path
    end
    
    properties
        %------------------------------------------------------------------
        % The only object returned
        experiment
    end
    
    methods
        function [self] = import(varargin)
            % Expects a data file path, or several comma-separated paths
            % will also take a top level (i.e. genotype) file and all
            % contents if the second argument is 'all'. Populate the file
            % information/meta/cond information
            
            %--------------------------------------------------------------
            % Generate a list to iterate over
            %--------------------------------------------------------------
            if nargin == 1;
                % a cell array of file names
                if iscell(varargin{1})
                    exps = varargin{1};
                % a single file name
                elseif ischar(varargin{1})
                    exps{1} = varargin{1};
                end
            else
                % top level folder as first arg, 'all' as second
                if nargin == 2 && ischar(varargin{nargin}) && strcmpi(varargin{nargin},'all')
                    genotype_file = varargin{1};
                    experiments = dir(genotype_file); experiments = {experiments.name}; 
                    experiments = experiments(3:end); exps = [];
                    if isempty(experiments)
                        error_string = ['Iteratable list of experiments not found in ' genotype_file];
                        error(error_string) 
                    end
                    for e = 1:numel(experiments)
                        exps = [exps, {fullfile(genotype_file, experiments{e})}];
                    end
                    % error check for .DS_store on OSX
                    if strfind(exps{1},'.DS_Store')
                        exps = exps(2:end);
                    end
                elseif nargin == 2 && ischar(varargin{1}) && isnum(varargin{2})
                    genotype_file = varargin{1};
                    experiments = dir(genotype_file); experiments = {experiments.name}; 
                    experiments = experiments(3:end); exps = [];
                    if varargin{2} > numel(experiments)
                        fprintf('%d experiments requested, only %d exist',varargin{2},numel(experiments))
                        error('Select less experiments');
                    end
                    if isempty(experiments)
                        error_string = ['Experiment not found in ' genotype_file];
                        error(error_string)
                    end
                    for e = 1:numel(experiments)
                        exps = [exps, {fullfile(genotype_file, experiments{e})}];
                    end
                    % error check for .DS_store on OSX
                    if strfind(exps{1},'.DS_Store')
                        exps = exps(2:end);
                    end
                % iterate over many files
                else
                for i = 1:nargin
                    if ischar(varargin{i})
                        exps{i} = varargin{i};
                    else
                        error('invalid argument to import')
                    end
                end
                end
            end
            %--------------------------------------------------------------
            % Important, the central iterator for taking data into the
            % objects. This is tf specific.
            %--------------------------------------------------------------
            for i  = 1:numel(exps)
                set_get_experiment_info(self,exps{i});
                
                % Parse the raw experiment data
                parsed_data = get_parsed_data(self);
                
                % Fit into the Experiment/Trial/Data Framework
                self.experiment{i} = populate_experiment_metadata_obj(self);
                
                % All trials/data now (first recover info from parsed_data)
                trial = populate_trial_data_obj(self, parsed_data);
                
                % Since there is no trial.main right now, this suffices.
                if numel(trial) == 1;
                    self.experiment{i}.trial{1} = trial;                                    
                else
                    self.experiment{i}.trial = trial;                                    
                end
                % Apply the main functions to the object
                self.experiment{i} = self.experiment{i}.main;
            end
        end
        
        function set_get_experiment_info(self,data_filepath)
            try
            condition_mat = dir(fullfile(data_filepath, 'conditions.mat'));
            load(fullfile(data_filepath, condition_mat.name))
            metdata_mat = dir(fullfile(data_filepath, 'metadata.mat'));
            load(fullfile(data_filepath,metdata_mat.name))
            data_file = dir(fullfile(data_filepath, '*.daq'));
            catch file_error
               disp('Problem finding/loading metadata.mat, conditions.mat or finding *.daq')
               rethrow(file_error)               
            end
            self.data_root_path = data_filepath;
            self.data_file_path = data_file.name;
            self.temp_info.meta = metadata;
            self.temp_info.cond = conditions;
        end
        
        function parsed_data = get_parsed_data(self)
            % Process the daq file to get individual trials. And to get the
            % cond_num to associate with the trial_metadata (v. important)                       
            try
                raw_data_file = (fullfile(self.data_root_path, self.data_file_path));            
                condition_lengths = [];
                for i = 1:numel(self.temp_info.cond)
                   condition_lengths = [condition_lengths self.temp_info.cond(i).Duration]; %#ok<*AGROW>
                end
                % parsed_data = a cell array {trial_reps x diff_conditions} 
                try
                    [parsed_data, ~, ~] = tfAnalysis.parse_tf_data(raw_data_file,condition_lengths);
                catch err
                    disp(err.message)
                    warning('Parse_tf_data failed with given condition lengths, using 90% of given lengths.') %#ok<WNTAG>
                    [parsed_data, ~, ~] = tfAnalysis.parse_tf_data(raw_data_file,condition_lengths*.9);                    
                end
            catch parseErr
                disp('Error getting condition lengths or parsing raw data')
                rethrow(parseErr)
            end
        end
        
        function experiment = populate_experiment_metadata_obj(self)
            % THIS IS WHERE THE METADATA FILE IS CONVERTED INTO AN OBJECT
            % THAT WILL BE ADDED TO THE DATABASE! i.e. ExperimentName from
            % the meta file is translated to experiment_name in the oblect
            experiment = tfAnalysis.Experiment;
            % add all of the fields that can be simply loaded from
            % temp_info to the experiment class
            experiment.line_name            = self.temp_info.meta.Line;            
            experiment.experiment_name      = self.temp_info.meta.ExperimentName;
            experiment.assay_type           = self.temp_info.meta.AssayType;
            experiment.protocol             = self.temp_info.meta.Protocol;
            experiment.date_time            = self.temp_info.meta.DateTime;
            experiment.effector             = self.temp_info.meta.Effector;
            experiment.sex                  = self.temp_info.meta.Sex;
            experiment.dob                  = self.temp_info.meta.DoB;
            experiment.light_cycle          = self.temp_info.meta.LightCycle;
            experiment.arena                = self.temp_info.meta.Arena;
            experiment.experimenter         = self.temp_info.meta.Experimenter;
            experiment.head_glued           = self.temp_info.meta.HeadGlued;
            experiment.daq_file             = self.temp_info.meta.daqFile;
            experiment.chr2                 = self.temp_info.meta.Chromo2;
            experiment.chr3                 = self.temp_info.meta.Chromo3;
            experiment.temp_unshift_time    = self.temp_info.meta.temp_unshift_time;
            experiment.temp_shift_time      = self.temp_info.meta.temp_shift_time;
            experiment.temp_unshifted       = self.temp_info.meta.temp_unshifted;
            experiment.temp_shifted         = self.temp_info.meta.temp_shifted;
            experiment.temp_experiment      = self.temp_info.meta.temp_experiment;
            experiment.temp_ambient         = self.temp_info.meta.temp_ambient;
            experiment.humidity_ambient     = self.temp_info.meta.humidity_ambient;
            experiment.note                 = self.temp_info.meta.note;
            experiment.fly_tag              = self.temp_info.meta.fly_tag;
            
        end
        
        function trial = populate_trial_data_obj(self, parsed_data)
            i = 0;
            for index = 1:numel(parsed_data{1})
                if ~isempty(parsed_data{1}{index})
                    i = i + 1;
                    
                    [rep_num, cond_num] = ind2sub(size(parsed_data{1}),index);
                    
                    trial{i} = tfAnalysis.Trial;
try
                    % Populate trial
                    trial{i}.cond_num           = cond_num; % Important
                    trial{i}.pat_id             = self.temp_info.cond(cond_num).PatternID;
                    trial{i}.gains              = self.temp_info.cond(cond_num).Gains;
                    trial{i}.mode               = self.temp_info.cond(cond_num).Mode;
                    trial{i}.duration           = self.temp_info.cond(cond_num).Duration;
                    trial{i}.init_pos           = self.temp_info.cond(cond_num).InitialPosition;
                    trial{i}.func_freq_x        = self.temp_info.cond(cond_num).FuncFreqX;
                    trial{i}.pos_func_x         = self.temp_info.cond(cond_num).PosFunctionX;
                    trial{i}.func_freq_y        = self.temp_info.cond(cond_num).FuncFreqY;
                    trial{i}.pos_func_y         = self.temp_info.cond(cond_num).PosFunctionY;
                    trial{i}.vel_func           = self.temp_info.cond(cond_num).VelFunction;
                    trial{i}.voltage            = self.temp_info.cond(cond_num).Voltage;
                    trial{i}.pos_func_name_x    = self.temp_info.cond(cond_num).PosFuncNameX;
                    trial{i}.pos_func_name_y    = self.temp_info.cond(cond_num).PosFuncNameY;
                    trial{i}.pattern_name       = self.temp_info.cond(cond_num).PatternName;
                    trial{i}.trial_name         = cond_num;
                    trial{i}.rep_num            = rep_num;
catch
    'barf'
end
                    % might want/need to add these in for old experiments
                    % -- for now, check if they are there and then use
                    try
                        trial{i}.panel_cfg_num      = self.temp_info.cond(cond_num).PanelCfgNum;
                        trial{i}.panel_cfg_name     = self.temp_info.cond(cond_num).PanelCfgName;
                    catch
                        trial{i}.panel_cfg_num      = 'null';
                        trial{i}.panel_cfg_name     = 'null';
                    end
                    
                    % Add data fields
                    data = tfAnalysis.Data;
                    
                    % Populate data
                    data.left_amp       = parsed_data{1}{index}.left_amp;
                    data.x_pos          = parsed_data{1}{index}.x_pos;
                    data.right_amp      = parsed_data{1}{index}.right_amp;
                    data.y_pos          = parsed_data{1}{index}.y_pos;
                    data.wbf            = parsed_data{1}{index}.wbf;
                    data.voltage_signal = parsed_data{1}{index}.voltage;
                    data.lmr            = parsed_data{1}{index}.lmr;
                    
                    % Do all of the main functions on the object
                    trial{i}.data{1} = data.main;      
                end
            end
        end
    end
end