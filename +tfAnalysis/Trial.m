classdef Trial < handle
    %TRIAL contains the metadata for each individual trial of a given
    %   stimulus type (an indivudual instance of a condition, i.e.). There
    %   are no computations needed on this level for tethered flight, it is
    %   just a property holder. It will have one data object which will
    %   have DAQ properties.
    %
    %   TRIAL and the data object it contains are automatically populated 
    %   by tfAnalysis.import
    
    properties
        trial_name
        
        % Conditions of the trial
        cond_num
        rep_num
        pat_id
        gains
        mode
        duration
        init_pos
        func_freq_x
        pos_func_x
        func_freq_y
        pos_func_y
        vel_func
        voltage
        pos_func_name_x
        pos_func_name_y
        pattern_name
        panel_cfg_num
        panel_cfg_name
        
        % Cell array of data objects
        data
        
    end
    
    methods
        function self = Trial()
        end
    end
end
