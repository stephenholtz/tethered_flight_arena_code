function handle = simple_timeseries(data_cell,varargin)
% handle = simple_timeseries(data_cell,varargin)
% handle = simple_timeseries(data_cell,axes_handle,line_type)
%         data_cell:    data_cell{1} should be the means
%                       data_cell{2} should be + SEM
%                       data_cell{3} should be - SEM
%         data_cell:    data_cell{4:end} should be the above repeated...
%         varargin{1}:  add another trace to the plot, without
%         varargin{2}:  is the line type, i.e. '.' '--' etc.,
%         varargin{3}:  is the optional axes handle
%
%         * Plots confidence + or -, intelligently scales to one of 2 hard  
%           set values by checking all of the existing elements of the plot
%         * Also plots a dotted line on Y = 0 along all of X
%         * If needed, will also plot another trace (in gray?) without SEM,
%           i.e. for stripe tracking, plot the X Position
%
%   NOTE: hold on vs hold all is important for getting the colors correct
%   and consistent. hold on should be used within the function when color
%   should not change, but when the actual timeseries is plotted, it should
%   be hold all, so that it can be moved to the next value in the color map

    render_mode = 'no_alpha';

    % Make sure the data_cell has a multple of 3
    if mod(numel(data_cell),3)
       error('wrong number of elements in data_cell') 
    end
    
    % Extract all the plot components
    average_values  = data_cell{1};
    sem_plus_values = data_cell{2};
    sem_minus_values= data_cell{3};
    
    len_data_vec = 1:size(average_values,1);
    
    % Deal with varargin
    if nargin == 3
        previous_handle = varargin{3};
        line_string = varargin{2};
        diff_plot = varargin{1};
    elseif nargin == 2
        diff_plot = varargin{1};
        previous_handle = [];
        line_string = '-';
    else
        diff_plot =  [];
        previous_handle = [];
        line_string = '-';
    end

    % Get all the relevant series in the current axes
    potential_handles = get(gca,'Children');
    data_handles = potential_handles(find(strcmpi('line',get(get(gca,'Children'),'type')) == 1 | ...
                                          strcmpi('axes',get(get(gca,'Children'),'type')) == 1)); %#ok<*FNDSB>

    % If specified, plot another trace before (underneath) the real data
    if ~isempty(diff_plot) &&  ~sum(strcmpi('diff_plot',get(data_handles,'Tag'))) 
        hold('on')
        plot(len_data_vec,diff_plot,'-','Color',[.7 .7 .7]);
        set(max(get(gca,'Children')),'Tag','diff_plot')        
    end
    
    % Plot a line at zero (with Tag = 'zero_line')
    % Deterimine the correct color (opp of background white or black)
    if sum(get(gca,'Color')) == 0
        zero_color = [1 1 1];
    else
        zero_color = [0 0 0];
    end
    
%     if ~sum(strcmpi('zero_line',get(data_handles,'Tag')))   
%         hold('on')
%         plot(len_data_vec,zeros(1,numel(len_data_vec)),'LineStyle','--','Color',zero_color);
%         set(max(get(gca,'Children')),'Tag','zero_line')
%     end
    
    % Plot the mean
    for i = 1:size(average_values,2)
        handle = plot(len_data_vec, average_values(:,i), line_string);
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
        % len_data_vec_no_x_overlap =len_data_vec;
        sem_transparency_x_vals = [len_data_vec_no_x_overlap, fliplr(len_data_vec_no_x_overlap)];
        sem_transparency_y_vals = [sem_minus_values(:,i)', fliplr(sem_plus_values(:,i)')];
        sem_trasnparency_z_vals = -eps*ones(1,numel(sem_transparency_y_vals));
        switch render_mode
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
    end
    % Two modes of X axis:
    %       1) -3.1 3.1 if max < 3.15
    %       2) -5.1 5.1 if max >= 3.15
    
    % Append all these together and take the max/min values
    YData = get(data_handles,'YData');
    y_max_value = max([YData{:}]);
    XData = get(data_handles,'XData');
    x_max_vec = [min([XData{:}]) max([XData{:}])];
    
    % Also need to reapply the X and Y axis for some reason after a patch
    if y_max_value(1) < 3.15
        set(gca,'YLim',[-3.1 3.1],'XLim',x_max_vec)
    elseif y_max_value(1) < 10
        set(gca,'YLim',[-5.5 5.5],'Xlim',x_max_vec)
    else
        set(gca,'YLim',[-y_max_value y_max_value])
    end
    
    % hard coded for now...
    % set(gca,'YLim',[-4.1 4.1],'Xlim',x_max_vec)
    
    % Set back to hold all so the color can change!
    hold('on')
end