classdef Data
    %DATA contains raw data for individual trials (in other assays more)
    %   Higher levels may or may not use the output of these functions, the
    %   properties are all stored in a database.
    % Note:
    %   Any time there is only one object returned, it is propagated as a
    %   single object in a cell array. 
    
    properties
        % Include id for uploading back to the db with tfAnalysis.Update
        id
        % Was the trial successful? This is the only 'computation' that is
        % done (thresholds on the wbf, left_amp and right_amp).
        successful 
        
        % DAQ Channels
        left_amp
        x_pos
        right_amp
        y_pos
        wbf
        voltage_signal                                     
        lmr
        
    end
    
    properties (Constant = true, Access = private)
        wbf_threshold = 1.35;
        rpl_threshold = 1.50;
    end
    
    properties (Access = private)
        % Values are private and can be returned, but are not saved in the
        % objects fields. So long as they are not populated, or cleared
        % before saving, VERY little size increase occurs.
        
        
        mean_left_amp
        mean_x_pos
        mean_right_amp
        mean_y_pos
        mean_wbf
        mean_voltage_signal                                     
        mean_lmr
        
        sem_left_amp
        sem_x_pos
        sem_right_amp
        sem_y_pos
        sem_wbf
        sem_voltage_signal                                     
        sem_lmr
        
        hist_96_x_pos
        hist_96_y_pos     
        
        % Correlation values
        corr_x_lmr
        corr_y_lmr
        corr_x_wbf
        corr_y_wbf        
        lag_corr_x_lmr
        lag_corr_y_lmr
        lag_corr_x_wbf
        lag_corr_y_wbf  
        
        % Integrated Responses
        integrated_lmr_response
        integrated_wbf_response
        
        % Time to half max
        time_to_half_max_lmr
        time_to_half_max_wbf
        
        % Duration
        data_duration
        data_duration_time_series
        
    end
    
    methods
        
        function self = Data()
        end      
        
        function self = main(self)
            % Run only the neccessary computations on the data on this
            % level.
            self = determine_success(self);
        end
        
        function self = determine_success(self)
            % check the WBF for a threshold, if that is OK, check that the
            % left + the right wing beat amplitudes hits a threshold but is
            % not all over a certain amount
            
            % To save space, store these thresholds as private properties
            
            % > 10% shouldn't be below the threshold
            if sum(self.wbf < self.wbf_threshold) > numel(self.wbf)*.1
                self.successful = 0;
            elseif sum(self.right_amp+self.left_amp < self.rpl_threshold) > numel(self.wbf)*.3
                self.successful = 0;
            else
                self.successful = 1;
            end
            
        end
        
        function self = clear_private_properties(self)
            % sets all of the private properties back to empty, to save
            % space
            self.mean_left_amp              = [];
            self.mean_x_pos                 = [];
            self.mean_right_amp             = [];
            self.mean_y_pos                 = [];
            self.mean_wbf                   = [];
            self.mean_voltage_signal        = [];                                 
            self.mean_lmr                   = [];

            self.sem_left_amp               = [];
            self.sem_x_pos                  = [];
            self.sem_right_amp              = [];
            self.sem_y_pos                  = [];
            self.sem_wbf                    = [];
            self.sem_voltage_signal         = [];                           
            self.sem_lmr                    = [];

            self.hist_96_x_pos              = [];
            self.hist_96_y_pos              = [];

            self.corr_x_lmr                 = [];
            self.corr_y_lmr                 = [];
            self.corr_x_wbf                 = [];
            self.corr_y_wbf                 = [];
            self.lag_corr_x_lmr             = [];
            self.lag_corr_y_lmr             = [];
            self.lag_corr_x_wbf             = [];
            self.lag_corr_y_wbf             = [];
            
            self.integrated_lmr_response    = [];
            self.integrated_wbf_response    = [];
            
            self.time_to_half_max_lmr       = [];
            self.time_to_half_max_wbf       = [];
            
            self.data_duration              = [];
            self.data_duration_time_series  = [];

        end
        
        function self = perform_computations(self)
            % routine to compute all values with one method call, very
            % procedural, but whatever it works.
            self = cpt_duration(self);
            self = cpt_channel_means(self);
            self = cpt_channel_sems(self);
            self = cpt_hists(self);
            self = cpt_corr_vals(self);
            self = cpt_integrated_vals(self);            
            self = cpt_time_to_half_max(self);
        end
        
        function self = cpt_duration(self)
           self.data_duration               = numel(self.wbf);
           self.data_duration_time_series   = 1:self.data_duration;
        end
        
        function self = cpt_channel_means(self)
            self.mean_left_amp          = mean(self.left_amp);
            self.mean_x_pos             = mean(self.x_pos);
            self.mean_right_amp         = mean(self.right_amp);
            self.mean_y_pos             = mean(self.y_pos);
            self.mean_wbf               = mean(self.wbf );
            self.mean_voltage_signal    = mean(self.voltage_signal);
            self.mean_lmr               = mean(self.lmr);
        end
        
        function self = cpt_channel_sems(self)
            self.sem_left_amp       = std(self.left_amp)/(length(self.left_amp))^(1/2);
            self.sem_x_pos          = std(self.x_pos)/(length(self.x_pos))^(1/2);
            self.sem_right_amp      = std(self.right_amp)/(length(self.right_amp))^(1/2);
            self.sem_y_pos          = std(self.y_pos)/(length(self.y_pos))^(1/2);
            self.sem_wbf            = std(self.wbf )/(length(self.wbf))^(1/2);
            self.sem_voltage_signal = std(self.voltage_signal)/(length(self.voltage_signal))^(1/2);
            self.sem_lmr            = std(self.lmr)/(length(self.lmr))^(1/2);
        end
        
        function self = cpt_hists(self)
            % This is a simplified histogram for x position, in the
            % tethered flight case, 96 positions is really all that will
            % usually be needed.
            self.hist_96_x_pos = hist(self.x_pos,96);
            self.hist_96_y_pos = hist(self.x_pos,96);
        end
        
        function self = cpt_corr_vals(self)
            % Taken straight from John's telethon figure scripts
            % X/Y pos normalized to use with each cross correlation            
            dem.x = self.x_pos - self.mean_x_pos;
            norm.x = dem.x/max(abs(dem.x));
            dem.y = self.y_pos - self.mean_y_pos;
            norm.y = dem.y/max(abs(dem.y));
            % LmR and WBF normalized for the cross correlation
            dem.lmr = self.lmr - self.mean_lmr;
            norm.lmr = dem.lmr/max(abs(dem.lmr));                        
            dem.wbf = self.wbf - self.mean_wbf;
            norm.wbf = dem.wbf/max(abs(dem.wbf));
            
            % cross correlation and lag value assignment for:
            % x and lmr
            [cc, lags] = xcorr(norm.x,norm.lmr,75,'coeff');
            [self.corr_x_lmr,  max_index]    = max(cc);
            self.lag_corr_x_lmr              = lags(max_index);            
            % y and lmr
            [cc, lags] = xcorr(norm.y,dem.lmr,75,'coeff');
            [self.corr_y_lmr,  max_index]    = max(cc);
            self.lag_corr_y_lmr              = lags(max_index);  
            % x and wbf
            [cc, lags] = xcorr(norm.x,dem.wbf,75,'coeff');
            [self.corr_x_wbf,  max_index] = max(cc);
            self.lag_corr_x_wbf              = lags(max_index);  
            % y and wbf
            [cc, lags] = xcorr(norm.y,dem.wbf,75,'coeff');
            [self.corr_y_wbf,  max_index] = max(cc);
            self.lag_corr_y_wbf              = lags(max_index); 
        end
        
        function self = cpt_integrated_vals(self)
            % Straight from john's telethon analysis, a trapezoidal
            % integration of the response.
            self.integrated_lmr_response = trapz(self.data_duration_time_series,abs(self.lmr));            
            self.integrated_wbf_response = trapz(self.data_duration_time_series,abs(self.wbf));
        end
        
        function self = cpt_time_to_half_max(self)
            % Straight from john's telethon analysis, the lmr voltage and
            % wbf voltage value at the half maximum
            self.time_to_half_max_lmr = find(abs(self.lmr) == max(abs(self.lmr)));
            self.time_to_half_max_wbf = find(abs(self.wbf) == max(abs(self.wbf)));
        end
        
    end
end
