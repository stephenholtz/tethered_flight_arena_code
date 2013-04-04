classdef Utilities
    %UTILITIES houses all the error checking/initialization methods and
    %stored fields for easily running a tethered flight experiment.
    
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
                            
        % Set the length of the strings for my unixy output, aligned with rest.
        string_length = 70;                            
    end
    
    %-----METHODS FOR SETTING Panel_com/running experiment-----------------
    methods (Static)
        function [time, voltage] = set_Panel_com(cond_struct)
        % Runs a condition based on the fields of the struct. Returns the
        % time that it should be allowed to run (a pause).
        
        % For the most recent version of the panels, there is a fast mode
        % that can load patterns to panels, check the field 'display_type'
        % Also can use higher gain values.
            if isfield(cond_struct,'DisplayType') && sum(strcmpi(cond_struct.DisplayType,'panels'))
                
                Panel_com('load_pattern_2panels',cond_struct.PatternID);
                pause(.05) % Takes a bit of time to load the pattern
                Panel_com('set_position',cond_struct.InitialPosition);
                pause(.05) % For some reason this also takes some time
                Panel_com('set_mode',cond_struct.Mode);
                pause(.05)
                Panel_com('send_gain_bias',cond_struct.Gains);
                pause(.05)
                % For now leave this out, need to reconvene with Jin - 12/12
                %Panel_com('set_posfunc_id',cond_struct.PosFunctionY);
                %Panel_com('set_posfunc_id',cond_struct.PosFunctionX);
                %Panel_com('set_funcy_freq',cond_struct.FuncFreqY);
                %Panel_com('set_funcx_freq',cond_struct.FuncFreqX);
                
            else
                
                Panel_com('set_pattern_id',cond_struct.PatternID);
                pause(.03)
                Panel_com('set_position',cond_struct.InitialPosition);
                pause(.03)
                Panel_com('set_mode',cond_struct.Mode);
                pause(.03)
                
                % Deal with values over 127.
                if abs(cond_struct.Gains(1))>127
                    [cond_struct.Gains(1),cond_struct.Gains(2)] = Exp.Utilities.get_valid_gain_bias_vals(cond_struct.Gains(1));
                end
                if abs(cond_struct.Gains(3))>127
                    [cond_struct.Gains(3),cond_struct.Gains(4)] = Exp.Utilities.get_valid_gain_bias_vals(cond_struct.Gains(3));
                end
                
                Panel_com('send_gain_bias',cond_struct.Gains);
                pause(.03)
                Panel_com('set_funcy_freq',cond_struct.FuncFreqY);
                pause(.03)
                Panel_com('set_posfunc_id',cond_struct.PosFunctionY);
                pause(.03)
                Panel_com('set_funcx_freq',cond_struct.FuncFreqX);
                pause(.03)
                Panel_com('set_posfunc_id',cond_struct.PosFunctionX);
                pause(.03)
                
