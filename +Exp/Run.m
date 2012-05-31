function Run(protocol,varargin)
%function Run(protocol[string] ,reps[numeric], record [binary])
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
% the SD card from PControl
%
% If the functions or patterns are not specified, a warning will appear and
% an empty mat file will be stored in the final data destination
%
% The conditions and metadata must be specified and in the correct format -
% error checking is all handled by the Exp.Utilities class
%
% SLH - 2012

%% Primary checks in this order: For folder. Folder contents. Condition function. Metadata. Genotype. 

% Start a timer, dog.
tID = tic;

% Set the length of the strings for my unixy output, aligned with rest.
string_length = 70;
    
if ~ischar(protocol); 
    error('protocol must be a string.') 
else
    string = (['Loading ', protocol, ' (specified protocol).']);
    unixy_output_pt1(string)    
end

[result condition_func meta_file funcs_on_SD_path pats_on_SD_path cfgs_on_SD_path] = Exp.Utilities.get_check_protocol_input(protocol);
    % The result of this function is informative. Nice to see what went wrong.
    if result.has_funcs && result.has_pats && result.has_cfgs && result.has_conds && result.has_meta
        unixy_output_pt2(1)        
        string = (['Found ', protocol, ' SD card info.']);
        unixy_output_pt1(string)
        unixy_output_pt2(1)        
    else
        unixy_output_pt2(0)        
        disp('Protocol folder must contain SD card info!')
        disp(result)
        error('SD card info requred');
    end

[result cond_struct] = Exp.Utilities.get_checked_cond_input(condition_func);
    string = ('Checking condition function');
    unixy_output_pt1(string)
    if ~result; 
        unixy_output_pt2(0)        
        error('Conditions failed to load'); 
    else
        unixy_output_pt2(1)        
        
    end

result = Exp.Utilities.check_cond_file(cond_struct);
    string = ('Verifying condition function contents');
    unixy_output_pt1(string)
    if ~result; 
        unixy_output_pt2(0)        
        error('Improper conditions file'); 
    else
        unixy_output_pt2(1)        
    end

[result metadata] = Exp.Utilities.get_check_meta_file(meta_file);
    string = ('Checking metadata file and contents');
    unixy_output_pt1(string)
    if ~result; 
        unixy_output_pt2(0)        
        error('Metadata failed to load/missing fields from meta file.'); 
    else
        unixy_output_pt2(1)        
    end

% recover genotype for storing the file (as geno_full + datestr)
% this should eventually check against a database/text file -- so I separated it out as its own check
geno = strcat(metadata.Chromo2,'_',metadata.Chromo3);
result = Exp.Utilities.check_geno_input(geno);
result = 1;
    string = ('Checking genotype format ');
    unixy_output_pt1(string)
    if ~result; 
        unixy_output_pt2(0)        
        error('Genotype specified in metadata invalid'); 
    else
        unixy_output_pt2(1)        
    end
    geno_full = strcat(geno,'_',metadata.Effector);

%% Double check the metadata is correct with a(n overly complex) gui. 
% Additional option to save a temporary experiment with all fields 
% changed to testing, when saved.
main_fh = figure;
figName = 'Metadata for Current Experiment';
set(main_fh,'NumberTitle','off','Name',figName,'Position',[350,75,470,355],'PaperOrientation','portrait','Color','w');
annotation(main_fh, 'textbox',[.035 .885 .1 .1],'String',figName,'FontSize',12, 'FontWeight','demi', 'EdgeColor', 'white')

decision = 0;
[type value] = return_type_value(metadata);
make_popup_metadata_ui(main_fh,type,value);

    % Function to get a type and value cell for display on the 'gui'
    function [type_cell value_cell] = return_type_value(metadata)
        fields = fieldnames(metadata);
        for ind = 1:numel(fieldnames(metadata))
            type_cell{ind} = {getfield(metadata, fields{ind})};
            value_cell{ind} = fields(ind);
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
                [type_cell value_cell] = return_type_value(metadata);
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

%% Initialize the hardware and neccessary channels. Hard coded.
    string = ('Initializing hardware');
    unixy_output_pt1(string)
    daqreset; % useful!
    pause(.2);
    AI_wbf = analoginput('mcc',0);
    pause(.2);
    addchannel(AI_wbf, 0);
    pause(.2);
    DIO_trig = digitalio('mcc',0);
    pause(.2);
    addline(DIO_trig,0,'Out');
    pause(.2);

