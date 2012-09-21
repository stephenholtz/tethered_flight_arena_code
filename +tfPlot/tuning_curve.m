function handle = tuning_curve(graph)
% handle = timeseries(graph[struct])
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
%   graph.x_offset: is the amount of offset between the line plotted and
%       the one before it
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
    error('tfPlot.tuning_curve requires cell array field "avg"')
end

if isfield(graph,'variance') && ~isempty(graph.variance)
    if ~iscell(graph.variance)
        tmp = graph.variance;
        graph = rmfield(graph,'variance');
        graph.variance{1} = tmp;
    end
elseif isempty(graph.variance)
    for i = 1:numel(graph.avg);
        graph.variance{i} = zeros(1,numel(graph.avg{i}));
    end
else
    error('tfPlot.tuning_curve requires cell array field "variance"')
end

if ~isfield(graph,'handle')
    graph.handle = gca;
end

if ~isfield(graph,'render_mode')
   graph.render_mode = 'no_alpha'; 
end

if ~isfield(graph,'ylim')
    graph.ylim = 0;
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

if ~isfield(graph,'x_offset')
    graph.x_offset = 0;    
end

if ~isfield(graph,'line_width')
    graph.line_width = 1;    
end

%% Deal with offsets
%     % Should check for previously plotted lines, and iterate the x_offset
%     % Give option for the offset factor as varargin{1}
%     if nargin == 2
%         x_offset_factor    = varargin{1};
%     else
%         x_offset_factor    = 0;
%     end

% Determine the number of previous tuning curve objects for offset
% calculation (i.e. if plotting using hold all)
try
    prev_err_handles = get(gca,'Children');
    num_prev_plots = numel(prev_err_handles);
catch %#ok<CTCH>
    num_prev_plots = 0;
end

for i = 1:numel(graph.avg)
    
    hold all
    
    x_offset = graph.x_offset*(num_prev_plots + i-1);
    x_positions = 1:numel(graph.avg{i}) + x_offset;
    
    % if there is no variance, then the line should be a regular one,
    % instead of errorbars
    
    if sum(graph.variance{i}) == 0
        
        plot(x_positions,graph.avg{i},'-o','MarkerFaceColor','none','Color',graph.color{i},'LineWidth',graph.line_width)
        
    else
        
        handle = errorbar(x_positions,graph.avg{i},graph.variance{i},...
                                'Marker','o',...
                                'MarkerFaceColor','none',...
                                'MarkerSize',4,...
                                'Color',graph.color{i},...
                                'LineWidth',graph.line_width);
    end
    
    
    if graph.zero_line
        
        % Plot a line at zero in the correct color (opp of background white or black)
        
        if sum(get(gca,'Color')) == 0
            zero_color = [1 1 1];
        else
            zero_color = [0 0 0];
        end

        y_vals = get(gca,'YLim');
        x_vals = get(gca,'XLim');
        x_len_vec = x_vals(1):diff(x_vals)/10:x_vals(2);

        % If the range hits the x axis, plot a dotted line
        
       % if y_vals(1)*y_vals(2) < 1 || y_vals(1)*y_vals(2) == 0
            hold('all')
            plot(x_len_vec,zeros(1,numel(x_len_vec)),'LineStyle','--','Color',zero_color);
            set(max(get(gca,'Children')),'Tag','zero_line')
       % end
    end
    
    % Use the function below, pretty worthless in here, so need to
    % intelligently scale with an external function
    fix_ebar_tee_width(4);
    
end

% Two modes of Y axis:
%       1) -3.1 3.1 if max < 3.15
%       2) -5.1 5.1 if max >= 3.15
% Append all these together and take the max/min values

potential_handles = get(gca,'Children');
    
data_handles = potential_handles(find(strcmpi('line',get(get(gca,'Children'),'type')) == 1 | ...
                                      strcmpi('axes',get(get(gca,'Children'),'type')) == 1)); %#ok<*FNDSB>

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
% if ~isempty(y_max_value) && y_max_value(1) < 3.15
%     set(gca,'YLim',[-3.1 3.1],'XLim',x_max_vec)
% elseif ~isempty(y_max_value) && y_max_value(1) < 10
%     set(gca,'YLim',[-5.5 5.5],'Xlim',x_max_vec)
% elseif ~isempty(y_max_value)
%     set(gca,'YLim',[-y_max_value y_max_value])
% end

if graph.ylim
    set(gca,'YLim', graph.ylim)
end


% Hard coded to 'fix' ebar plots where there are just one 
if numel(x_positions) == 1
    set(gca,'XLim',[0 2])
end


    function fix_ebar_tee_width(width_mod)
    % this function widens the tee on errorbars by the factor specified in
    % width_mod, a factor of 2 doubles the width, 0.5 will halve it. 
    % this does not work for subplots (yet)


    % first get all children of current axes
    axis_children = get(gca,'Children');

    for j = 1:length(axis_children)
        axis_gen2 = get(axis_children(j), 'Children');
        if (length(axis_gen2) == 2)
            %make sure you are dealing with the correct object,
            % the second child should have 9 times the data points as the first
            x = get(axis_gen2(1), 'XData');
            npt = length(x);
            if (length(get(axis_gen2(2), 'XData')) == 9*npt)
                [~] = get(axis_gen2(2), 'XData');
                tee = width_mod*(max(x(:))-min(x(:)))/100;  % make tee .02 x-distance for error bars
                xl = x - tee;
                xr = x + tee;
                % build up nan-separated vector for bars
                xb = zeros(npt*9,1);
                xb(1:9:end,:) = x;
                xb(2:9:end,:) = x;
                xb(3:9:end,:) = NaN;
                xb(4:9:end,:) = xl;
                xb(5:9:end,:) = xr;
                xb(6:9:end,:) = NaN;
                xb(7:9:end,:) = xl;
                xb(8:9:end,:) = xr;
                xb(9:9:end,:) = NaN;     
                set(axis_gen2(2), 'XData', xb);
            else
                warning('something odd here, skip this series');    
            end
        end
    end
    end   
end