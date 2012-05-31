function fig_children = fixfig_subplot(X_INDS, Y_INDS, tick_size, x_offset, y_offset, handles)
% function fixfig_subplot(X_INDS, Y_INDS, tick_size, x_offset, y_offset, handles)
% * tick_size is a scaling term, [1 1] would leave the scaling the same
% * this function takes the current matlab figures and modifies it so that
% the axes are now offset from the data. The x_offset and y_offset values
% are to be specified as the offset ammount as a ratio of the current 
% window size. The default value is 0.03 or 3% for both X, Y. This function
% will slightly increase the window size but retains the exact size of the
% original plot area. 
% Original version - MBR June 13, 2006
% Revised - JCT/SLH 12/5/11
if nargin == 6
    fig_children = handles;
elseif nargin == 5
    fig_children = get(gcf,'Children');
elseif nargin == 4
    x_offset = x_offset;
    y_offset = x_offset;
    fig_children = get(gcf,'Children');  
elseif nargin == 3
    fig_children = get(gcf,'Children');  
    x_offset = 0.03;
    y_offset = 0.03;
elseif nargin == 2
    fig_children = get(gcf,'Children');  
    tick_size = [1 1];
    x_offset = 0.03;
    y_offset = 0.03;
elseif nargin < 2
    error('Must specify list of children indices to offset X and Y axes');
end

% Duplicate the current figure, this really cut way...
gca
saveas(gcf,'temp.fig')
open('temp.fig');
delete('temp.fig');
gca

% First deal with figure level settings
set(gcf, 'Units', 'pixels');
fig_props = get(gcf);
fig_width = fig_props.Position(3);
fig_height = fig_props.Position(4);
x_pix_offset = ceil(fig_height*x_offset);
y_pix_offset = ceil(fig_width*y_offset);
new_size = [fig_props.Position(1:2) fig_width + y_pix_offset ...
    fig_height + x_pix_offset];


for j = 1:length(fig_children)
    % Deal with each subplot separately
    axes(fig_children(j)); % make current axes
    set(gca, 'Units', 'normalized');
    axes_props = get(gca);
    x_label_props = get(axes_props.XLabel);
    y_label_props = get(axes_props.YLabel);
    % test to see if need to offset
    offset_X = any(j == X_INDS);
    offset_Y = any(j == Y_INDS);
    axes_width = axes_props.Position(3);
    axes_height = axes_props.Position(4);
    axis off 
     
    if (offset_X)
        x_axes_position = [axes_props.Position(1) axes_props.Position(2) - x_offset ...
        axes_props.Position(3) 0.001];

        X_tick_labels  = text_array_2_cell_array(axes_props.XTickLabel);
        x_axes = axes('position',x_axes_position, 'XLim', axes_props.XLim, ... % X_lims,  
        'XTick', axes_props.XTick, 'XTickLabel', X_tick_labels, ... % axes_props.XTickLabel,
        'XScale', axes_props.XScale, 'YLim', [0 1e-10], 'YTick', []);
        set(x_axes, 'TickLength', [0.02*tick_size(1) 0.25]);
        xlabel(x_label_props.String);
        
    end

    if (offset_Y)
        y_axes_position = [axes_props.Position(1) - y_offset axes_props.Position(2) ...
        0.001 axes_props.Position(4)];

        % set limits to be min and max tick marks - good idea, but not in
        % general? 
        Y_lims = [min(axes_props.YTick) max(axes_props.YTick)];
        Y_tick_labels  = text_array_2_cell_array(axes_props.YTickLabel);
        y_axes = axes('position',y_axes_position, 'YLim', axes_props.YLim, ... % Y_lims,
            'YTick', axes_props.YTick, 'YTickLabel', Y_tick_labels, ...
            'YScale', axes_props.YScale, 'XLim', [0 1e-10], 'XTick', []);
        set(y_axes, 'TickLength', [0.02*tick_size(2) 0.25]);
        ylabel(y_label_props.String);
    end
 end

function CA = text_array_2_cell_array(TA)
% function CA = text_array_2_cell_array(TA)
% this function takes an array of text values and converts to a cell array
% of the individual text elements, removing the white space.

% first make sure that you don't have a CA
if iscell(TA)
    CA = TA;
else
    [num_string, max_string_length] = size(TA);

    for j = 1:num_string
        % take each row of text and just keep the non white space and put as an
        % entry in a cell array.
      CA{j} = TA(j,~isspace(TA(j,:)));
    end
end
    