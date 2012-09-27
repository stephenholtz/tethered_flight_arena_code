function [parsed_exp_data voltage_encoding_values data_segments] = parse_tf_data(varargin) 
% [parsed_exp_data voltage_encoding_values inter_encoding_segment_data]= parse_raw_data() 
% Function will parse all .daq files in the current or specified directory,
% or a single or set of specified files in a cell array based on changes in
% a voltage encoded signal. Breaks data down based on changes in one of the
% channels. Does not care about content of each data segment unless durations are specified (in seconds).
% Will output parsed_exp_data, a struct containing each channel from the
% .daq files. It will be ordered by the value of each encoding, which is
% output in voltage_encoding_values. Also outputs data_segments which
% contain the position of each condition in the original data.
%
% THE LAST CONDITION WILL BE ALL THE CLOSED LOOP TRIALS IN THE ORDER THEY
% OCCURRED, TRUNCATED BY THE LENGTH OF THE LAST VALUE IN THE CONDITION
% LENGTHS PASSED.
%
% Leave all the fancy analysis for after the raw data is placed in the
% parsed_exp_data struct, unless conditions are passed, that is. places in
% db friendly field names. Get function input into common form
%   
% If the lengths are given, then segments which are too short (i.e. failed)
% are not included. Error checking is still needed after this to select for
% good conditions.

if nargin == 2
    data_files = varargin(1);
    condition_lengths = varargin{2};
else 
    data_files = varargin(1);
    condition_lengths = [];
end


% Constant variables. May need optimization in the future
ANALOGTOLERANCE         = 0.025;
DURATIONTOLERANCE       = 0.05;
SAMPLERATE              = 1000;

