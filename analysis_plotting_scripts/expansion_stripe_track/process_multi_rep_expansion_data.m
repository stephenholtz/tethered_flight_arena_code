function [averages, variance] = process_multi_rep_expansion_data(data)
% Expansion protocol analysis
%
% 'data' struct will have some optional fields and 'raw' with all the data
% for input: raw data from each of the repetitions of the expansion
% stimulus for multiple flies. Each set of reps will be another element in
% a cell array. i.e. data.raw{1} will be a matrix of timeseries for fly #
% 1, data.raw{2} will be the same for fly # 2. The output of this function
% will be the averages and standard error of groups of subsequent expansion
% stimulus for several flies.
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

fly_group_averages = [];
across_fly_groups = [];

% For each individual fly
for i = 1:numel(data.raw)
        
    num_groups = numel(data.raw)/data.group_size;
        
    curr_group = 1:data.group_size;    
    
    grouped_reps = [];
    
    % For all the groups of data
    for j = 1:num_groups
                
        temp_grouped_rep_mat = [];
        
        % Assemble groups of data
        for g = 1:numel(data.group_size)
            
            temp_grouped_rep_mat(g,:) = data.raw{curr_group(g)}(1:data.num_reps,:); %#ok<*AGROW>
            
        end
        
        % Average the group of the single fly's data
        grouped_reps(j,:) = mean(temp_grouped_rep_mat);
        
        % Assemble each group across flies into a cell array (for moct)
        across_fly_groups{j}(i,:) = temp_grouped_rep_mat;
        
        curr_group = curr_group + data.group_size;
        
    end
    
    % here {i} is the fly, this is unused right now, but could be useful
    fly_group_averages{i} = grouped_reps;
    
end

% Calculate averages and variances
for i = 1:numel(across_fly_groups)
   averages(i,:) = mean(across_fly_groups{i});
   variance(i,:) = std(across_fly_groups{i}) / sqrt(numel(data.raw));
end
