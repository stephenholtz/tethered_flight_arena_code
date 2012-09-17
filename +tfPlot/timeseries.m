function handle = timeseries(graph)
% handle = simple_timeseries(graph[struct])
% Required Fields:
%   graph.avg{i}: mean or central line for the timeseries
%   graph.variance{i}: the measure of variance (sem, std) of the mean (will
%   actually default to zeros if empty)
%   
% Optional Fields:
%   graph.handle: axes handle to plot in
%   graph.render_mode: either 'no_alpha' (default) or 'alpha'
%   graph.ylim: will default to either -3.1 3.1 if max < 3.1 OR -5.1 5.1 if
%       max >= 3.15; or take explicit bounds as [min max]
%   graph.xlim: 
%   graph.color{i}: to be explicit with colors set, otherwise will use hold
%       all to increment over colors already in default colormap
%   graph.zero_line: if evaluates to true, then will add dotted line at y =
%       zero defaults to on
%
% Note: if there is only one element, then the function turns the input
% into a cell array of size one where iteration is needed for multiple
% inputs, i.e. for avg variance and color (need to use rmfield for this).
%
%  SLH - 2012

%% Handle the struct fields. Much nicer than using varargin bs.

if isfield(graph,'avg')  && ~isempty(graph.avg)
    if ~iscell(graph.avg)
        tmp = graph.avg;
        graph = rmfield(graph,'avg');
        graph.avg{1} = tmp;
    end
else
    error('tfPlot.timeseries requires cell array field "avg"')
end

if isfield(graph,'variance') && ~isempty(graph.variance)
    if ~iscell(graph.variance)
        tmp = graph.variance;
        graph = rmfield(graph,'variance');
        graph.variance{1} = tmp;
    end
else
    error('tfPlot.timeseries requires cell array field "variance"')
end

if ~isfield(graph,'handle')
    graph.handle = gca;
end

if ~isfield(graph,'render_mode')
   graph.render_mode = 'no_alpha'; 
end

if ~isfield(graph,'ylim')
    % need logic :(
end

if ~isfield(graph,'xlim');
    % need logic :(
end

if isfield(graph,'color')
    if ~iscell(graph.color)
        tmp = graph.color;
        graph = rmfield(graph,'color');
        graph.color{1} = tmp;
    end
else
    graph.color = false;
end

if ~isfield(graph,'zero_line')
    graph.zero_line = true;
end

%%  Do the actual plotting work

for i = 1:numel(graph.avg)
    % Extract all the plot components
    average_values  = graph.avg{i};
    sem_plus_values = graph.avg{i} + graph.variance{i};
    sem_minus_values= graph.avg{i} - graph.variance{i};
    len_data_vec = 1:numel(average_values);
    
    % Get all the relevant series in the current axes
    potential_handles = get(gca,'Children');
    data_handles = potential_handles(find(strcmpi('line',get(get(gca,'Children'),'type')) == 1 | ...
                                          strcmpi('axes',get(get(gca,'Children'),'type')) == 1)); %#ok<*FNDSB>
    
%     % If specified, plot another trace before (underneath) the real data
%     if ~isempty(diff_plot) &&  ~sum(strcmpi('diff_plot',get(data_handles,'Tag'))) 
%         hold('on')
%         plot(len_data_vec,diff_plot,'-','Color',[.7 .7 .7]);
%         set(max(get(gca,'Children')),'Tag','diff_plot')        
%     end
    
    % Plot a line at zero (with Tag = 'zero_line')
    % Deterimine the correct color (opp of background white or black)
    if sum(get(gca,'Color')) == 0
        zero_color = [1 1 1];
    else
        zero_color = [0 0 0];
    end
    
    % Create a line at zero if needed
    if graph.zero_line && ~sum(strcmpi('zero_line',get(data_handles,'Tag')))
        hold('on')
        plot(len_data_vec,zeros(1,numel(len_data_vec)),'LineStyle','--','Color',zero_color);
        set(max(get(gca,'Children')),'Tag','zero_line')
    end
    
    % Plot the mean
    
    handle = plot(len_data_vec, average_values);
    
    if iscell(graph.color)
        set(handle,'color',graph.color{i})
    end    
    
    hold('on');
    
    % Get the color of the last line drawn (after refreshing the vars)
    
    potential_handles = get(gca,'Children');
    
    data_handles = potential_handles(find(strcmpi('line',get(get(gca,'Children'),'type')) == 1 | ...
                                          strcmpi('axes',get(get(gca,'Children'),'type')) == 1)); %#ok<*FNDSB>
    
    color_handle = max(potential_handles(strcmpi('line',get(get(gca,'Children'),'type')))); %#ok<*FNDSB>
    
    line_color_matrix = get(color_handle,'Color');
    
    % Increase the 'brightness' by 75%
    
    line_color_matrix = line_color_matrix+(1-line_color_matrix)*.75;

    % Calculate the transparency values
    
    len_data_vec_no_x_overlap =[(1+(1*eps))*len_data_vec(1) len_data_vec(2:end-1) (1-eps)*len_data_vec(end)];
    
    sem_transparency_x_vals = [len_data_vec_no_x_overlap, fliplr(len_data_vec_no_x_overlap)];
    
    sem_transparency_y_vals = [sem_minus_values, fliplr(sem_plus_values)];
    
    sem_trasnparency_z_vals = -eps*ones(1,numel(sem_transparency_y_vals));
    
    switch graph.render_mode
        case 'no_alpha'
            patch(  'XData',    sem_transparency_x_vals,...
                    'YData',    sem_transparency_y_vals,...
                    'ZData',    sem_trasnparency_z_vals,...
                    'FaceColor', line_color_matrix,...
                    'EdgeColor', 'none');
        case 'alpha'
            % This method does not work due to the openGL renderer, will break the axes
            patch(  'XData',    sem_transparency_x_vals,...
                    'YData',    sem_transparency_y_vals,...
                    'FaceColor', line_color_matrix,...
                    'EdgeColor', 'none',...
                    'FaceAlpha', .35);
    end
    
    hold all
    
    % Two modes of X axis:
    %       1) -3.1 3.1 if max < 3.15
    %       2) -5.1 5.1 if max >= 3.15
    % Append all these together and take the max/min values
    
    YData = get(data_handles,'YData');
    
    if iscell(YData)
        y_max_value = max([YData{:}]);
    else
        y_max_value = max(YData);
    end
    
    XData = get(data_handles,'XData');
    
    if iscell(XData)
        x_max_vec = [min([XData{:}]) max([XData{:}])];        
    else
        x_max_vec = [min(XData) max(XData)];        
    end
    
    % Also need to reapply the X and Y axis for some reason after a patch
    if y_max_value(1) < 3.15
        set(gca,'YLim',[-3.1 3.1],'XLim',x_max_vec)
    elseif y_max_value(1) < 10
        set(gca,'YLim',[-5.5 5.5],'Xlim',x_max_vec)
    else
        set(gca,'YLim',[-y_max_value y_max_value])
    end
    
    hold('on')
    
end
end