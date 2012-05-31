classdef GUI
% RunGUI(condition_function, metadata_file, [num_reps default = 3]) RunGUI
% will run an experiment off of the condition_function, store the metadata
% from the meta file and acquire/store the raw data of an experiment.
% Made with the goal of getting rid of spikehound and minimizing steps to
% run an experiment.
%
% Exp.Run('short_telethon_experiment_2011','Exp.temp_meta_file')
%
% Info/functionality:
% - Initialize the GUI window.
%       * If the call was made with arguments, use those to populate the
%         gui with what should happen on "START"
% - Initialize the proper conditions with dropdowns/file browsers for the
%   condition_func, meta_file and reps
% - Allow 'checking' each condition, meta (hardware?) selection with a
%   button - Allow alignment separately from experiment - Acquire data to a
%   default location with default name, but make this changeable
% - Checkboxes for: termination with crappy fly (with slider for number of
%   messed up conditions), emailng if fly is crappy, emailing once experiment
%   is finished
% - A rough display of the channels being acquired (and waveform of wing beat??)
% 
% Wishlist
% - Have a reconstruction of what the fly sees. The easiest way for this to
% happen is for the conditions function to specifically reference a folder
% with its patterns, functions, etc., 
%       * might as well store this in the file system too.. (in both this
%         and in the regular Exp.Run)
% - Have a nice progress bar both in a given experiment and in a given
%   trial type
% - Have a minimal terminal mode    properties
% - Easter egg...
        
        
    properties        
        % These properties are populated once needed by the experiment
        conditions
        metadata
        
        % store all of the handles of the object here
        handles % fig (figure handle)
                % 
                % 
    end

    methods
        function gui = GUI
            % To construct the actual gui
            gui.handles.fig=figure('Name','Tethered Flight Experiment GUI','Numbertitle','off','tag','gSS07',...
                'position',[0 0 800 600],'resize','on','deletefcn',...
                @DelFcn,'doublebuffer','on','color','black');
            % Why not center the figure!
            centerfig(gui.handles.fig)
            
            % Set up the parts of the gui. Man this looks hacky.
            
            
            
            
        end
    end

    
end