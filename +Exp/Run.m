function Run(protocol,varargin)
%function Run(protocol[string] ,reps[numeric], record[binary])
% Run will run an experiment of the protocol specified, for the number of
% reps specified (3 default), and record (by default) or not.
%
% The protocol folder must be in the tethered_flight_arena_code directory
% under protocols (/tethered_flight_arena_code/protocols/protocol)
%
% The protocol folder specified must have a conditions function which
% returns all the necessary settings for each condition -- as specified in
% the Exp.Utilities properties
%
% The protocol folder specified must have a metadata file which returns all
% the necessary data as specified in the Exp.Utilities properties
%
% The protocol folder specified must also have a folder
% functions_on_SD_card and patterns_on_SD_card which has at least the
% Pattern_xxx.mat files and the Function_xxx.mat files that are loaded onto
% the SD card from PControl (If no functions are used, the folder must 
% still exist!)
%
% If the functions or patterns are not specified, a warning will appear and
% an empty mat file will be stored in the final data destination
% The protocol folder specified must also have folders:
% functions_on_SD_card, cfgs_on_SD_card and patterns_on_SD_card, which have
% the functions, configuration files, and patterns used in the experiment
% If the folders are empty, an empty folder will be copied to the
% experiment's folder at the end.
%
% The conditions and metadata must be specified and in the correct format -
% error checking is all handled by the Exp.Utilities class
%
% Experiment runs through randomized conditions, if the fly stops flying
% during the condition it will end, and go to closed loop, which will
% continue to startle the fly until it begins flying. 
%
% If the fly doesn't start flying for a while of startling, or a certain
% number of conditions are missed, or the experiment finishes. Emails are 
% sent as notifications.
% 
% Exp.Utilities has most of the common functions for cleanliness 
%
% SLH - 2012

% Set up some Defaults
default_reps = 3;
default_record = true;
check_flying = true;
randomize = 1;
startle_type = 1; %1 works well with buzzer and puffer

