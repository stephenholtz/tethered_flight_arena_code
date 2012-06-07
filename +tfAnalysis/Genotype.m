classdef Genotype < handle
    %GENOTYPE Contains all the experiment objects for flies of a genotype
    %   All of the properties and methods for comparing trials of a given
    %   experimental type are in this class. Methods to make simple figures
    %   are also on this level As are some general fly health assessment
    %   figures. 
    %   Because at this level data can be aggregated many
    %   different ways, properties may be cell arrays, cell arrays of
    %   objects, or values. So, COMMENT ALL PROPERTIES AND METHODS! 
    %   Note: The data from this class is meant to be used for final figure
    %   production, not the figures from it.
    %
    %   TODO
    %   - General genotype quality assessment
    %   - Reps/fly, etc.,
    
    % Note:
    % To preserve the readability of the code, if only one data element
    % (array, value etc.,) exists, it is stored in a cell array. Indexing
    % into any data element requires at least self.property{num}. This gets
    % rid of a lot of logic for checking for number of elements.
    
    %% ------------META PROPERTIES-----------------------------------------
    properties
        % Cell array of experiment objects
        experiment
        
        % properties common to all experiments of the genotype
        line_name   %% added in
        assay_type
        protocol
        chr2
        chr3
        effector
        
        % properties that are determined by experiment metadata (props)
        dates_times         % Dates and times the experiments were run
        dobs                % Dates of birth of the flies
        light_cycles        % Light cycles of all the flies run
        arenas              % Arenas the flies were run in
        % all of the environmental data, stored in arrays for each
        % experiment
        temp_unshift_time
        temp_shift_time
        temp_unshifted
        temp_shifted
        temp_experiment
        temp_ambient
        humidity_ambient
        
        % Selected - for updating computations
        selected
        selected_inds
        
    end
    %% ------------AVERAGED EXPERIMENT PROPERTIES--------------------------
    properties
        % Some arrays of time series/values that come from each experiment,
        % basically regrouped trials across experiments. Accessed like:
        % mean_left_amp{cond_num}
        
        % Computed values from the array of data objects
        mean_left_amp
        mean_x_pos
        mean_right_amp
        mean_y_pos
        mean_wbf
        mean_lmr
        
        sem_left_amp
        sem_x_pos
        sem_right_amp
        sem_y_pos
        sem_wbf
        sem_lmr
        
    end
    %% ------------METHODS FOR POPULATING PROPERTIES-----------------------    
    methods
        
        function self = Genotype(varargin)
            if nargin == 1 && iscell(varargin{1})
                num_total_exps = numel(varargin{1});
                iter = 0; 
                self.experiment = [];
                self.selected_inds = [];
                
                for i = 1:num_total_exps;
                    if varargin{1}{i}.selected == 1;
                        iter = iter + 1;
                        self.experiment{iter} = varargin{1}{i}.clear_nulls;
                        if isempty(varargin{1}{iter}.wbf(1))
                            self.experiment{iter} = varargin{1}{i}.cpt_cond_data;
                        end
                        % Keep track of which ones need to be processed!
                        self.selected_inds = [self.selected_inds i];
                    end
                end    
                
                if numel(self.experiment)
                    self = populate_meta_props(self);
                    self.select('all'); % GETS RID OF BAD EXPERIMENTS
                    self = calculate_channel_means_sems(self);
                else
                    error('No experiments were selected to be analyzed by tfAnalysis.Genotype [Property: tfAnalysis.Experiment{i}.selected = 0 for all members]')
                end
            else
                error('Genotype input should be a cell of tfAnalysis.Experiment objects')
            end
            
            % free up space!
            % self.experiment = []; 
            for g = 1:numel(self.experiment)
                self.experiment{g}.trial = [];
                self.experiment{g}.successful_trials = [];
            end
        end
        
        function self = main(self)
            % If the constructor gets complicated, and it might, use the
            % main function.
        end
        
        function self = populate_meta_props(self)
            self.assay_type     = self.experiment{1}.assay_type;
            self.protocol       = self.experiment{1}.protocol;
            self.chr2           = self.experiment{1}.chr2;
            self.chr3           = self.experiment{1}.chr3;
            self.effector       = self.experiment{1}.effector;
            self.line_name      = self.experiment{1}.line_name;
            
            for i = 1:numel(self.selected_inds);
                    self.dates_times{i}         = self.experiment{i}.date_time;
                    self.dobs{i}                = self.experiment{i}.dob;
                    self.light_cycles{i}        = self.experiment{i}.light_cycle;
                    self.arenas{i}              = self.experiment{i}.arena;
                    self.temp_unshift_time{i}   = self.experiment{i}.temp_unshift_time;
                    self.temp_shift_time{i}     = self.experiment{i}.temp_shift_time;
                    self.temp_unshifted{i}      = self.experiment{i}.temp_unshifted;
                    self.temp_shifted{i}        = self.experiment{i}.temp_shifted;
                    self.temp_experiment{i}     = self.experiment{i}.temp_experiment;
                    self.temp_ambient{i}        = self.experiment{i}.temp_ambient;
                    self.humidity_ambient{i}    = self.experiment{i}.humidity_ambient;
                    % assumes all of the things are initially selected
                    self.selected{i}            = self.experiment{i}.selected;
            end
        end
        
        function mean_field_out = get_specific_experiment_level_means(self,field,condition)
        try
            % preallocate
            switch field
                case 'wbf'
                    temp_wbf            = [];
                case 'lmr'
                    temp_lmr            = [];
                case 'left_amp'
                    temp_left_amp       = [];
                case 'x_pos'
                    temp_x_pos          = [];
                case 'right_amp'
                    temp_right_amp      = [];
                case 'y_pos'
                    temp_y_pos          = [];                                
            end
            
            iter = 1;
            for i = 1:numel(self.selected)
                if self.selected{i} == 1
                    % go through each condition, generate a mean from
                    % within the experimental data
                    % for g = 1:numel(self.experiment{i}.wbf)
                    for g = condition;
                        if size(self.experiment{i}.wbf{g},1) > 1;
                            switch field
                                case 'wbf'
                                        temp_wbf{iter,1}        = mean(self.experiment{i}.wbf{g});
                                case 'lmr'
                                        temp_lmr{iter,1}        = mean(self.experiment{i}.lmr{g});
                                case 'left_amp'
                                        temp_left_amp{iter,1}   = mean(self.experiment{i}.left_amp{g});
                                case 'x_pos'
                                        temp_x_pos{iter,1}      = mean(self.experiment{i}.x_pos{g});
                                case 'right_amp'
                                        temp_right_amp{iter,1}  = mean(self.experiment{i}.right_amp{g});
                                case 'y_pos'
                                        temp_y_pos{iter,1}      = mean(self.experiment{i}.y_pos{g});
                            end                   
                        else
                            switch field
                                case 'wbf'
                                        temp_wbf{iter,1}        = self.experiment{i}.wbf{g};
                                case 'lmr'
                                        temp_lmr{iter,1}        = self.experiment{i}.lmr{g};
                                case 'left_amp'
                                        temp_left_amp{iter,1}   = self.experiment{i}.left_amp{g};
                                case 'x_pos'
                                        temp_x_pos{iter,1}      = self.experiment{i}.x_pos{g};
                                case 'right_amp'
                                        temp_right_amp{iter,1}  = self.experiment{i}.right_amp{g};
                                case 'y_pos'
                                        temp_y_pos{iter,1}      = self.experiment{i}.y_pos{g};
                        % may need to add another condition to deal with times there
                        % are experiments without any successful conditions of a
                        % certain type...
                            end
                        end
                    end
                iter = iter + 1;
                    
                end
            end
            switch field
                case 'wbf'
                    mean_field_out = temp_wbf;
                case 'lmr'
                    mean_field_out = temp_lmr;
                case 'left_amp'
                    mean_field_out = temp_left_amp;
                case 'x_pos'
                    mean_field_out = temp_x_pos;
                case 'right_amp'
                    mean_field_out = temp_right_amp;
                case 'y_pos'
                    mean_field_out = temp_y_pos;                                
            end

            % reshape to an easily workable dudemat

            mean_field_out = reshape([mean_field_out{:}],[],iter-1)';
        catch 
            disp('BARFING-line230')
        end
        end
        
        function self = calculate_channel_means_sems(self)
            % clear old values
            self.mean_left_amp  = [];
            self.mean_x_pos     = [];
            self.mean_right_amp = [];
            self.mean_y_pos     = [];
            self.mean_wbf       = [];
            self.mean_lmr       = [];
            
            self.sem_left_amp   = [];
            self.sem_x_pos      = [];
            self.sem_right_amp  = [];
            self.sem_y_pos      = [];
            self.sem_wbf        = [];
            self.sem_lmr        = [];
            
            % preallocate?
            temp_left_amp       = [];
            temp_x_pos          = [];
            temp_right_amp      = [];
            temp_y_pos          = [];
            temp_wbf            = [];
            temp_lmr            = [];
            
            iter = 1;
            
            for i = 1:numel(self.selected)
                if self.selected{i} == 1
                    % go through each condition, generate a mean from
                    % within the experimental data
                    for g = 1:numel(self.experiment{i}.wbf)
                        if size(self.experiment{i}.wbf{g},1) > 1;
                        temp_left_amp{g,iter}   = mean(self.experiment{i}.left_amp{g}); %#ok<*AGROW>
                        temp_x_pos{g,iter}      = mean(self.experiment{i}.x_pos{g});
                        temp_right_amp{g,iter}  = mean(self.experiment{i}.right_amp{g});
                        temp_y_pos{g,iter}      = mean(self.experiment{i}.y_pos{g});
                        temp_wbf{g,iter}        = mean(self.experiment{i}.wbf{g});
                        temp_lmr{g,iter}        = mean(self.experiment{i}.lmr{g});
                        elseif size(self.experiment{i}.wbf{g},1) == 1
                        temp_left_amp{g,iter}   = self.experiment{i}.left_amp{g};
                        temp_x_pos{g,iter}      = self.experiment{i}.x_pos{g};
                        temp_right_amp{g,iter}  = self.experiment{i}.right_amp{g};
                        temp_y_pos{g,iter}      = self.experiment{i}.y_pos{g};
                        temp_wbf{g,iter}        = self.experiment{i}.wbf{g};
                        temp_lmr{g,iter}        = self.experiment{i}.lmr{g};
                        else
                        temp_left_amp{g,iter}   = nan(1,size(self.experiment{1}.left_amp{g},2));
                        temp_x_pos{g,iter}      = nan(1,size(self.experiment{1}.x_pos{g},2));
                        temp_right_amp{g,iter}  = nan(1,size(self.experiment{1}.right_amp{g},2));
                        temp_y_pos{g,iter}      = nan(1,size(self.experiment{1}.y_pos{g},2));
                        temp_wbf{g,iter}        = nan(1,size(self.experiment{1}.wbf{g},2));
                        temp_lmr{g,iter}        = nan(1,size(self.experiment{1}.lmr{g},2));
                        end
                        if numel(temp_left_amp{g,iter}) < 1
                            fprintf('Experiment %d has no conditions of type %d \n Will automatically be unselected by Genotype.select\n',i,g)
                            self.selected{i} = 0;
                        end
                        if g == 130
                            size(self.experiment{1}.lmr{g},2)
                            % numel(temp_left_amp)
                        end
                    end
                iter = iter + 1;
                end
            end

            % now do a mean and find sem across the averaged data for each
            % condition
            sem_denominator = (iter-1)^(1/2);
            try
            for j = 1:size(temp_left_amp,1)
                self.mean_left_amp{j}  = nanmean(reshape([temp_left_amp{j,:}],[],iter-1)'); %#ok<*UDIM>
                self.mean_x_pos{j}     = nanmean(reshape([temp_x_pos{j,:}],[],iter-1)');
                self.mean_right_amp{j} = nanmean(reshape([temp_right_amp{j,:}],[],iter-1)');
                self.mean_y_pos{j}     = nanmean(reshape([temp_y_pos{j,:}],[],iter-1)');
                self.mean_wbf{j}       = nanmean(reshape([temp_wbf{j,:}],[],iter-1)');
                self.mean_lmr{j}       = nanmean(reshape([temp_lmr{j,:}],[],iter-1)');
                
                self.sem_left_amp{j}   = nanstd(reshape([temp_left_amp{j,:}],[],iter-1)')/sem_denominator;
                self.sem_x_pos{j}      = nanstd(reshape([temp_x_pos{j,:}],[],iter-1)')/sem_denominator;
                self.sem_right_amp{j}  = nanstd(reshape([temp_right_amp{j,:}],[],iter-1)')/sem_denominator;
                self.sem_y_pos{j}      = nanstd(reshape([temp_y_pos{j,:}],[],iter-1)')/sem_denominator;
                self.sem_wbf{j}        = nanstd(reshape([temp_wbf{j,:}],[],iter-1)')/sem_denominator;
                self.sem_lmr{j}        = nanstd(reshape([temp_lmr{j,:}],[],iter-1)')/sem_denominator;
            end
            catch
                'barfing.'
            end
            % force the free memory
            clear temp_left_amp temp_x_pos temp_right_amp temp_y_pos temp_wbf temp_lmr      
        end
            
        function ages = calculate_ages_from_object(self)
            iter = 1;
            for i = 1:numel(self.selected)
                if self.selected{i}
                    datestr(self.dobs{i},30);
                    % time 31 does not work with datevec.. have to do it
                    % manually, what poor planning matlab...
                    exp_time = datevec(self.dates_times{i}(1:8),'yyyymmdd');
                    dob = datevec(self.dobs{i});
                    
                    ages(iter) =  etime(exp_time,dob)/(60*60*24);
                    iter = iter + 1;
                end
            end
        end
    end
    
    %% ------------STATIC PROPERTIES---------------------------------------
    methods (Static)
        
        function [integrated_mean, integrated_sem] = cpt_integrated_vals(mean_values)
            % Will work only on the experiment level means.
            
            % for each experiment's mean
            integrated_response = zeros(1,size(mean_values,1));
            
            for g = 1:size(mean_values,1)
%                 integrated_response(g) = trapz(1:numel(mean_values(:,g)),abs(mean_values(:,g)));
                  integrated_response(g) = trapz(mean_values(g,:));
            end
            % means/sems
            integrated_mean = mean(integrated_response);
            integrated_sem = std(integrated_response)/(size(mean_values,1))^(1/2);            
            
        end
        
        function [half_max_mean, half_max_sem] = cpt_t2_75mean(mean_values)
            % Will work only on the experiment level means.
            half_max_time = zeros(1,size(mean_values,1));
            
%             for g = 1:size(mean_values,1)
%                 half_max_time(g) = find(abs(mean_values(:,g)) == max(abs(mean_values(:,g))),1);
%             end
%             half_max_mean = mean(half_max_time);
%             half_max_sem = std(half_max_time)/(size(mean_values,1)^(1/2));
            % changed to 75% of mean...
            
            % should probs be filtered...
            for g = 1:size(mean_values,1)
                mean_75 =.75*mean(mean_values(g,:));
                [~, half_max_time(g)] = min(abs([mean_values(g,:) - mean_75]));
            end
            half_max_mean = mean(half_max_time);
            half_max_sem = std(half_max_time)/(size(mean_values,1)^(1/2));
            
        end 
        
        function time_shifts = convert_selected_dot_dates_to_hours(cell_of_selected,cell_of_shift_strs)
            iter = 1;
            for g = 1:numel(cell_of_shift_strs)
                if cell_of_selected{g}
                    time_points = regexpi(cell_of_shift_strs{g},'\d+','match');
                    time_shifts(iter) = str2double(time_points{1})*24 + str2double(time_points{2}) + str2double(time_points{3})/60;
                    iter = iter + 1;
                end
            end
        end

    end
    %% ------------METHODS FOR HIGHER ANALYSIS-----------------------------
    methods    
        function select(self,option)
            %
            switch option
                case 'shifted'
                    for g = 1:numel(self.selected)
                        if strcmpi(self.temp_shift_time{g},'0.0.0');
                            self.selected{g} = 0;
                        else
                            self.selected{g} = 1;
                        end
                    end
                case 'unshifted'
                    for g = 1:numel(self.selected)
                        if strcmpi(self.temp_shift_time{g},'0.0.0');
                            self.selected{g} = 1;
                        else
                            self.selected{g} = 0;
                        end
                    end
                case 'all'
                    for g = 1:numel(self.selected)
                        self.selected{g} = 1;
                    end
                case 'none'
                    for g = 1:numel(self.selected)
                        self.selected{g} = 0;
                    end
                case 'arena1'
                    for g = 1:numel(self.selected)
                        if strcmpi(self.arenas{g},'1');
                            self.selected{g} = 1;
                        else
                            self.selected{g} = 0;
                        end
                    end
                case 'arena2'
                    for g = 1:numel(self.selected)
                        if strcmpi(self.arenas{g},'2');
                            self.selected{g} = 1;
                        else
                            self.selected{g} = 0;
                        end
                    end
                    
                otherwise
                    error('Pass one of the following: shifted, unshifted, all, none, arena1, arena2')
            end
            % regardless, get rid of flies that don't have at least one
            % trial for all conditions
            
            for i = 1:numel(self.selected)
                for g = 1:numel(self.experiment{i}.wbf)
                    if isempty(self.experiment{i}.wbf{g});
                        self.selected{i} = 0;
                    end
                end
            end
            
            % also get rid of flies that have strange parsing of data...
            %%
            for i = 1:numel(self.selected)
                exp_size_array(i) = numel(self.experiment{i}.wbf);
            end

            if find(diff(exp_size_array) == 1)
                error_ind = find(diff(exp_size_array) == 1);
                self.selected{error_ind} = 0;
            end

        end
        
        function [integrated_values, half_max_values] =...
                        get_int_t75mean_mean_sem(self, condition_array, output_type ,varargin)
            % Will work only on the experiment level means.
            if numel(varargin) == 0
                field = 'lmr';
            else
                field = varargin{1};
            end
            
            if numel(condition_array) == 2
            
                [mean_values_1] = get_specific_experiment_level_means(self,field,condition_array(1));
                [mean_values_2] = get_specific_experiment_level_means(self,field,condition_array(2));

                if size(mean_values_1,2) < size(mean_values_2,2);
                    last = size(mean_values_1,2);
                else
                    last = size(mean_values_2,2);
                end
                
                mean_values = (mean_values_1(:,1:last) - mean_values_2(:,1:last))/2;

            elseif numel(condition_array) == 1
                [mean_values] = get_specific_experiment_level_means(self,field,condition_array(1));
            else
                error('Only one or two conditions may be passed')
            end
            
            [integrated_mean, integrated_sem]   = tfAnalysis.Genotype.cpt_integrated_vals(mean_values);
            [half_max_mean, half_max_sem]       = tfAnalysis.Genotype.cpt_t2_75mean(mean_values);
            
            switch output_type
                
                case 1
                    integrated_values{1} = integrated_mean;
                    integrated_values{2} = integrated_mean + integrated_sem;
                    integrated_values{3} = integrated_mean - integrated_sem;
                    
                    half_max_values{1} = half_max_mean;
                    half_max_values{2} = half_max_mean + half_max_sem;
                    half_max_values{3} = half_max_mean - half_max_sem;
                    
                case 2
                    integrated_values{1} = integrated_mean;
                    integrated_values{2} = integrated_sem;

                    half_max_values{1} = half_max_mean;
                    half_max_values{2} = half_max_sem;
                    
                case 3
                    integrated_values{1}    = integrated_mean;
                    half_max_values{1}      = half_max_mean;
                    
            end
        end
        
        function [average varargout] = get_timeseries(self,condition_array, output_option, varargin)
            % lmr by default, 1,2,3 give diff outputs.
            if numel(varargin) == 0
                field = 'lmr';
            else
                field = varargin{1};
            end
            if numel(condition_array) == 2
                % need to flip and average            
                mean_field = ['mean_',field];
                temp_field = getfield(self,mean_field); %#ok<*GFLD>

                standard_cond = temp_field{condition_array(1)};
                opposite_cond = temp_field{condition_array(2)};

                average = (standard_cond - opposite_cond)/2;

                sem_field = ['sem_',field];
                temp_field = getfield(self,sem_field);

                standard_cond = temp_field{condition_array(1)};
                opposite_cond = temp_field{condition_array(2)};

                sem = (standard_cond - opposite_cond)/2;
                
                sem_plus = average + sem;
                sem_minus = average - sem;
            
            elseif numel(condition_array) == 1
                % just need to return the array
                mean_field = ['mean_',field];
                temp_field = getfield(self,mean_field);

                average = temp_field{condition_array(1)};

                sem_field = ['sem_',field];
                temp_field = getfield(self,sem_field);

                sem = temp_field{condition_array(1)};
                sem_plus = average + sem;
                sem_minus = average - sem; 
                
            else
                error('One or two values in the condition_array')
            end
            
            switch output_option
                case 1
                    varargout{1} = sem_plus;
                    varargout{2} = sem_minus;
                case 2
                    varargout{1} = sem;
                case 3
                    % no sem
                case 4
                    temp = average; 
                    clear average;
                    average{1} = temp;
                    clear temp;
                    average{2} = sem_plus;
                    average{3} = sem_minus;
                    
                otherwise
                    error('output_option must be 1, 2, or 3 (or 4 for condensed)')
            end
            
        end
        
        function [xcorr_values, lag_values] = cpt_corr_lag_vals(self,condition_array,output_option,varargin)
            % Will work only on the experiment level means.
            if numel(varargin) == 2
                field_1 = varargin{1};
                field_2 = varargin{2};
            else
                field_1 = 'lmr';
                field_2 = 'x_pos';
            end
            
            % grab the sym cond means for calculation
            if numel(condition_array) > 1
                [mean_values_field1_1] = get_specific_experiment_level_means(self,field_1,condition_array(1));
                [mean_values_field1_2] = get_specific_experiment_level_means(self,field_1,condition_array(2));
                
                if size(mean_values_field1_1,2) < size(mean_values_field1_2,2);
                    last = size(mean_values_field1_1,2);
                else
                    last = size(mean_values_field1_2,2);
                end
                
                mean_values_field1 = (mean_values_field1_1(:,1:last) - mean_values_field1_2(:,1:last))/2;
                
                [mean_values_field2_1] = get_specific_experiment_level_means(self,field_2,condition_array(1));
                [mean_values_field2_2] = get_specific_experiment_level_means(self,field_2,condition_array(2));
                
                if size(mean_values_field2_1,2) < size(mean_values_field2_2,2);
                    last = size(mean_values_field2_1,2);
                else
                    last = size(mean_values_field2_2,2);
                end
                
                mean_values_field2 = (mean_values_field2_1(:,1:last) - mean_values_field2_2(:,1:last))/2;
            else
                
                [mean_values_field1] = get_specific_experiment_level_means(self,field_1,condition_array(1));                
                [mean_values_field2] = get_specific_experiment_level_means(self,field_2,condition_array(1));
            end
            
            % Now do the xcorr/lag
            for i = 1:size(mean_values_field1,1)
                norm_field1 = (mean_values_field1(i,:) - nanmean(mean_values_field1))/max(abs((mean_values_field1(i,:) - nanmean(mean_values_field1))));
                norm_field2 = (mean_values_field2(i,:) - nanmean(mean_values_field2))/max(abs((mean_values_field2(i,:) - nanmean(mean_values_field2))));
                
                [cc, lags] = xcorr(norm_field1,norm_field2,75,'coeff');
                [cross_corr(i), max_index] = max(cc);
                peak_corr(i) = lags(max_index);
            end
            
            sem_xcorr_value = std(cross_corr)/(numel(cross_corr)^(1/2));
            mean_xcorr_value = mean(cross_corr);

            sem_lag_value = std(peak_corr)/(numel(peak_corr)^(1/2));
            mean_lag_value = mean(peak_corr);
            
            if output_option == 1
            
            xcorr_values{1} = mean_xcorr_value;
            xcorr_values{2} = mean_xcorr_value + sem_xcorr_value;
            xcorr_values{3} = mean_xcorr_value - sem_xcorr_value;            
            
            lag_values{1} = mean_lag_value;
            lag_values{2} = mean_lag_value + sem_lag_value;
            lag_values{3} = mean_lag_value - sem_lag_value;
            
            elseif output_option == 2
                
            xcorr_values{1} = mean_xcorr_value;
            xcorr_values{2} = sem_xcorr_value;
            
            lag_values{1} = mean_lag_value;
            lag_values{2} = sem_lag_value;
            
            else
                error('select 1,2 for output option')
                
            end
            
        end
        
        function geno_stats_figure = get_shifted_vs_unshifted_stats(self)
            % make a figure for a quick summary
            geno_stats_figure = figure;
            figure_name = 'Summary Figure';
            set(geno_stats_figure,'Numbertitle','off','Name',figure_name,'Color','white');
            
            self.select('shifted')
            % select shifted stats
            avg_exp_time_shifted_hours = mean(tfAnalysis.Genotype.convert_selected_dot_dates_to_hours(self.selected, self.temp_shift_time));
            avg_exp_time_unshifted_hours = mean(tfAnalysis.Genotype.convert_selected_dot_dates_to_hours(self.selected, self.temp_unshift_time));
            avg_age_shifted = mean(calculate_ages_from_object(self));
            num_shifted = sum([self.selected{:}]);
            
            shift_temp = self.temp_shifted{1};
            rearing_temp = self.temp_unshifted{1};
            
            self.select('unshifted')
            % select unshifted stats
            avg_cont_time_shifted_hours = mean(tfAnalysis.Genotype.convert_selected_dot_dates_to_hours(self.selected, self.temp_shift_time));
            avg_cont_time_unshifted_hours = mean(tfAnalysis.Genotype.convert_selected_dot_dates_to_hours(self.selected, self.temp_unshift_time));
            avg_age_unshifted = mean(calculate_ages_from_object(self));
            num_unshifted = sum([self.selected{:}]);
            
            % give a title
            annotation(geno_stats_figure, 'textbox',[.035 .885 .1 .1],...
                'String',[ self.line_name ' w/ ' self.effector ],...
                'FontSize',12, 'EdgeColor', 'white')
            
            % summarize some stuff in a table
            uitable('Parent',geno_stats_figure, 'Units','normalized',...
                    'Position',[.1 .4 .75 .5],'ColumnWidth',{100},...
                    'RowName',     {'Line Name','Effector','Number Flies',...
                                    'Rearing Temp','Shift Temp',...
                                    'Age Run',...
                                    'Average Time Shift','Average Time Unshift',...
                                    'Color'},...
                    'ColumnName',{ 'Shifted','Unshifted'},...
                    'Data', {self.line_name,                        self.line_name;...
                            self.effector,                          self.effector;...
                            num2str(num_shifted),                   num2str(num_unshifted);...
                            num2str(rearing_temp),                  num2str(rearing_temp);...
                            num2str(shift_temp),                    num2str(rearing_temp);...
                            num2str(avg_age_shifted),               num2str(avg_age_unshifted);...
                            num2str(avg_exp_time_shifted_hours),    num2str(avg_cont_time_shifted_hours);...
                            num2str(avg_exp_time_unshifted_hours),  num2str(avg_cont_time_unshifted_hours);...
                            'red',                                  'blue'});             
        end
        
    end
end
