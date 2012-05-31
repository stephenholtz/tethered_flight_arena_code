classdef Experiment 
    
    %--------------NON CONDITION SPECIFIC PROPERTIES-----------------------
    properties
        
        % For later updating the database with tfAnalysis.Update
        id
        
        % For processing data within a genotype!
        selected
        
        % Non condition specific properties (metadata)
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
        
    end
    
    %--------------CONDITION SPECIFIC PROPERTIES---------------------------    
    properties
        % A cell array of trials
        trial
        
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
        
    end
    
    %--------------PROPERTIES FOR INTERNAL CALCULATION---------------------    
    properties (Access = private)
        % Put lower level calculation variables here.
        
        
    end
    
    %--------------NON CONDITION SPECIFIC METHODS--------------------------
    methods
        function self = Experiment()
        end
        
        function self = main(self)
            % Default the experiment to selected
            self.selected = 1;
            
            % Make an array of successful trial indicies
            self.successful_trials = zeros(1,numel(self.trial));
            for g = 1:numel(self.trial)
                self.successful_trials(g) = (self.trial{g}.data{1}.successful);
            end
            
            % Populate the condition specific data cells
            self = group_unique_successful_trial_data(self);
            
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
        
        function self = cpt_channel_means_sems(self)
            % Since conditions are of multiple lengths sometimes, these
            % need to unpack each trial and append for each trial, rather
            % than the tidy cell2mat approach.
                    left_amp         = [];                                  %#ok<*AGROW>
                    x_pos            = [];
                    right_amp        = [];
                    y_pos            = [];
                    wbf              = [];
                    voltage_signal   = [];
                    lmr              = [];            
            for i = 1:numel(self.trial)
                    left_amp         = [left_amp, (self.trial{i}.data{1}.left_amp)];            %#ok<*AGROW>
                    x_pos            = [x_pos, (self.trial{i}.data{1}.x_pos)];
                    right_amp        = [right_amp, (self.trial{i}.data{1}.right_amp)];
                    y_pos            = [y_pos, (self.trial{i}.data{1}.y_pos)];
                    wbf              = [wbf, (self.trial{i}.data{1}.wbf)];
                    voltage_signal   = [voltage_signal, (self.trial{i}.data{1}.voltage_signal)];
                    lmr              = [lmr, (self.trial{i}.data{1}.lmr)];                
            end
                self.mean_left_amp      = mean(left_amp);
                self.mean_x_pos         = mean(x_pos);
                self.mean_right_amp 	= mean(right_amp);
                self.mean_y_pos         = mean(y_pos);
                self.mean_wbf           = mean(wbf);
                self.mean_voltage_signal= mean(voltage_signal);
                self.mean_lmr           = mean(lmr);
                % SEMs
                self.sem_left_amp       = mean(std(left_amp))/((numel(self.trial))^(1/2));
                self.sem_x_pos          = mean(std(x_pos))/((numel(self.trial))^(1/2));
                self.sem_right_amp      = mean(std(right_amp))/((numel(self.trial))^(1/2));
                self.sem_y_pos          = mean(std(y_pos))/((numel(self.trial))^(1/2));
                self.sem_wbf            = mean(std(wbf))/((numel(self.trial))^(1/2));
                self.sem_voltage_signal = mean(std(voltage_signal))/((numel(self.trial))^(1/2));
                self.sem_lmr            = mean(std(lmr))/((numel(self.trial))^(1/2));
        end
        
        function [exp_stats_struct, exp_stats_figure] = get_exp_stats(self)
            % Include a few sections in a small struct and/or figure.
            % Fly Metadata:
            %       Genotype - Effector - Protocol - Sex - DoB( + age)
            %       Date,Time Run - Arena - Light Cycle etc.,
            % Some Stats:
            %       Average WBF - Average LmR - (todo) Average Closed Loop
            % m for meta
            % ADD PLOTS: HIST LmR + Hist L Hist R + WBF avg over trials.
            
            exp_stats_struct.m.genotype                 = [self.chr2, '-', self.chr3];
            exp_stats_struct.m.effector                 = self.effector;
            exp_stats_struct.m.protocol                 = self.protocol;
            exp_stats_struct.m.sex                      = self.sex;
            exp_stats_struct.m.date_time                = self.date_time;
            exp_stats_struct.m.dob                      = self.dob;
            exp_stats_struct.m.light_cycle              = self.light_cycle;
            % exp_stats_struct.m.time_shift               = self.temp_shift;
            % mean_sem
            exp_stats_struct.stats.left_amp             = self.mean_left_amp;
            exp_stats_struct.stats.left_amp_sem         = self.sem_left_amp;
            exp_stats_struct.stats.x_pos                = self.mean_x_pos;
            exp_stats_struct.stats.x_pos_sem            = self.sem_x_pos;
            exp_stats_struct.stats.right_amp            = self.mean_right_amp;
            exp_stats_struct.stats.right_amp_sem        = self.sem_right_amp;
            exp_stats_struct.stats.y_pos                = self.mean_y_pos;
            exp_stats_struct.stats.y_pos_sem            = self.sem_y_pos;
            exp_stats_struct.stats.wbf                  = self.mean_wbf;
            exp_stats_struct.stats.wbf_sem              = self.sem_wbf;
            exp_stats_struct.stats.voltage_signal       = self.mean_voltage_signal;
            exp_stats_struct.stats.voltage_signal_sem   = self.sem_voltage_signal;                                
            exp_stats_struct.stats.lmr                  = self.mean_lmr;
            exp_stats_struct.stats.lmr_sem              = self.sem_lmr;
            
            % Data for the plots
            for i = 1:numel(self.trial)
                    lmr{i}              = (self.trial{i}.data{1}.mean_left_amp) - (self.trial{i}.data{1}.mean_right_amp);                
                    wbf{i}              = (self.trial{i}.data{1}.mean_wbf);                    
            end
            lmr_for_plot      = cell2mat(lmr);            
            wbf_for_plot      = cell2mat(wbf);
            
            % Make the figure with the struct as a table, and properties
            % displayed
            figure_name = [[self.chr2, '\_', self.chr3], ' Effector: ' ,self.effector, ' D/T: ', self.date_time];
            exp_stats_figure = figure('Color',[1 1 1],'PaperOrientation','landscape','Name',figure_name,'NumberTitle','off');
            % Iterate through each substruct and construct the table.
            axis off
            title({'Summary Statistics for Experiment: ',figure_name});
            uitable('Parent',exp_stats_figure, 'Units','normalized','Position',[.05 .05 .45 .85],'ColumnWidth',{100},...
                    'ColumnName',{'Type','Value'},...
                                'Data',[[fieldnames(exp_stats_struct.m); fieldnames(exp_stats_struct.stats)],...
                                        [struct2cell(exp_stats_struct.m); struct2cell(exp_stats_struct.stats)]]);
            uip1 = uipanel('Parent',exp_stats_figure','Position',[.55 .5 .40 .40],'BackgroundColor',[1 1 1], 'Title','LmR Hist');   
            subplot(1,1,1,'Parent',uip1)            
                hist(lmr_for_plot)
            uip2 = uipanel('Parent',exp_stats_figure','Position',[.55 .0525 .40 .40],'BackgroundColor',[1 1 1], 'Title','WBF Over Trials');   
            subplot(1,1,1,'Parent',uip2)
                plot(wbf_for_plot)
        end
        
    end
    %--------------CONDITION SPECIFIC METHODS------------------------------
    methods
        % These methods need to loop through all of the trials and use the
        % trial property 'cond_num' to average/sem across repetitions.
        % cond_cpt_channel_means_sems is a good example of how it works.
        function self = copy_trial_cond_info_to_experiment(self)
            % This could be made logical, but it was a pain. Hard coding
            % below
            for i = 1:numel(self.trial);
                self.cond_num{i}            = self.trial{i}.cond_num;
                self.cond_pat_id{i}         = self.trial{i}.pat_id;
                self.cond_gains{i}          = self.trial{i}.gains;
                self.cond_mode{i}           = self.trial{i}.mode;
                self.cond_duration{i}       = self.trial{i}.duration;
                self.cond_init_pos{i}       = self.trial{i}.init_pos;
                self.cond_func_freq_x{i}    = self.trial{i}.func_freq_x;
                self.cond_pos_func_x{i}     = self.trial{i}.pos_func_x;
                self.cond_func_freq_y{i}    = self.trial{i}.func_freq_y;
                self.cond_pos_func_y{i}     = self.trial{i}.pos_func_y;
                self.cond_vel_func{i}       = self.trial{i}.vel_func;
                self.cond_voltage{i}        = self.trial{i}.voltage;
                self.cond_pos_func_name_x{i}= self.trial{i}.pos_func_name_x;
                self.cond_pos_func_name_y{i}= self.trial{i}.pos_func_name_y;
                self.cond_pattern_name{i}   = self.trial{i}.pattern_name;
            end
        end
        
        function self = cpt_cond_data(self)
            
            % populate the condition specific properties they
            % are computed from the genotype level -- for now offline
            % access to them is probably the best way to go.
            
            self = cond_cpt_duration_decode_array(self);
            self = cond_cpt_channel_means_sems(self);
            self = cond_cpt_hists(self);
            self = cond_cpt_corr_vals(self);
            self = cond_cpt_integrated_vals(self);
            self = cond_cpt_time_to_half_max(self);  
        end
        
        function self = cond_cpt_duration_decode_array(self)
            % All of the durations should be the same within a given
            % condition, so one will do for now.

            for i = 1:numel(self.trial)
                
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                
                self.cond_data_duration{condition} = self.trial{i}.data{1}.data_duration;

            end
            
            pos = 1:3;
            start_cond_pos = 1;
            
            for condition = 1:numel(self.cond_data_duration)
                self.decoding_1D_array(pos) = [ condition,...
                                                start_cond_pos,...
                                                start_cond_pos-1+self.cond_data_duration{condition}];
                start_cond_pos = start_cond_pos + self.cond_data_duration{condition};
                pos = (pos + 3);
            end
            
        end
        
        function self = cond_cpt_channel_means_sems(self)
            for i = 1:numel(self.trial)
                
                % determine the condition number, and the rep for averaging
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                condition_set{i} = condition;
                r = sum(condition == [condition_set{:}]);
                
                left_amp{condition,r}        = self.trial{i}.data{1}.left_amp;                       %#ok<*AGROW>
                x_pos{condition,r}           = self.trial{i}.data{1}.x_pos;
                right_amp{condition,r}       = self.trial{i}.data{1}.right_amp;
                y_pos{condition,r}           = self.trial{i}.data{1}.y_pos;
                wbf{condition,r}             = self.trial{i}.data{1}.wbf;
                voltage_signal{condition,r}  = self.trial{i}.data{1}.voltage_signal;
                lmr{condition,r}             = self.trial{i}.data{1}.lmr;                
            end
            
            for condition = unique([condition_set{:}])     % Same as cell2mat, but looks prettier       
                self.cond_mean_left_amp{condition}         = mean(cell2mat(left_amp(condition,:)'));
                self.cond_mean_x_pos{condition}            = mean(cell2mat(x_pos(condition,:)'));
                self.cond_mean_right_amp{condition}        = mean(cell2mat(right_amp(condition,:)'));
                self.cond_mean_y_pos{condition}            = mean(cell2mat(y_pos(condition,:)'));
                self.cond_mean_wbf{condition}              = mean(cell2mat(wbf(condition,:)'));
                self.cond_mean_voltage_signal{condition}   = mean(cell2mat(voltage_signal(condition,:)'));
                self.cond_mean_lmr{condition}              = mean(cell2mat(lmr(condition,:)'));             

                self.cond_sem_left_amp{condition}          = std(cell2mat(left_amp(condition,:)'))/(size(cell2mat(left_amp(condition,:)'),1))^(1/2);
                self.cond_sem_x_pos{condition}             = std(cell2mat(x_pos(condition,:)'))/(size(cell2mat(x_pos(condition,:)'),1))^(1/2);
                self.cond_sem_right_amp{condition}         = std(cell2mat(right_amp(condition,:)'))/(size(cell2mat(right_amp(condition,:)'),1))^(1/2);
                self.cond_sem_y_pos{condition}             = std(cell2mat(y_pos(condition,:)'))/(size(cell2mat(y_pos(condition,:)'),1))^(1/2);
                self.cond_sem_wbf{condition}               = std(cell2mat(wbf(condition,:)'))/(size(cell2mat(wbf(condition,:)'),1))^(1/2);
                self.cond_sem_voltage_signal{condition}    = std(cell2mat(voltage_signal(condition,:)'))/(size(cell2mat(voltage_signal(condition,:)'),1))^(1/2);
                self.cond_sem_lmr{condition}               = std(cell2mat(lmr(condition,:)'))/(size(cell2mat(lmr(condition,:)'),1))^(1/2); 
            end
        end
        
        function self = cond_cpt_hists(self)
            for i = 1:numel(self.trial)
                
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                condition_set{i} = condition;
                r = sum(condition == [condition_set{:}]);
                
                hist_96.x{condition,r} = hist(self.trial{i}.data{1}.x_pos,96)';
                hist_96.y{condition,r} = hist(self.trial{i}.data{1}.y_pos,96)';
            end
            
            for condition = unique([condition_set{:}])            
            
                self.cond_hist_96_x_pos{condition}= mean(([hist_96.x{condition}]),2);
                self.cond_hist_96_y_pos{condition}= mean(([hist_96.y{condition}]),2);
                self.cond_hist_96_x_pos_sem{condition}= std(([hist_96.x{condition}]),1,2)/(numel(hist_96.y{condition})^(1/2));
                self.cond_hist_96_y_pos_sem{condition}= std(([hist_96.y{condition}]),1,2)/(numel(hist_96.y{condition})^(1/2));            
            end            
        end
        
        function self = cond_cpt_corr_vals(self)
            % Taken straight from John's telethon figure scripts
            for i = 1:numel(self.trial)
                
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                condition_set{i} = condition;
                r = sum(condition == [condition_set{:}]);
                
                % X/Y pos normalized to use with each cross correlation            
                dem.x{condition,r} = self.trial{i}.data{1}.x_pos - mean(self.trial{i}.data{1}.x_pos);
                norm.x{condition,r} = dem.x{condition,r}/max(abs(dem.x{condition,r}));
                dem.y{condition,r} = self.trial{i}.data{1}.y_pos - mean(self.trial{i}.data{1}.y_pos);
                norm.y{condition,r} = dem.y{condition,r}/max(abs(dem.y{condition,r}));
                % LmR and WBF normalized for the cross correlation
                dem.lmr{condition,r} = self.trial{i}.data{1}.lmr - mean(self.trial{i}.data{1}.lmr);
                norm.lmr{condition,r} = dem.lmr{condition,r}/max(abs(dem.lmr{condition,r}));                        
                dem.wbf{condition,r} = self.trial{i}.data{1}.wbf - mean(self.trial{i}.data{1}.wbf);
                norm.wbf{condition,r} = dem.wbf{condition,r}/max(abs(dem.wbf{condition,r}));
                
                % cross correlation and lag value assignment for:
                % x and lmr
                [cc, lags] = xcorr(norm.x{condition,r},dem.lmr{condition,r},75,'coeff');
                [corr.x_lmr{condition,r},  max_index]   = max(cc);
                peak_corr.x_lmr{condition,r}    = lags(max_index);
                % y and lmr
                [cc, lags] = xcorr(norm.y{condition,r},dem.lmr{condition,r},75,'coeff');
                [corr.y_lmr{condition,r},  max_index]   = max(cc);
                peak_corr.y_lmr{condition,r}    = lags(max_index);
                % x and wbf
                [cc, lags] = xcorr(norm.x{condition,r},dem.wbf{condition,r},75,'coeff');
                [corr.x_wbf{condition,r},  max_index]   = max(cc);
                peak_corr.x_wbf{condition,r}    = lags(max_index);
                % y and wbf
                [cc, lags] = xcorr(norm.y{condition,r},dem.wbf{condition,r},75,'coeff');
                [corr.y_wbf{condition,r},  max_index]   = max(cc);
                peak_corr.y_wbf{condition,r}    = lags(max_index);
            end
            
            for condition = unique([condition_set{:}])            
                
                self.cond_corr_x_lmr{condition}                 = mean(([corr.x_lmr{condition,:}]));
                self.cond_corr_x_lmr_sem{condition}             = std(([corr.x_lmr{condition,:}]))/(numel(corr.x_lmr{condition,:})^(1/2));
                self.cond_lag_corr_x_lmr{condition}             = mean(([peak_corr.x_lmr{condition,:}]));
                self.cond_lag_corr_x_lmr_sem{condition}         = std(([peak_corr.x_lmr{condition,:}]))/(numel(peak_corr.x_lmr{condition,:})^(1/2));
                self.cond_corr_y_lmr{condition}                 = mean(([corr.y_lmr{condition,:}]));
                self.cond_corr_y_lmr_sem{condition}             = std(([corr.y_lmr{condition,:}]))/(numel(corr.y_lmr{condition,:})^(1/2));
                self.cond_lag_corr_y_lmr{condition}             = mean(([peak_corr.y_lmr{condition,:}]));
                self.cond_lag_corr_y_lmr_sem{condition}         = std(([peak_corr.y_lmr{condition,:}]))/(numel(peak_corr.y_lmr{condition,:})^(1/2));
                self.cond_corr_x_wbf{condition}                 = mean(([corr.x_wbf{condition,:}]));
                self.cond_corr_x_wbf_sem{condition}             = std(([corr.x_wbf{condition,:}]))/(numel(corr.x_wbf{condition,:})^(1/2));
                self.cond_lag_corr_x_wbf{condition}             = mean(([peak_corr.x_wbf{condition,:}]));
                self.cond_lag_corr_x_wbf_sem{condition}         = std(([peak_corr.x_wbf{condition,:}]))/(numel(peak_corr.x_wbf{condition,:})^(1/2));
                self.cond_corr_y_wbf{condition}                 = mean(([corr.y_wbf{condition,:}]));
                self.cond_corr_y_wbf_sem{condition}             = std(([corr.y_wbf{condition,:}]))/(numel(corr.y_wbf{condition,:})^(1/2));
                self.cond_lag_corr_y_wbf{condition}             = mean(([peak_corr.y_wbf{condition,:}]));
                self.cond_lag_corr_y_wbf_sem{condition}         = std(([peak_corr.y_wbf{condition,:}]))/(numel(peak_corr.y_wbf{condition,:})^(1/2));
            end
        end
        
        function self = cond_cpt_integrated_vals(self)
            % Straight from john's telethon analysis
            for i = 1:numel(self.trial)
                
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                condition_set{i} = condition;
                r = sum(condition == [condition_set{:}]);
                
                integrated.lmr_response{condition,r}     = trapz(1:self.cond_data_duration{condition},abs(self.trial{i}.data{1}.lmr));
                integrated.wbf_response{condition,r}     = trapz(1:self.cond_data_duration{condition},abs(self.trial{i}.data{1}.wbf));
                
            end
            for condition = unique([condition_set{:}])            

                self.cond_integrated_lmr_response{condition}       = mean(([integrated.lmr_response{condition,:}]));
                self.cond_integrated_lmr_response_sem{condition}   = std(([integrated.lmr_response{condition,:}]))/(numel(integrated.lmr_response{condition}))^(1/2);
                self.cond_integrated_wbf_response{condition}       = mean(([integrated.wbf_response{condition,:}]));              
                self.cond_integrated_wbf_response_sem{condition}   = std(([integrated.wbf_response{condition,:}]))/(numel(integrated.wbf_response{condition}))^(1/2);
            end
        end
        
        function self = cond_cpt_time_to_half_max(self)
            % Straight from john's telethon analysis
            for i = 1:numel(self.trial)
                
                condition = self.trial{i}.data{1}.cond_num;
                if ischar(condition); condition = str2double(condition);
                end
                condition_set{i} = condition;
                r = sum(condition == [condition_set{:}]);
                
                time_to_half_max.lmr{condition,r}= find(abs(self.trial{i}.data{1}.lmr) == max(abs(self.trial{i}.data{1}.lmr)),1);
                time_to_half_max.wbf{condition,r}= find(abs(self.trial{i}.data{1}.wbf) == max(abs(self.trial{i}.data{1}.wbf)),1);
            end
            for condition = unique([condition_set{:}])            
                
                self.cond_time_to_half_max_lmr{condition}= mean(([time_to_half_max.lmr{condition,:}]));
                self.cond_time_to_half_max_wbf{condition}= mean(([time_to_half_max.wbf{condition,:}]));
                self.cond_time_to_half_max_lmr_sem{condition}= std(([time_to_half_max.lmr{condition,:}]))/(numel(time_to_half_max.lmr{condition}))^(1/2);
                self.cond_time_to_half_max_wbf_sem{condition}= std(([time_to_half_max.wbf{condition,:}]))/(numel(time_to_half_max.wbf{condition}))^(1/2);
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