disp('STANDARD PROTOCOL STARTING')


    %% Primary checks in this order: For folder. Folder contents. Condition function. Metadata. Genotype.
    % Start a timer + Check the metadata is correct with a(n overly complex) gui.
    tID = tic;
    [metadata cond_struct meta_file path_files] = Exp.Utilities.do_all_protocol_checks(protocol);
    choice = Exp.Utilities.make_metadata_gui(metadata,meta_file);
    if ~choice
        return
    end
    
    %% Initialize the hardware and neccessary channels. Hard coded for sanity.
    string = ('Initializing hardware');
    Exp.Utilities.unixy_output_pt1(string)
    [AI_wbf DIO_trig AI_stim_sync] = Exp.Utilities.initialize_default_hardware;
    
    % For acquiring the actual data, if wanted
    if nargin > 2 ;
        if isnumeric(varargin{2});
            record = varargin{2};
        else
            error('record (varargin{2}) incorrectly specified, supply binary')
        end
    else
        record = default_record;
    end
    
    if record
        DAQ_dev = analoginput('nidaq','Dev1');
        addchannel(DAQ_dev,0:6);
        daq_file = fullfile('C:\tf_tmpfs\',metadata.daqFile);
        set(DAQ_dev,'LoggingMode','Disk','LogFileName',daq_file,'SampleRate',1000);
        set(DAQ_dev,'SamplesPerTrigger',Inf); %,'TimerFcn',@AcquireData
    end
    
    Exp.Utilities.unixy_output_pt2(1)
    
    %% Start the experiment, initial alignment (with last condition, the default
    % location for a closed loop interspersing condition) then write a
    % conditions and a metadata file to the file determined by the conditions
    % function and the genotype + datestr.
    
    % Get the number of reps specified (or go to a defualt number of 3)
    if nargin > 1 ;
        if isnumeric(varargin{1});
            reps = varargin{1};
        else
            error('reps (varargin{1}) incorrectly specified, supply a number')
        end
    else
        reps = default_reps;
    end
    
    % Set the panel configuration for the experiment, right now only using one
    % for the whole experiment
    string = ('Panels off, setting experiment panel config. Expect Box/Errors');
    Exp.Utilities.unixy_output_pt1(string)
    Panel_com('all_off'); pause(.05)
    Panel_com('set_config_id',cond_struct(1).PanelCfgNum); pause(4.5);
    Exp.Utilities.unixy_output_pt2(1)
    
    % Initial alignment portion, use the last condition as the interspersal condition.
    Nconds = numel(cond_struct); num_trials_missed = 0; emailed_conds_missed = 0; reluctant_email_sent = 0;
    Exp.Utilities.set_Panel_com(cond_struct(Nconds));
    Panel_com('set_ao',[3,0]); % interspersed conditions are of voltage zero (easy decoding!)
    Panel_com('set_ao',[4,0]); % trigger for precise timing of stim onset
    Panel_com('start');
    string = ('Initial alignment phase. Press any key to continue.');
    Exp.Utilities.unixy_output_pt1(string)
    pause();
    Exp.Utilities.unixy_output_pt2(1)
    
    if record;
        start(DAQ_dev);
    end
    
    total_conds = (reps*(Nconds-1)); % The last condition of each doesn't count for this (it is the closed loop!)
    curr_cond_index = 1;
    
    for rep = 1:reps
        % Randomize a set of conditions to decrement for each repetition
        if randomize
            cond_nums = randperm(Nconds-1);
        else
            cond_nums = 1:(Nconds-1);
        end
            
        while ~isempty(cond_nums)
            cond = cond_nums(1);
            % Changed to make the output more UINIXy, readable by padding
            % Might need to make this its own function...
            % Output => Repetition [  1/  4] -- Trial [  93/ 400] -- Condition [  5/100]
            rep_progress = [ '[' repmat(' ',1,4-numel(num2str(rep))) num2str(rep) '/' repmat(' ',1,4-numel(num2str(reps))) num2str(reps) ']' ];
            trial_progress = [ '[' repmat(' ',1,4-numel(num2str(curr_cond_index))) num2str(curr_cond_index) '/' repmat(' ',1,4-numel(num2str(total_conds))) num2str(total_conds) ']' ];
            condition_progress = [ '[' repmat(' ',1,4-numel(num2str(cond))) num2str(cond) '/' repmat(' ',1,4-numel(num2str(Nconds-1))) num2str(Nconds-1) ']'];
            fprintf('Repetition %s -- Trial %s -- Condition %s  ', rep_progress, trial_progress, condition_progress);
            
            [time voltage] = Exp.Utilities.set_Panel_com(cond_struct(cond));
            % need to convert the voltage to 16 bit (2^15)-1
            voltage_16bit=voltage*(32767/10);
            Panel_com('stop');
            
            % Set the voltage encoding
            Panel_com('set_ao',[3,voltage_16bit]);
            % Set the trigger value
            Panel_com('set_ao',[4,5*(32767/10)]);
            Panel_com('start');
            
            % Trigger the analog input to take its sample
            start(AI_stim_sync)
            % Get the sample (removes it from SamplesAvailable)
            stim_start_trigger = getdata(AI_stim_sync);
            
            % This depends on the analog output values
            ticHandle = tic;
            while stim_start_trigger < 2.5
                start(AI_stim_sync)
                stim_start_trigger = getdata(AI_stim_sync);
                if toc(ticHandle) > 5
                    % if some time past the first stimulus there is an
                    % error, send an email!
                    if numel(cond_nums) < (Nconds-2)
                        
                        email_subject = ['WARNING: tfExperiment on ' metadata.Arena ' Requires Attention.'];
                        email_message = ['Stimulus failed.'];
                        disp(email_message);                
                        result = Exp.Utilities.send_email(email_subject,email_message);
                        
                        if ~result; disp('Error sending stim fail email');
                        end
                    end
                    error('Stimulus failed to display for 5 seconds')
                end
            end
            
            flying = 1;
            ticHandle = tic;
            time_elapsed = toc(ticHandle);
            while time_elapsed < time
                time_elapsed = toc(ticHandle);
                if check_flying
                    if ~Exp.Utilities.simple_end_wbf_check(AI_wbf)
                        flying = 0;
                        pause(.15) % This is important for later decoding the stimuli.. with the AO's if it is too short it might show up as a noise spike!
                        break
                    end
                else
                    pause(.0001)
                end
            end
            if (time_elapsed-time) > 1; warning('Time discrepancy... '); end ;
            
            Panel_com('stop');
            % Reset the voltage encoding
            Panel_com('set_ao',[3,0]);
            % Reset the trigger value
            Panel_com('set_ao',[4,0]);

            % Set the voltage to zero as soon as possible
            % Check that the fly was flying up until the end of the condition
            % then move on to next or add the trial back in.
            
            if flying
                cond_nums = cond_nums(2:end);
                Exp.Utilities.unixy_output_pt2(1)
            else
                Exp.Utilities.unixy_output_pt2(-1)
                cond_nums = [cond_nums(2:end) cond];
                total_conds = total_conds+1;
                num_trials_missed = num_trials_missed +1;
                
                if num_trials_missed > 40 && emailed_conds_missed == 0;
                    email_subject = ['WARNING: tfExperiment on ' metadata.Arena ' Requires Attention.'];
                    email_message = ['Fly has not completed trials ' num2str(num_trials_missed) ' times.'];
                    disp(email_message);                
                    result = Exp.Utilities.send_email(email_subject,email_message);
                    if ~result; disp('Error sending too many trials missed email');
                    end
                    emailed_conds_missed = 1;
                end

            end
            curr_cond_index = curr_cond_index+1;

            % Interspersed condition (voltage already set to zero above)
            [time ~] = Exp.Utilities.set_Panel_com(cond_struct(Nconds));
            % Turn the trigger back on
            Panel_com('set_ao',[4,5*(32767/10)]);
            Panel_com('start');
            start(AI_stim_sync)
            % Get the sample (removes it from SamplesAvailable)
            stim_start_trigger = getdata(AI_stim_sync);

            % This depends on the analog output values
            while stim_start_trigger < 2.5
                start(AI_stim_sync)
                stim_start_trigger = getdata(AI_stim_sync);
            end
            
            ticHandle = tic;
            time_elapsed = toc(ticHandle);
            base_time = time;
            while time_elapsed < time
                time_elapsed = toc(ticHandle);
                % The times in here are a bit hackish right now... but it works
                if check_flying
                    if ~Exp.Utilities.simple_end_wbf_check(AI_wbf)
                        flying = 0;
                        Exp.Utilities.startle_animal(DIO_trig,startle_type)
                        time = time + 1.3;
                        pause(1.25)
                    end

                    if time_elapsed > base_time*10 && reluctant_email_sent == 0;
                        email_subject = ['WARNING: tfExperiment on ' metadata.Arena ' Requires Attention.'];
                        email_message = ['Fly failed to start flight after ' num2str(time_elapsed) ' seconds.'];
                        disp(email_message);
                        result = Exp.Utilities.send_email(email_subject,email_message);
                        if ~result; disp('Error sending too many trials missed email');
                        end
                        reluctant_email_sent = 1;
                    end
                end
            end
            if (time_elapsed-time) > 1; warning('Time discrepancy... '); end ;
            
            Panel_com('stop');
            Panel_com('set_ao',[4,0]);        
        end
    end

    %% Determine the file save location from metadata, make that directory, copy the patterns and functions to it, and save the metadata/conditions to that location.

    % Establish the new file system storage location
    root_data_loc = 'C:\tf_tmpfs';
    metadata.Protocol = protocol;
    data_location = fullfile(root_data_loc,metadata.Protocol,[metadata.Line '_' metadata.Effector],metadata.DateTime);
    % Move the temporary daq file to the new location
    temp_daq_name = daq_file;
    daq_location = fullfile(temp_daq_name);

    fprintf('Experiment finished, moving temp daq file/writing metadata/conditions to %s \n',data_location');

    % If manually recording, need a notification to stop.
    if ~record
        email_subject = ['tfExperiment ' metadata.Arena ' Requires daq Stop.'];
        email_message =' . ';
        result = Exp.Utilities.send_email(email_subject,email_message);
        if ~result; disp('Error sending email');
        end
        disp('If still manually recording, stop. Continue with any button')
        pause();
    else
        stop(DAQ_dev);
    end
    
    res = Exp.Utilities.move_save_files(daq_location,data_location,cond_struct,metadata,path_files);
    
    % Stop the timer.
    timer = toc(tID);
    
    if res
        % Send an email saying it is finished.
        email_subject = ['tfExperiment on' ' Finished.'];
        email_message = ['Duration: ', num2str(timer/60) ' mins. Name: '  metadata.Arena ' .'];
        result = Exp.Utilities.send_email(email_subject,email_message);
        if ~result; disp('Error sending email'); end
    else
        % Send an email saying it is finished, but stuff failed.
        email_subject = ['tfExperiment on' ' Finished. With Errors'];
        email_message = ['Duration: ', num2str(timer/60) ' mins. Name: '  metadata.Arena ' .'];
        result = Exp.Utilities.send_email(email_subject,email_message);
        if ~result; disp('Error sending email'); end
    end
    
    if record
        clear('DAQ_dev')
        daqreset
        delete(instrfindall) % Excellent command
    end

    fprintf('Finished in %d mins\n',timer/60);
end
