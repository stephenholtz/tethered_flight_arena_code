function fixfig(x_offset, y_offset, tick_size)
% function fixfig(x_offset, y_offset, tick_size)
% this function takes the current matlab figures and modifies it so that
% the axes are now offset from the data. The x_offset and y_offset values
% are to be specified as the offset ammount as a ratio of the current 
% window size. The default value is 0.03 or 3% for both X, Y. This function
% will slightly increase the window size but retains the exact size of the
% original plot area. The tick_size argument rescales the tick length, a
% value of [1 1], will leave them unchanged, [1 2] will double the length
% of the y-axis ticks, etc. 
% Original version - MBR June 13, 2006
% Changes:
% 06/14/06 to include X/YScale term to make this work for log plots
% 06/16/06 added text array to cell array conversion for tick label text
% 09/23/06 added tick_size rescaling option.
% This is a work in progress.
% To do - 
% window resizing is not exactly perfect, test further

if nargin == 1
    x_offset = x_offset;
    y_offset = x_offset;
    tick_size = [1 1];
elseif nargin == 0    
    x_offset = 0.03;
    y_offset = 0.03;
    tick_size = [1 1];
end
 
% first make a new copy of the figure
saveas(gcf,'temp.fig')
open('temp.fig');
delete('temp.fig'); % clean up

% to make code below work, make sure units are consistent - 
set(gcf, 'Units', 'pixels');
set(gca, 'Units', 'normalized');

fig_props = get(gcf);
axes_props = get(gca);
x_label_props = get(axes_props.XLabel);
y_label_props = get(axes_props.YLabel);
fig_width = fig_props.Position(3);
fig_height = fig_props.Position(4);
x_pix_offset = round(fig_height*x_offset);
y_pix_offset = round(fig_width*y_offset);

new_size = [fig_props.Position(1:2) fig_width + y_pix_offset ...
    fig_height + x_pix_offset];
set(gcf, 'Position', new_size);

% position_rectangle = [left, bottom, width, height];
new_axes_position = [axes_props.Position(1)./(1 - 5*y_offset)...
    axes_props.Position(2)./(1 - 5*x_offset)...
    axes_props.Position(3)./(1 + y_offset)...
    axes_props.Position(4)./(1 + x_offset)];    

% get size in pixels, to compensate for tick sizes
axes_width = new_size(3)*new_axes_position(3);
axes_height = new_size(4)*new_axes_position(4);

set(gca, 'Position', new_axes_position);

axis off 
% OR  %set(axes_props, 'XTickLabel', [],'YTickLabel', []);


x_axes_position = [new_axes_position(1) new_axes_position(2) - x_offset ...
    new_axes_position(3) 0.001];

% set limits to be min and max tick marks - good idea, not in general?
% can't do this, because then axes get rescaled - need to find a better way
% to get this effect (no extra line after tick mark!)
% X_lims = [min(axes_props.XTick) max(axes_props.XTick)];

X_tick_labels  = text_array_2_cell_array(axes_props.XTickLabel);

x_axes = axes('position',x_axes_position, 'XLim', axes_props.XLim, ... % X_lims,  
    'XTick', axes_props.XTick, 'XTickLabel', X_tick_labels, ... % axes_props.XTickLabel,
    'XScale', axes_props.XScale, 'YLim', [0 1e-10], 'YTick', []);

xlabel(x_label_props.String);

y_axes_position = [new_axes_position(1) - y_offset new_axes_position(2) ...
    0.001 new_axes_position(4)];

% set limits to be min and max tick marks - good idea, but not in general?
Y_lims = [min(axes_props.YTick) max(axes_props.YTick)];
Y_tick_labels  = text_array_2_cell_array(axes_props.YTickLabel);

y_axes = axes('position',y_axes_position, 'YLim', axes_props.YLim, ... % Y_lims,
    'YTick', axes_props.YTick, 'YTickLabel', Y_tick_labels, ...
    'YScale', axes_props.YScale, 'XLim', [0 1e-10], 'XTick', []);

ylabel(y_label_props.String);

% now set the tickmarks to a nice length
set(x_axes, 'TickLength', [0.02*tick_size(1) 0.25]);
set(y_axes, 'TickLength', [0.02*tick_size(2) 0.25]);


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
      CA{j} = TA(j,find(~isspace(TA(j,:))));
    end
end
    