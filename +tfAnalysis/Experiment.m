classdef Experiment < handle & ExpAgg
    % EXPERIMENT has all of the data for a single experiment, metadata and
    %   raw data for each repetition of all conditions.
    %
    %   EXPERIMENT and its sub objects are automatically populated by
    %   tfAnalysis.import
    
    properties
        selected
        
        % Metadata for experiment (not condition specific)
        sex
        dob
        light_cycle
        arena
        head_glued
        room_temp
        experiment_name
        assay_type
        protocol
        date_time
        chr2
        chr3
        effector
        line_name
        daq_file
        temp_unshift_time
        temp_shift_time
        temp_unshifted
        temp_shifted
        temp_experiment
        temp_ambient
        humidity_ambient
        fly_tag
        note
        % Grouped conditions, cond2/4 = transformed to cond1/3, form below
        % {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
        % [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
        grouped_conditions
        
        % Logical of which trials should be used in calculations (passed up
        % the object tree), taken from Data object.
        successful_trials
        
        % Experimental data is grouped by unique condition in a cell array
        % for each element of the Data object. voltage_signal is not stored
        left_amp
        x_pos
        right_amp
        y_pos
        wbf
        lmr
        
        % A cell array of trials
        trial
        
        % A cell array MxN where M = condition repetitions and N =
        % condition numbers and the values are the trial indecies in the
        % experiment
        cond_rep_index
    end
    
    methods
        function self = Experiment()
        end
        
        function self = main(self)
            % Default the experiment to selected
            self.selected = 1;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            % DELETE THIS ONCE GENOTYPE IS GONE!
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Make an array of successful trial indicies
            self.successful_trials = zeros(1,numel(self.trial));
            for g = 1:numel(self.trial)
                self.successful_trials(g) = (self.trial{g}.data{1}.successful);
            end
            
            % Populate the condition specific data cells
            self = group_unique_successful_trial_data(self);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % DOWN TO HERE!
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Delete the failed conditions
            self = eliminate_failed_trials(self);            
            
        end
        
        function self = eliminate_failed_trials(self)
            % get rid of all the failed trials, not worth keeping them...
            % go through each of the trials and delete them if they sucked
            for g = 1:numel(self.trial)
                if ~self.trial{g}.data{1}.successful
                    self.trial{g}.data{1}.delete;
                    % can now use either: 1) self.trial{g}.data{1}.isvalid
                    % or 2) isa(self.trial{g}.data{1},'tfAnalysis.Data') to
                    % see if it has been deleted...
                end
            end
        end
        
        function self = make_cond_rep_index(self)
            % creates an MxN cell array of (successful) trial indecies to
            % be used when aggregating data from multiple flies
            
            
        end
        
        function self = group_unique_successful_trial_data(self)
            % group all of the successful instances of unique conditions in
            % cell arrays for later analysis
            
            cond_num_list = zeros(1,numel(self.trial));
            for g = 1:numel(self.trial)
                cond_num_list(g) = (self.trial{g}.cond_num);
            end
            
            % preallocation here really helps
            for unique_index = unique(cond_num_list);
                cond_indicies = find(unique_index == cond_num_list);
                succ_cond_indicies = cond_indicies(self.successful_trials(cond_indicies)==1);
                if sum(succ_cond_indicies)
                
                temp_left_amp   = zeros(numel(succ_cond_indicies),size(self.trial{succ_cond_indicies(1)}.data{1}.wbf,2));
                temp_right_amp  = temp_left_amp;
                temp_wbf        = temp_left_amp;
                temp_x_pos      = temp_left_amp;
                temp_y_pos      = temp_left_amp;
                temp_lmr        = temp_left_amp;
                
                iter = 1;
                for ind = succ_cond_indicies
                    temp_left_amp(iter,:) = self.trial{ind}.data{1}.left_amp;
                    temp_right_amp(iter,:) = self.trial{ind}.data{1}.right_amp;
                    temp_wbf(iter,:) = self.trial{ind}.data{1}.wbf;
                    temp_x_pos(iter,:) = self.trial{ind}.data{1}.x_pos;
                    temp_y_pos(iter,:) = self.trial{ind}.data{1}.y_pos;
                    temp_lmr(iter,:) = self.trial{ind}.data{1}.lmr;
                    
                    iter = iter+1;
                end
                
                self.left_amp{unique_index} = temp_left_amp;
                self.right_amp{unique_index} = temp_right_amp;                
                self.wbf{unique_index} = temp_wbf;
                self.x_pos{unique_index} = temp_x_pos;
                self.y_pos{unique_index} = temp_y_pos;
                self.lmr{unique_index} = temp_lmr;
                end
            end
        end
        
        function self = clear_nulls(self)
            fields = properties(self);
            for i = 1:numel(fields)
               if ischar(getfield(self,fields{i})) && sum(strcmpi(getfield(self,fields{i}),'Null'))
                    self = setfield(self,fields{i},[]);
               end
            end
        end
        
    end
end