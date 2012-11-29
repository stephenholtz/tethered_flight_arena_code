function [averages, variance] = process_multi_rep_expansion_data(data)
% Expansion protocol analysis
%
% 'data' struct will have some optional fields and 'raw' with all the data
% for input: raw data from each of the repetitions of the expansion
% stimulus for multiple flies. Each set of reps will be another element in
% a cell array. i.e. data.raw{1} will be a matrix of timeseries for fly #
% 1, data.raw{2} will be the same for fly # 2. The output of this function
% will be the averages and standard error of groups of subsequent expansion
% stimulus for several flies. Each row of the output matricies is the group
% of adjacent stimuli.
%
% SLH - 10/2012

%% Deal with fields

% 'mean' 'median' etc., over the group size
if ~isfield(data,'moct_method')
data.moct_method = 'mean'; 
end

% Number of consecutive reps to group together
if ~isfield(data,'group_size')
data.group_size = 4; 
end

% Determine the minimum number of reps
min_size = inf;
for fly_num = 1:numel(data.raw)
    if size(data.raw{fly_num},1) < min_size
        min_size = size(data.raw{fly_num},1);
    end
end
if ~isfield(data,'num_reps') 
    data.num_reps = min_size;
else
    if min_size > data.num_reps
        warning('data.num_reps is greater than the minimum number of reps in data.raw')
        data.num_reps = min_size;
    end
end

%% Process the raw data

multi_fly_turn_resp_group = [];
fly_group_turn_resp_averages = [];

% Get the max num groups that works for all
data.num_groups = inf;
for i = 1:numel(data.raw)
    temp_num_groups = floor(size(data.raw{i},1)/data.group_size);
    if temp_num_groups < data.num_groups
        data.num_groups = temp_num_groups;
    end
end

curr_group = 1:data.group_size;

%--Iterate over each set of adjacent turning bouts
for i = 1:data.num_groups
    
    %--Iterate over each fly for this set of turning bouts and average 
    % within the one fly's turning response

    for j = 1:numel(data.raw)
        %--Use appropriate averaging method    
        if sum(strcmpi(data.moct_method,'median'))
            multi_fly_turn_resp_group(j,:) = median(data.raw{j}(curr_group,:)); %#ok<*AGROW>
        else
            multi_fly_turn_resp_group(j,:) = mean(data.raw{j}(curr_group,:));
        end
    end

    %--Average across the group of averaged fly turing responses
    
    %--Use appropriate averaging method    
    if sum(strcmpi(data.moct_method,'median'))
        fly_group_turn_resp_averages{i} = median(multi_fly_turn_resp_group);
    else
        fly_group_turn_resp_averages{i} = mean(multi_fly_turn_resp_group);
    end
    
    fly_group_turn_resp_variance{i} =  std(multi_fly_turn_resp_group) / sqrt(numel(data.raw));

    clear multi_fly_turn_resp_group;
    
    curr_group = curr_group + data.group_size;
    
end

% Push out from function
averages = fly_group_turn_resp_averages;
variance = fly_group_turn_resp_variance;

