classdef Data < handle
    %DATA contains raw data for individual trials (in other assays more)
    %   For tethered flight, this is simply the DAQ Channels and a logical
    %   indicating if the trial was successful or not.
    %   Because memory is a problem, this level has minimal computation.
    %
    %   The lmr from the wing beat analyser is slightly messy. Opted to
    %   replace it with the cleaner left_amp - right_amp
    %
    %   This class is populated by tfAnalysis.import automatically.
    
    properties
        % Was the trial successful? This  and lmr recalculation are the 
        % only computations done (thresholds on the wbf, left_amp and 
        % right_amp).
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
        WBF_THRESHOLD = 1.35;
        RPL_THRESHOLD = 1.65;
        ACQUISITION_SAMPLING_RATE = 1000; 
        DEFAULT_DOWNSAMPLING_VALUE = 500;
    end
    
    properties (Access = private)
        new_sampling_rate
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
            % Only a container in my composition based analysis
        end      
        
        function self = main(self)
            % Run only the neccessary computations on the data on this
            % level, dog.
            self = determine_success(self);
            self = replace_wba_lmr_with_calcd_lmr(self);
        end
        
        function self = replace_wba_lmr_with_calcd_lmr(self)
            self.lmr = self.left_amp - self.right_amp;
        end
        
        function self = downsample_data(self,varargin)
%             if isempty(varargin)
%                 self.new_sampling_rate = self.DEFAULT_DOWNSAMPLING_VALUE;
%             else
%                 self.new_sampling_rate = varargin{1};
%             end
%             
%             
%             
        end
        
        function self = filter_wing_beat_channels(self)
%             % Butterworth...
%             self.lmr = [];
%             self.left_amp = [];
%             self.right_amp = [];
            
        end
        
        function self = determine_success(self)
            % check the WBF for a threshold, if that is OK, check that the
            % left + the right wing beat amplitudes hits a threshold but is
            % not all over a certain amount
            
            % To save space, store these thresholds as private properties
            
            % > 10% shouldn't be below either threshold
            if sum(self.wbf < self.WBF_THRESHOLD) > numel(self.wbf)*.1
                self.successful = 0;
            elseif sum(self.right_amp+self.left_amp < self.RPL_THRESHOLD) > numel(self.wbf)*.3
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
    end
end
