function [parsed_exp_data voltage_encoding_values data_segments] = parse_data(varargin) 
% [parsed_exp_data voltage_encoding_values inter_encoding_segment_data]= parse_data() 
% Function will parse all .daq files in the current or specified directory,
% or a single or set of specified files in a cell array based on changes in
% a voltage encoded signal. Breaks data down based on changes in one of the
% channels. Does not care about content of each data segment.
% Will output parsed_exp_data, a struct containing each channel from the
% .daq files. It will be ordered by the value of each encoding, which is
% output in voltage_encoding_values. Also outputs data_segments which
% contain the position of each condition in the original data.
% TODO:
% If possible, it will also output inter_encoding_segment_data, a struct
% containing all of the data in between the encoded segments, will group
% them according to the condition that it follows.

% Leave all the fancy analysis for after the raw data is placed in the
% parsed_exp_data struct!

% Get function input into common form
if nargin == 0
    data_source = cd;
elseif nargin >=  1;
    data_source = {varargin(:)};
end

% Generate data file list cell array
data_files = generate_data_file_list(data_source, '.daq');
if ~iscell(data_files); error('Could not retrieve data file locations'); end

% Constant variables. May need optimization in the future
ANALOGTOLERANCE         = 0.009;
DURATIONTOLERANCE       = 0.05;
SAMPLERATE              = 1000;

% Parse data on a fly by fly basis
for flyNum = 1:numel(data_files)
    fprintf('flyNum = %d of %d \n',flyNum,numel(data_files));
    % Split Needed Chans from the .daq file
    RawData         = daqread(data_files{flyNum});         
    encoded_signal  = RawData(:,6);
    
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
        curr_voltages = mean(curr_voltage_values);
        voltage_values = [voltage_values curr_voltages];
    end
    % Sort and determine unique values. Assume each is a condition where
    % its index == its condition number in the experiment. Much cleaner to
    % break it into two for loops.
    voltage_values = sort([voltage_values Inf]);
    voltage_values = voltage_values(diff(voltage_values) > ANALOGTOLERANCE);
    
    % Does not determine the duration values, and the correct padding --
    % ensures no knowledge of the conditions is needed at this stage in
    % processing -- will just store all and require later slicing/striding.
   for cn = 1:numel(voltage_values); segment_voltages{cn} = []; ExpData{cn} = []; end %#ok<*AGROW>

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
        
        ExpData{rep, condition_number}.LeftAmp        = RawData(current_block,1);
        ExpData{rep, condition_number}.X_Pos          = RawData(current_block,4);
        ExpData{rep, condition_number}.RightAmp       = RawData(current_block,2);
        ExpData{rep, condition_number}.Y_Pos          = RawData(current_block,5);
        ExpData{rep, condition_number}.WBF            = RawData(current_block,3);
        ExpData{rep, condition_number}.EncodedSignal  = encoded_signal(current_block);
        ExpData{rep, condition_number}.LeftMinRight   = RawData(current_block,7);
    end

% Change to the output variables, is this bad practice?    
parsed_exp_data{flyNum} = ExpData;
voltage_encoding_values{flyNum} = voltage_values;
data_segments = segment_voltages;

% Clean up
ExpData = [];
voltage_values = [];
segment_voltages = [];

end
