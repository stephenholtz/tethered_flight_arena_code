classdef Experiment < handle
    % EXPERIMENT has all of the data for a single experiment, metadata and
    %   raw data for each repetition of all conditions.
    %
    %   EXPERIMENT and its sub objects are automatically populated by
    %   tfAnalysis.import
    %
    %   Recent: when flies that  escaped visual pruning made it to this
    %   level, things broke, so checks were added at higher levels for the
    %   method Experiment.quality
    
    properties
        % For selecting subsets of experiments
        selected
        
        % Metadata for experiment (not condition specific)
        sex
        dob
        light_cycle
        arena
        experimenter
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

        % A cell array of trials
        trial
        
        % A cell array {C}[r_inds] where C is the condition number and
        % r_inds are the indices in the trial field.
        cond_rep_index
        
    end
    
    methods
        function self = Experiment()
        end
        
        function self = main(self)
            % Default the experiment to selected
            self.selected = 1;
            self = eliminate_failed_trials(self);
            self = make_cond_rep_index(self);
        end
        
        function self = eliminate_failed_trials(self)
            % Delete failed trials
            for g = 1:numel(self.trial)
                if ~self.trial{g}.data{1}.successful
                    self.trial{g}.data{1}.delete;
                    % now: self.trial{g}.data{1}.isvalid == 0
                end
            end
        end
        
        function self = make_cond_rep_index(self)
            % Cell array {Cond_num}[Rep] 
            temp_rep_index = {};
            for g = 1:numel(self.trial)
                if self.trial{g}.data{1}.isvalid
                    temp_rep_index{self.trial{g}.rep_num,self.trial{g}.cond_num} = g; %#ok<*AGROW>
                end
            end
            
            % For each of the cols (condition numbers)
            for c = 1:size(temp_rep_index,2)
                self.cond_rep_index{c} = [];
                for r = 1:size(temp_rep_index,1)
                    self.cond_rep_index{c} = [self.cond_rep_index{c} temp_rep_index{r,c}];
                end
            end
        end
        
        function valid = quality(self)
            % This is kind of a hack: make the rep index, check for values,
            % then delete if it works. By far not the time limiting step.
            
            failed = 0;
            self = make_cond_rep_index(self);
            temp_success_index = [];

            for g = 1:numel(self.cond_rep_index)

                for r = 1:numel(self.cond_rep_index{g})
                    if ~self.trial{self.cond_rep_index{g}(r)}.data{1}.successful
                        temp_success_index{r} = 0;
                    else
                        temp_success_index{r} = 1;
                    end
                end

                if ~sum(cell2mat(temp_success_index))
                    failed = 1;
                end

                temp_success_index = [];

            end
                
            if failed
                valid = 0;
            else
                valid = 1;
            end
            
            self.cond_rep_index = [];
            
        end
        
        function self = clear_nulls(self)
            fields = properties(self);
            for i = 1:numel(fields)
               if ischar(getfield(self,fields{i})) && sum(strcmpi(getfield(self,fields{i}),'Null')) %#ok<*GFLD>
                    self = setfield(self,fields{i},[]); %#ok<*SFLD>
               end
            end
        end
        
    end
end