%                % Some new issues 12/12, need to meet with Jin
%                 if cond_struct.PosFunctionY(2)
%                     Panel_com('set_posfunc_id',cond_struct.PosFunctionY);
%                     pause(.05)
%                 end
%                 
%                 if cond_struct.PosFunctionX(2)
%                     Panel_com('set_posfunc_id',cond_struct.PosFunctionX);
%                     pause(.05)
%                 end
%                 
%                 if cond_struct.PosFunctionY(2)
%                     Panel_com('set_funcy_freq',cond_struct.FuncFreqY);
%                     pause(.05)
%                 end
%                 
%                 if cond_struct.PosFunctionX(2)
%                     Panel_com('set_funcx_freq',cond_struct.FuncFreqX);
%                     pause(.05)
%                 end
            end
            
            time = cond_struct.Duration;
            voltage = cond_struct.Voltage;
        end
        
        function startle_animal(startle_channel,startle_type)
            % Puff or Buzz the fly
            switch startle_type
                % For the solenoid, quick puffs
                case 1
                    start(startle_channel)
                    putvalue(startle_channel,1)
                    pause(.05)
                    putvalue(startle_channel,0) 
                    pause(.01)
                    putvalue(startle_channel,1)
                    pause(.075)
                    putvalue(startle_channel,0)
                    stop(startle_channel)
                % For some strange reason this is required for one of the
                % rigs (using an AO instead of the DIO)
                case 2
                    putdata(startle_channel,[repmat(5,50,1); zeros(50,1); repmat(5,50,1); zeros(50,1)]);  % set hi
                    if strcmp(startle_channel.Running,'Off')
                        start(startle_channel)      % ON
                    end    
            end
        end
        
		function result = simple_end_wbf_check(monitor_channel)
		% return 1 if the fly was flying
            start(monitor_channel);
            freq = getdata(monitor_channel); %freq = mean(WBF);
            if freq < 1.0;        % A wing beat frequency of below 120 => buzz buzz; if we want that
                result = 0;   
            else
                result = 1;
            end
                stop(monitor_channel);
        end
        
        function [wbf_monitor_chan, startle_trigger, stim_sync_chan] = initialize_default_hardware(startle_type)
        % Initialize the hardware and neccessary channels. Hard coded for sanity.
            % Reset the daq
            daqreset; % useful!
            pause(.2);

            % Setup the wbf monitor for checking if the fly is flying
            wbf_monitor_chan = analoginput('mcc',0);
            addchannel(wbf_monitor_chan, 0);
            set(wbf_monitor_chan,'TriggerType','Immediate','SamplesPerTrigger',1,'ManualTriggerHwOn','Start')
            pause(.2);

            % Setup the digital or analog trigger for the buzzer/fan
            if startle_type == 1
                startle_trigger = digitalio('mcc',0);
                addline(startle_trigger,0,'Out');
                pause(.2);
            elseif startle_type == 2
                startle_trigger = analogoutput('mcc',0);
                addchannel(startle_trigger, 0);
                pause(.2)
            end

            % Setup the stimulus sync-er for ensuring full stim presentation
            stim_sync_chan = analoginput('mcc',0);
            addchannel(stim_sync_chan, 1);
            set(stim_sync_chan,'TriggerType','Immediate','SamplesPerTrigger',1,'ManualTriggerHwOn','Start')
            pause(.2);
        
        end
        
        function [AI_wbf, DIO_trig, AI_stim_sync] = initialize_timecourse_hardware()
        % Initialize the hardware and neccessary channels. Hard coded for sanity.
            % Reset the daq
            daqreset; % useful!
            pause(.2);

            % Setup the wbf monitor for checking if the fly is flying
            AI_wbf = analoginput('mcc',0);
            addchannel(AI_wbf, 0);
            set(AI_wbf,'TriggerType','Immediate','SamplesPerTrigger',1,'ManualTriggerHwOn','Start')
            pause(.2);

            % Setup the digital trigger for the buzzer/fan
            DIO_trig = digitalio('mcc',0);
            addline(DIO_trig,0,'Out');
            pause(.2);

            % Setup the stimulus sync-er for ensuring full stim presentation
            AI_stim_sync = analoginput('mcc',0);
            addchannel(AI_stim_sync, 1);
            set(AI_stim_sync,'TriggerType','Immediate','SamplesPerTrigger',1,'ManualTriggerHwOn','Start')
            pause(.2);
            
