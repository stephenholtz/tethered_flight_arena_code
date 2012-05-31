classdef Utilities
    %UTILITIES houses all the error checking methods and stored fields for
    %easily running a tethered flight experiment.
    
    %-----PROPERTIES FOR ERROR CHECKING------------------------------------
    properties (Constant)
    % Stored fields for a condition. Each condition within a condition function
	% must specify all of these fields.
        conditionFieldList =   {'PatternID',...         % trial_metadata type value
                                'Gains',...             % trial_metadata type value
                                'Mode',...              % trial_metadata type value
                                'Duration',...          % trial_metadata type value
                                'InitialPosition',...   % trial_metadata type value
                                'FuncFreqX',...         % trial_metadata type value
                                'PosFunctionX',...      % trial_metadata type value
                                'FuncFreqY',...         % trial_metadata type value
                                'PosFunctionY',...      % trial_metadata type value
                                'VelFunction',...       % trial_metadata type value
                                'VelFuncName',...       % trial_metadata type value
                                'Voltage',...           % trial_metadata type value
                                'PosFuncNameX',...      % trial_metadata type value
                                'PosFuncNameY',...      % trial_metadata type value
                                'PatternName'};         % trial_metadata type value                           
    % Stored fields for metadata checking, each experiment must have all of these
	% fields populated so that a complete picture of all experiments can exist
	% in the database.
        metadataFieldList  =   {'Line',...              % this will be searched for in the database
                                'Chromo2',...           % this is for better information on the genotype
                                'Chromo3',...           % this is for better information on the genotype
                                'Sex',...               % sex, written out
                                'DoB',...               % month _ day _ year
                                'LightCycle',...        % lights on _ lights off
                                'Arena',...             % Number written on the controller of each arena
                                'HeadGlued',...         % 1 = glued, 0 = not glued
                                'Experimenter',...      % keep track of who ran the experiment
                                'AssayType',...         % (tf = tethered flight)
                                'Protocol',...          % (condition_function name)
                                'DateTime',...          % the time the experiment started
                                'ExperimentName',...    % generated in the meta file, something unique to help debugging
                                'Effector',...          % this will be used in database for searching 
                                'temp_unshift_time',... % length of time unshifted in days.hours.mins
                                'temp_shift_time',...   % length of time shifted in days.hours.mins      
                                'temp_unshifted',...    % for flies that are raised at 25, this should be 25, the other temps should be zero     
                                'temp_shifted',...      % if the flies are raised at 25 and not shifted, this value does not matter      
                                'temp_experiment',...   % from the thermometer above the arenas     
                                'temp_ambient',...      % from the thermometer above the arenas   
                                'humidity_ambient',...  % from the thermometer above the arenas
                                'fly_tag',...           % for keeping track of flies that need histology etc.,
                                'note',...              % for misc things that don't fit, but don't need a category
                                'daqFile'};             % this shouldn't change, but it might be useful to have control of it
    end
    
    %-----METHODS FOR SETTING Panel_com/running experiment-----------------
    methods (Static)
        function [time voltage] = set_Panel_com(cond_struct)
        % Runs a condition based on the fields of the struct. Returns the
        % time that it should be allowed to run (a pause).
            Panel_com('set_pattern_id',cond_struct.PatternID);     
            Panel_com('set_position',cond_struct.InitialPosition);            
            Panel_com('set_mode',cond_struct.Mode);
            % Deal with values over 127. By adding in a bias too -- this
            % means for things to work properly and transparently ONLY the
            % gains should be changed in the condition function that makes
            % the cond_struct.
            if abs(cond_struct.Gains(1))>127
                cond_struct.Gains(2) = cond_struct.Gains(1)/2.5;
                cond_struct.Gains(1) = 0;                
            elseif abs(cond_struct.Gains(3))>127
                cond_struct.Gains(4) = cond_struct.Gains(2)/2.5;
                cond_struct.Gains(3) = 0;  
            end
            Panel_com('send_gain_bias',cond_struct.Gains);
            Panel_com('set_posfunc_id',cond_struct.PosFunctionY);
            Panel_com('set_posfunc_id',cond_struct.PosFunctionX);
            Panel_com('set_funcy_freq',cond_struct.FuncFreqY);
            Panel_com('set_funcx_freq',cond_struct.FuncFreqX);
            
            time = cond_struct.Duration;
            voltage = cond_struct.Voltage;
        end
    
		function result = simple_end_wbf_check(monitor_channel, startle_channel)
		% return 1 if the fly was flying
            start(monitor_channel);
            WBF = getdata(monitor_channel, 5); freq = mean(WBF);
            if freq < 1.0;        % A wing beat frequency of below 120 => buzz buzz; if we want that
                start(startle_channel)
                putvalue(startle_channel,1)
                pause(.012)
                putvalue(startle_channel,0) 
                pause(.002)
                putvalue(startle_channel,1)
                pause(.004)
                putvalue(startle_channel,0)
                stop(startle_channel)
                result = 0;   
            else
                result = 1;
            end

            stop(monitor_channel);
            end
	end
    
    %-----METHODS FOR ERROR CHECKING---------------------------------------
    methods (Static)
    % Common methods for running the tethered flight arena
        
		function [result varargout] = get_check_protocol_input(protocol)
		% function [result condition_func meta_file funcs_on_SD pats_on_SD cfgs_on_SD] = get_check_protocol_input(protocol)
		% Checks to see if the protocol folder exists, and that it has the required elements
        % Returns a struct of logicals, if all are 1, good to go
            varargout{1} = 'empty'; varargout{2} = varargout{1}; varargout{3} = varargout{1}; varargout{4} = varargout{1}; varargout{5} = varargout{1};
			% this function working correctly depends on the +Exp package being on the same level as the protocol folder... probably a safe bet
			exp_loc = what('+Exp');
            [~, base_dir] = fileattrib(fullfile(exp_loc.path,'..'));
			protocol_loc = fullfile(base_dir.Name,'protocols',protocol);
			% This error should probably go somewhere else...
            if ~isdir(protocol_loc)
				disp('No folder for protocol!')
            end			
			% Check for the SD card files
			result.has_funcs 	= 0;
			result.has_pats 	= 0;
            result.has_cfgs     = 0;
			result.has_conds 	= 0;
			result.has_meta 	= 0;
            
            protocol_file_info = dir(protocol_loc);
            
			% use 3:end because the first 'files' are . and .. 
			for i = 3:numel(protocol_file_info)
				name = protocol_file_info(i).name;
				dirstatus = protocol_file_info(i).isdir;
				exist_type = exist(fullfile(protocol_loc,protocol_file_info(i).name));
				if strcmpi(name,'functions_on_SD_card') && dirstatus
					result.has_funcs = 1;
					varargout{3} = (fullfile(protocol_loc,protocol_file_info(i).name));
				elseif strcmpi(name,'patterns_on_SD_card') && dirstatus
					result.has_pats = 1;
					varargout{4} = (fullfile(protocol_loc,protocol_file_info(i).name));
                elseif strcmpi(name,'cfgs_on_SD_card') && dirstatus
                    result.has_cfgs = 1;
					varargout{5} = (fullfile(protocol_loc,protocol_file_info(i).name));
                elseif ~dirstatus && (isnumeric(exist_type) && exist_type == 2);
					% Here the fullfile isn't needed since the targets can be evaluated.
					if strcmpi(name,protocol) || strcmpi (name,[protocol '.m'])
						result.has_conds = 1;
						varargout{1} = (protocol_file_info(i).name);
					elseif ~isempty(strfind(name,'meta'))
						result.has_meta = 1;
						varargout{2} = fullfile(protocol_loc,(protocol_file_info(i).name));
					end
				end
            end
		end
		
        function [result varargout] = get_checked_cond_input(cond_string)
        % Make sure it is a function that can execute (is in path, is
        % function) -- some issues with filename vs filename.m dealt with
            result = false;
            exist_result = false;
            
            try
				[~, cond, ~] = fileparts(cond_string);
                [varargout{1}] = eval(cond);
                eval_err = 0;
                exist_result = exist(cond_string,'file');   
          	catch ME
               	eval_err = 1;
                disp('Problem loading conditions from conditions_file')
                error(ME.message)
			end
            
            if exist_result == 2 && eval_err == 0
                result = true;
            end
        end
        
        function [result metadata] = get_check_meta_file(meta_file)
            try 
                % Will it load - does it have fields, something should probably make more sense here...
				[folder, meta, ~] = fileparts(meta_file);
                cf = cd;
                cd(folder)
                eval(meta);
                cd(cf);
                getfield(metadata,'DoB');
                eval_result = 1;
            catch ME
                disp(ME)
                eval_result = 0;
				metadata = 'null';
				error(ME.message)
            end
            
            if eval_result && isstruct(metadata)
                while true
                    for name = fieldnames(metadata)
                        if sum(cell2mat(strfind(Exp.Utilities.metadataFieldList, [name{:}]))) == 0
                            result = false;
                            break
                        end
                    end
                    result = true;
                    break
                end
            else
                result = false;
            end
        end
        
        function result = check_cond_file(cond_struct)
            if isstruct(cond_struct)
                while true
                    for name = fieldnames(cond_struct)
                        if sum(cell2mat(strfind(Exp.Utilities.conditionFieldList, [name{:}]))) == 0
                            result = false;
                            break
                        end
                    end
                    result = true;
                    break
                end
            else
                result = false;
            end            
        end
        
        function result = check_geno_input(geno)
        % For now just return 1, need to find a better method for this
        result = 1;
        end
        
        function metadata = testing_metadata
        % make a metadata struct that is just for testing purposes - useful
        % for debugging
        	metadata = [];
        	for field = Exp.Utilities.metadataFieldList
				eval(['metadata.',field{1}, '= ''testing'';']);
        	end
        	% Some should be over written with 'real' values though...
        	metadata.DateTime       = datestr(now,30);
			metadata.ExperimentName = [metadata.AssayType '-' metadata.Protocol '-' metadata.DateTime '-' metadata.Chromo2 '_' metadata.Chromo3 '__' metadata.Effector];
            metadata.daqFile        = 'raw_data.daq';
        end
        
    end
    
    %-----METHODS FOR FILE MAKING------------------------------------------
    methods (Static)
        function result = make_cond_file(cond_struct, location)
            try
                conditions = cond_struct;
                file = fullfile(location,'conditions');
                save(file,'conditions')
                
                result = true;
            catch saveErr
                disp(saveErr.message)
                error('Could not save conditions at specified location')
            end       
        end
        
        function result = make_meta_file(input_meta, location)
            % Add a few extra fields before saving
            % Date, Timestamp            
            try
                input_meta.Date = date;
                input_meta.Timestamp = clock;            
                metadata = input_meta;

                file = fullfile(location,'metadata');
                save(file,'metadata')
                
                result = true;
            catch saveErr
                disp(saveErr.message)
                error('Could not save metadata at specified location')
            end
        end
        
    end
    
    %-----MISC METHODS---------------------------------------
    methods (Static)
		function result = send_email(subject_line,message_line)
        % This will send an email to the hard coded email below with the
        % subject line and message line. From the mathworks documentation.
            try
				my_address = 'experiment.holtz@gmail.com';
				setpref('Internet','E_mail',my_address);
				setpref('Internet','SMTP_Server','smtp.gmail.com');
				setpref('Internet','SMTP_Username',my_address);
				setpref('Internet','SMTP_Password','this_is_not_my_usual_password');
				props = java.lang.System.getProperties;
				props.setProperty('mail.smtp.auth','true');
				props.setProperty('mail.smtp.socketFactory.class', ...
				                  'javax.net.ssl.SSLSocketFactory');
				props.setProperty('mail.smtp.socketFactory.port','465');
				sendmail(my_address, subject_line, message_line);
				result = 1;			
            catch mailErr
				result = 0;
				disp(mailErr.message);
            end
		end
    end
end