% For acquiring the actual data, if wanted
    if nargin > 2 ;
        if isnumeric(varargin{2}); 
            record = varargin{2};
        else
            error('record (varargin) incorrectly specified, supply binary')
        end
    else
        record = true;
    end

    if record
        DAQ_dev = analoginput('nidaq','Dev1');
        addchannel(DAQ_dev,[0:6]);
        daq_file = fullfile('C:\tf_tmpfs\',metadata.daqFile);
        set(DAQ_dev,'LoggingMode','Disk','LogFileName',daq_file,'SampleRate',1000);
        set(DAQ_dev,'SamplesPerTrigger',Inf); %,'TimerFcn',@AcquireData
    end
unixy_output_pt2(1)        

%% Start the experiment, initial alignment (with last condition, the default
% location for a closed loop interspersing condition) then write a
% conditions and a metadata file to the file determined by the conditions
% function and the genotype + datestr.

% Get the number of reps specified (or go to a defualt number of 3)
if nargin > 1 ;
    if isnumeric(varargin{1}); 
        reps = varargin{1};
    else
        error('reps (varargin) incorrectly specified, supply a number')
    end
else
    reps = 3;
end

% Set the configuration for the experiment, right now only using one for
% the whole experiment
string = ('Panels off, setting experiment panel config.Expect Box/Errors');
unixy_output_pt1(string)
Panel_com('all_off'); pause(.05)
Panel_com('set_config_id',cond_struct(1).PanelCfgNum); pause(4.5);
unixy_output_pt2(1)


% Initial alignment portion, use the last condition as the interspersal condition.
Nconds = numel(cond_struct); num_trials_missed = 0; already_emailed = 0;
Exp.Utilities.set_Panel_com(cond_struct(Nconds));
Panel_com('set_ao',[3,0]); % interspersed conditions are of voltage zero (easy decoding!)
Panel_com('start');
string = ('Initial alignment phase. Press any key to continue.');
unixy_output_pt1(string)
pause();
unixy_output_pt2(1)

if record;
    start(DAQ_dev); 
end

total_conds = (reps*(Nconds-1)); % The last condition of each doesn't count for this
curr_cond_index = 1;

for rep = 1:reps
    % Randomize a set of conditions to decrement for each repetition
    cond_nums = randperm(Nconds-1);
    
    while ~isempty(cond_nums)
        cond = cond_nums(1);
        % Changed to make the output more UINIXy, readable by padding
        % Might need to make this its own function... 
        % Output => Repetition [  1/  4] -- Trial [  93/ 400] -- Condition [  5/100]
        rep_progress = [ '[' repmat(' ',1,4-numel(num2str(rep))) num2str(rep) '/' repmat(' ',1,4-numel(num2str(reps))) num2str(reps) ']' ];
        trial_progress = [ '[' repmat(' ',1,4-numel(num2str(curr_cond_index))) num2str(curr_cond_index) '/' repmat(' ',1,4-numel(num2str(total_conds))) num2str(total_conds) ']' ];
        condition_progress = [ '[' repmat(' ',1,4-numel(num2str(cond))) num2str(cond) '/' repmat(' ',1,4-numel(num2str(Nconds-1))) num2str(Nconds-1) ']'];
        fprintf('Repetition %s -- Trial %s -- Condition %s ', rep_progress, trial_progress, condition_progress);    
        
        [time voltage] = Exp.Utilities.set_Panel_com(cond_struct(cond));
        % need to convert the voltage to 16 bit (2^15)-1
        voltage_16bit=voltage*(32767/10);
        Panel_com('stop');
        Panel_com('set_ao',[3,voltage_16bit]);
        Panel_com('start');
        pause(time);
        Panel_com('stop');
        Panel_com('set_ao',[3,0]); % Set the voltage to zero as soon as possible
        % Check that the fly was flying at the end of the condition,
        % then move on to next or add the trial back in.
        flying = Exp.Utilities.simple_end_wbf_check(AI_wbf,DIO_trig);
        
        if flying
            cond_nums = cond_nums(2:end);
            unixy_output_pt2(1)
        else
            unixy_output_pt2(-1)
            cond_nums = [cond_nums(2:end) cond];
            total_conds = total_conds+1;
            num_trials_missed = num_trials_missed +1;
            
            if num_trials_missed > 40 && already_emailed == 0;
                email_subject = ['WARNING: tfExperiment ' metadata.ExperimentName ' Requires Attention.'];
                email_message = ['Fly has not completed trials ' num2str(num_trials_missed) ' times.'];
                result = Exp.Utilities.send_email(email_subject,email_message);
                if ~result; disp('Error sending too many trials missed email'); 
                end
                already_emailed = 1;
            elseif num_trials_missed > 100 && already_emailed == 1; 
                email_subject = ['WARNING: tfExperiment ' metadata.ExperimentName ' Requires Attention.'];
                email_message = ['Fly has not completed trials ' num2str(num_trials_missed) ' times.'];
                result = Exp.Utilities.send_email(email_subject,email_message);
                if ~result; disp('Error sending too many trials missed email'); 
                end
                already_emailed = 2;
            end
            
        end
        curr_cond_index = curr_cond_index+1;
        
        % Interspersed condition (voltage already set to zero above)
        [time ~] = Exp.Utilities.set_Panel_com(cond_struct(Nconds));        
        Panel_com('start');
        pause(time);
        Panel_com('stop');
    end
end

%% Determine the file save location from metadata, make that directory, copy the patterns and functions to it, and save the metadata/conditions to that location.
% Establish the new file system storage location
root_data_loc = 'C:\tf_tmpfs';
data_location = fullfile(root_data_loc,metadata.Protocol,[metadata.Chromo2 '_' metadata.Chromo3 '__' metadata.Effector],metadata.ExperimentName);
% Move the temporary daq file to the new location
temp_daq_name = daq_file;
daq_location = fullfile(temp_daq_name);

fprintf('Experiment finished, moving temp daq file/writing metadata/conditions to %s \n',data_location');

% If manually recording, need a notification to stop.
if ~record
email_subject = ['tfExperiment ' metadata.ExperimentName ' Requires daq Stop.'];
email_message =' . ';
result = Exp.Utilities.send_email(email_subject,email_message);
    if ~result; disp('Error sending email'); 
    end
disp('If still manually recording, stop. Continue with any button')
pause();
else
   stop(DAQ_dev);
end

% Make the directory, move the daq file, and save metadata/conditions
mkdir(data_location);

    try movefile(daq_location,data_location);
    catch moveErr
       disp(moveErr.message);
       disp(data_location);
       disp('Problem moving daq file to above location! Do manually.')
    end
    
% A set of save and copies to get all relevant data to the experiment's
% folder
    try
        save(fullfile(data_location,'metadata'),'metadata');
    catch cpyErr
        disp(cpyErr.message)
        disp('Problem saving metadata.')
    end

    try
        conditions = cond_struct;
        save(fullfile(data_location,'conditions'),'conditions');
    catch cpyErr
        disp(cpyErr.message)
        disp('Problem evaluating/copying conditions')
    end

    try
        mkdir(fullfile(data_location),'patterns_on_SD_card');
        copyfile(pats_on_SD_path,fullfile(data_location,'patterns_on_SD_card'));
    catch cpyErr
        disp(cpyErr.message)
        disp('Problem moving/copying patterns')
    end
    
    try
        mkdir(fullfile(data_location),'functions_on_SD_card');
        copyfile(funcs_on_SD_path,fullfile(data_location,'functions_on_SD_card'));
    catch cpyErr
        disp(cpyErr.message)
        disp('Problem moving/copying functions')
    end
    
    try
        mkdir(fullfile(data_location),'cfgs_on_SD_card');
        copyfile(cfgs_on_SD_path,fullfile(data_location,'cfgs_on_SD_card'));
    catch cpyErr
        disp(cpyErr.message)
        disp('Problem moving/copying panel_cfgs')
    end
    
% Stop the timer.
timer = toc(tID);
% Send an email saying it is finished.
email_subject = ['tfExperiment ' metadata.ExperimentName ' Finished.'];
email_message = ['Duration = ', num2str(timer/60) ' mins .'];
result = Exp.Utilities.send_email(email_subject,email_message);
if ~result; disp('Error sending email'); end

if record
clear('DAQ_dev')
daqreset
end

fprintf('Finished in %d\n',timer);

    % For unixy output! (and... necessary clarity...)
    function unixy_output_pt1(string)
        string = [string, repmat(' ',1,(string_length-numel(string)))];
        fprintf(string)        
    end

    function unixy_output_pt2(worked)
    if worked
        fprintf('[Done]\n')
    elseif worked == 0
        fprintf('[Failed]\n')
    elseif worked == -1
        fprintf(' [Failed: Added back to queue.]\n')
    end
    end
end