%             % Needs to be validated...
%             AI_stim_sync = analoginput('mcc',1);
%             addchannel(AI_stim_sync, 1);
%             set(AI_stim_sync,'TriggerType','Immediate','SamplesPerTrigger',1,'ManualTriggerHwOn','Start')
%             pause(.2);            
            
        end
        
        function [gain,bias] = get_valid_gain_bias_vals(fps)
            % ugly function to fix the gain and bias values...
            ideal_fps = abs(fps);
            
            range_gain = 0:127;
            range_bias = 0:127;
            
            found = false;
            while true
                for gain = range_gain
                    for bias = range_bias
                        if(gain + 2.5*bias) == ideal_fps
                            found = true;
                            gain = gain*sign(fps);
                            return
                        end
                    end
                end
            end
            
            if ~found
                error('Specified gain cannot be acheived!') 
            end
            
        end
        
	end
    
    %-----METHODS FOR ERROR CHECKING---------------------------------------
    methods (Static)
    % Common methods for running the tethered flight arena
        
        function [metadata cond_struct meta_file path_files] = do_all_protocol_checks(protocol)
                        
            if ~ischar(protocol);
                error('protocol must be a string.')
            else
                string = (['Loading ', protocol, ' (specified protocol).']);
                Exp.Utilities.unixy_output_pt1(string)
            end
            
            [result, condition_func, meta_file, path_files.funcs_on_SD_path, path_files.pats_on_SD_path, path_files.cfgs_on_SD_path] = Exp.Utilities.get_check_protocol_input(protocol);
            % The result of this function is informative. Nice to see what went wrong.
            if result.has_funcs && result.has_pats && result.has_cfgs && result.has_conds && result.has_meta
                Exp.Utilities.unixy_output_pt2(1)
                string = (['Found ', protocol, ' SD card info.']);
                Exp.Utilities.unixy_output_pt1(string)
                Exp.Utilities.unixy_output_pt2(1)
            else
                Exp.Utilities.unixy_output_pt2(0)
                disp('Protocol folder must contain SD card info!')
                disp(result)
                error('SD card info requred');
            end

            [result, cond_struct] = Exp.Utilities.get_checked_cond_input(condition_func);
            string = ('Checking condition function');
            Exp.Utilities.unixy_output_pt1(string)
            if ~result;
                Exp.Utilities.unixy_output_pt2(0)
                error('Conditions failed to load');
            else
                Exp.Utilities.unixy_output_pt2(1)

            end

            result = Exp.Utilities.check_cond_file(cond_struct);
            string = ('Verifying condition function contents');
            Exp.Utilities.unixy_output_pt1(string)
            if ~result;
                Exp.Utilities.unixy_output_pt2(0)
                error('Improper conditions file');
            else
                Exp.Utilities.unixy_output_pt2(1)
            end

            metadata.Protocol = protocol;
            [result, metadata] = Exp.Utilities.get_check_meta_file(meta_file,metadata);
            string = ('Checking metadata file and contents');
            Exp.Utilities.unixy_output_pt1(string)
            if ~result;
                Exp.Utilities.unixy_output_pt2(0)
                disp(Exp.Utilities.metadataFieldList);
                error('Metadata failed to load/missing fields from meta file.');
            else
                Exp.Utilities.unixy_output_pt2(1)
            end
        end
        
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
            result.has_segments = 0;
            
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
                    elseif ~isempty(strfind(name,'segments'))
						result.has_segments = 1;
                        varargout{6} = fullfile(protocol_loc,(protocol_file_info(i).name));                        
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
        
        function [result metadata] = get_check_meta_file(meta_file,metadata)
            failed = 0;
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
                for g = Exp.Utilities.metadataFieldList
                       
                    if ~isfield(metadata,g)
                        failed = 1;
                    end
                end
            else
                failed = 1;
            end
            
            if failed
                result = false;
            else
                result = true;
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
                
        function segment_struct = return_segment_struct(protocol)
			exp_loc = what('+Exp');
            [~, base_dir] = fileattrib(fullfile(exp_loc.path,'..'));
            segment_loc = fullfile(base_dir.Name,'protocols',protocol,'segments.m');
            if ~exist(segment_loc,'file'); 
                error ('segments.m not found in protocol directory')
            end
            
            run(segment_loc);
            segment_struct = segment;
            
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
			metadata.ExperimentName = ['test_experiment_', metadata.DateTime];
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
        
        function result = move_save_files(daq_location,data_location,conditions,metadata,path_files)
            % Make the directory, move the daq file, and save metadata/conditions
            result = 1;
            
            try mkdir(data_location);
            catch mkErr
                result = 0;
                disp(mkErr.message);
                disp(data_location);
                disp('Problem making directory for daq file! DO ALL MANUALLY')
                return
            end
            
            try movefile(daq_location,data_location);
            catch moveErr
                result = 0;
                disp(moveErr.message);
                disp(data_location);
                disp('Problem moving daq file to above location! Do manually.')
            end

            % A set of save and copies to get all relevant data to the experiment's
            % folder
            try
                metadata; %#ok<*VUNUS>
                save(fullfile(data_location,'metadata'),'metadata');
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem saving metadata.')
            end

            try
                conditions;
                save(fullfile(data_location,'conditions'),'conditions');
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem evaluating/copying conditions')
            end

            try
                mkdir(fullfile(data_location),'patterns_on_SD_card');
                copyfile(path_files.pats_on_SD_path,fullfile(data_location,'patterns_on_SD_card'));
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem moving/copying patterns')
            end

            try
                mkdir(fullfile(data_location),'functions_on_SD_card');
                copyfile(path_files.funcs_on_SD_path,fullfile(data_location,'functions_on_SD_card'));
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem moving/copying functions')
            end

            try
                mkdir(fullfile(data_location),'cfgs_on_SD_card');
                copyfile(path_files.cfgs_on_SD_path,fullfile(data_location,'cfgs_on_SD_card'));
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem moving/copying panel_cfgs')
            end
        end
        
        function result = copy_segments_file(segments_path,data_location)
            try
                copyfile(fullfile(segments_path,'segments.m'),fullfile(data_location,'segments.m'));
                result = 1;
            catch cpyErr
                result = 0;
                disp(cpyErr.message)
                disp('Problem evaluating/copying segment_struct')
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
        
        function unixy_output_pt1(string)
        string = [string, repmat(' ',1,(Exp.Utilities.string_length-numel(string)))];
        fprintf(string)
        end
    
        function unixy_output_pt2(worked)
        if worked == 1 
            fprintf('[Done]\n')
        elseif worked == 0
            fprintf('[Failed]\n')
        elseif worked == -1
            fprintf('[Failed: No Flight. Added back to queue.]\n')
        end
        end     
    
        function decision = make_metadata_gui(metadata,meta_file)
            % Double check the metadata is correct with a(n overly complex) gui.
            %
            % Additional option to save a temporary experiment with all fields
            % changed to testing, when saved.
            
            main_fh = figure;
            figName = 'Metadata for Current Experiment';
            set(main_fh,'NumberTitle','off','Name',figName,'Position',[350,75,470,355],'PaperOrientation','portrait','Color','w');
            annotation(main_fh, 'textbox',[.035 .885 .1 .1],'String',figName,'FontSize',12, 'FontWeight','demi', 'EdgeColor', 'white')
            
            decision = 0;
            [type, value] = return_type_value(metadata);
            make_popup_metadata_ui(main_fh,type,value);

            % Function to get a type and value cell for display on the 'gui'
                function [value_cell, type_cell] = return_type_value(metadata)
                    fields = fieldnames(metadata);
                    for ind = 1:numel(fieldnames(metadata))
                    value_cell{ind} = {getfield(metadata, fields{ind})}; %#ok<*GFLD,*AGROW>            
                    if ~iscell(value_cell{ind}{1})
                        value_cell{ind} = {getfield(metadata, fields{ind})}; %#ok<*GFLD,*AGROW>
                    else
                        value_cell{ind} = 'values exist';
                    end            
                        type_cell{ind} = fields(ind);
                    end
                end

            % Function to make the popup ui.
                function make_popup_metadata_ui(fig_handle,type,value)
                    uitable('Parent',fig_handle, 'Units','normalized','Position',[.05 .05 .68 .85],'ColumnWidth',{175},...
                        'RowName',[value{:}]','ColumnName','Values',...
                        'Data',[type{:}]');
                    uicontrol('style','pushbutton','Units','normalized','string','Accept',...
                        'Position',[0.74 0.7 0.2 0.125],'BackgroundColor',[.6 .9 .6],...
                        'callback',{@MetaChoice,'Accepted',fig_handle});
                    uicontrol('style','pushbutton','Units','normalized','string','Deny',...
                        'Position',[0.74 0.5 0.2 0.125],'BackgroundColor',[.9 .6 .6],...
                        'callback',{@MetaChoice,'Denied',fig_handle});
                    uicontrol('style','pushbutton','Units','normalized','string','ModifyFile',...
                        'Position',[0.74 0.3 0.2 0.125],'BackgroundColor',[.6 .9 .9],...
                        'callback',{@MetaChoice,'ModifyFile',fig_handle});
                    uicontrol('style','pushbutton','Units','normalized','string','Testing Defaults',...
                        'Position',[0.74 0.1 0.2 0.125],'BackgroundColor',[.6 .6 .9],...
                        'callback',{@MetaChoice,'Defaults',fig_handle});
                end

            % A short callback for the metadata doublecheck gui.
                function MetaChoice(~, ~, choice, fig_handle)
                    switch choice
                        case 'Denied'
                            decision = 0;
                            close(fig_handle);
                        case 'Accepted'
                            decision = 1;
                            close(fig_handle);
                        case 'Defaults'
                            % reload the testing values to show they changed, then
                            % close/continue.
                            decision = 2;
                            [metadata] = Exp.Utilities.testing_metadata;
                            [type_cell, value_cell] = return_type_value(metadata);
                            make_popup_metadata_ui(fig_handle,type_cell,value_cell);
                            pause(1);
                            close(fig_handle);
                        case 'ModifyFile'
                            open(meta_file);
                            help_dlg_h = helpdlg('Edit file, save and rerun experiment.');
                            uiwait(help_dlg_h)
                            close(fig_handle);
                    end
                end

            % Wait for the figure to close before continuing. End experiment if
            % the choice was rejected
            waitfor(main_fh);
            if ~decision
                disp('Metadata choice rejected. Ending experiment.')
                return
            end
            
        end
        
    end
end