% Parse data on a fly by fly basis
for flyNum = 1:numel(data_files)
%     fprintf('flyNum = %d of %d \n',flyNum,numel(data_files));
    % Split Needed Chans from the .daq file
    RawData         = daqread(data_files{flyNum});         
    encoded_signal  = RawData(:,7); %  Changed from 6 since grounding more effectively around 3/2012
    
    % Find all the times where adjacent voltage values differ by a
    % tolerance
    coarse_differences  = find(abs(diff(encoded_signal > ANALOGTOLERANCE)));
    coarse_differences  = [coarse_differences((diff(coarse_differences) > DURATIONTOLERANCE*SAMPLERATE)); coarse_differences(end)];
    
    % Group the similar voltage segment
    start_value = coarse_differences(1:2:end);    
    end_value   = coarse_differences(2:2:end);
    
    % Determine the voltage_values
    voltage_values = [];   
    for value_index = 1:numel(end_value) % Use end_value to avoid errors
        curr_voltage_values = encoded_signal(start_value(value_index):end_value(value_index));
        curr_voltages = median(curr_voltage_values); % Best moct to use here
        voltage_values = [voltage_values curr_voltages];
    end
    
    % Sort and determine unique values. Assume each is a condition where
    % its index == its condition number in the experiment. Much cleaner to
    % break it into two for loops.
    voltage_values = sort([voltage_values Inf]);
    voltage_values = voltage_values(diff(voltage_values) > ANALOGTOLERANCE/2);
    % Make sure there are actually a reasonable number of voltage values
    % left... i.e. the tolerance is not set wrong
    if (numel(voltage_values) < 1) || (numel(voltage_values) < numel(condition_lengths)*.5)
        error('Problem with voltages parsed. Probably a bad tolerance value')
    end
    % Some error checking on the diff between voltage_values (all should be
    % just about equal...)
    if range(diff(voltage_values)) > ANALOGTOLERANCE*2
        error('Problem with parsing voltage values: diff is inconsistent');
    end
    
    % Does not determine the duration values, and the correct padding --
    % ensures no knowledge of the conditions is needed at this stage in
    % processing -- will just store all and require later slicing/striding.
    for cn = 1:numel(voltage_values); segment_voltages{cn} = []; ExpData{cn} = []; end %#ok<*AGROW>
        successful_rep_num = 0;
    
    for value_index = 1:numel(end_value)
        current_block = start_value(value_index):end_value(value_index);
        curr_voltage_values = encoded_signal(current_block);
        [~, condition_number] = min(abs(mean(curr_voltage_values) - voltage_values));
        
        % Check to see what the rep is. More robust than a counter, and now
        % don't need to finish all of one trial before second conds start!
        rep = 1;
        while ~isempty(ExpData{rep,condition_number})
            rep = rep + 1;
            % If matlab can't index into the current row, add another.
            try ExpData{rep,:};                             %#ok<VUNUS>
            catch err
                [~] = err;
                ExpData{rep,condition_number} = [];
                segment_voltages{rep,condition_number} = [];                
            end                
        end
        
        segment_voltages{rep, condition_number} = [current_block(1) current_block(end)];
        ordered_segment_voltages{value_index} = [current_block(1) current_block(end)];
        
        if ~isempty(condition_lengths)
        condition_length = condition_lengths(condition_number)*SAMPLERATE;
            
            if numel(current_block) >= condition_length;
            ExpData{rep, condition_number}.left_amp         = RawData(current_block(1:condition_length),1)';
            ExpData{rep, condition_number}.x_pos            = RawData(current_block(1:condition_length),4)';
            ExpData{rep, condition_number}.right_amp        = RawData(current_block(1:condition_length),2)';
            ExpData{rep, condition_number}.y_pos            = RawData(current_block(1:condition_length),5)';
            ExpData{rep, condition_number}.wbf              = RawData(current_block(1:condition_length),3)';
            ExpData{rep, condition_number}.voltage          = encoded_signal(current_block(1:condition_length))';
            ExpData{rep, condition_number}.free              = RawData(current_block(1:condition_length),6)';
            end
            
        else
        ExpData{rep, condition_number}.left_amp         = RawData(current_block,1)';
        ExpData{rep, condition_number}.x_pos            = RawData(current_block,4)';
        ExpData{rep, condition_number}.right_amp        = RawData(current_block,2)';
        ExpData{rep, condition_number}.y_pos            = RawData(current_block,5)';
        ExpData{rep, condition_number}.wbf              = RawData(current_block,3)';
        ExpData{rep, condition_number}.voltage          = encoded_signal(current_block)';
        ExpData{rep, condition_number}.free             = RawData(current_block,6)';
            
        end
    end
    
    % Accumulate the closed loop portions now, using the segment voltages.
    % And append this onto the ExpData cell array at the end.
    condition_number = size(ExpData,2) + 1;
    
    successful_rep_num = 0;
    for rep = 1:numel(ordered_segment_voltages)-1
        
        current_block = ordered_segment_voltages{rep}(2):ordered_segment_voltages{rep+1}(1);
        
        if ~isempty(condition_lengths)
        condition_length = condition_lengths(numel(condition_lengths))*SAMPLERATE;
            
            if numel(current_block) >= condition_length;
            successful_rep_num = successful_rep_num +1;
            
            ExpData{successful_rep_num, condition_number}.left_amp         = RawData(current_block(1:condition_length),1)';
            ExpData{successful_rep_num, condition_number}.x_pos            = RawData(current_block(1:condition_length),4)';
            ExpData{successful_rep_num, condition_number}.right_amp        = RawData(current_block(1:condition_length),2)';
            ExpData{successful_rep_num, condition_number}.y_pos            = RawData(current_block(1:condition_length),5)';
            ExpData{successful_rep_num, condition_number}.wbf              = RawData(current_block(1:condition_length),3)';
            ExpData{successful_rep_num, condition_number}.voltage          = encoded_signal(current_block(1:condition_length))';
            ExpData{successful_rep_num, condition_number}.free              = RawData(current_block(1:condition_length),6)';
            end
            
        else
        
        ExpData{rep, condition_number}.left_amp         = RawData(current_block,1)';
        ExpData{rep, condition_number}.x_pos            = RawData(current_block,4)';
        ExpData{rep, condition_number}.right_amp        = RawData(current_block,2)';
        ExpData{rep, condition_number}.y_pos            = RawData(current_block,5)';
        ExpData{rep, condition_number}.wbf              = RawData(current_block,3)';
        ExpData{rep, condition_number}.voltage          = encoded_signal(current_block)';
        ExpData{rep, condition_number}.free              = RawData(current_block,6)';
        end       
    end
    

% Change to the output variables, is this bad practice?    
parsed_exp_data{flyNum} = ExpData;
voltage_encoding_values{flyNum} = voltage_values;
data_segments = segment_voltages;

% Clean up
ExpData = [];
voltage_values = [];
segment_voltages = [];
ordered_segment_voltages = [];

end
