function tune_handle = simple_tuning_curve(data_cell,varargin)
% tune_handle = simple_tuning_curve(data_cell,width_mod,[x_offset_factor])
    % data_cell:    data_cell{1} should be the means
    %               data_cell{2} should be SEM
    % data_cell:    data_cell{3:end} should be the above repeated...
    
    % plot_options will probs change... see code
    
    % give the option to also pass cell array pairs of mean,sem
%     if varargin{numel(varargin)} == 2
%         average_values = [];
%         sem_value = [];
%         for i = 1:numel(data_cell)
%             average_values(i) = data_cell{i}{1};
%             sem_value(i) = data_cell{i}{2};
%         end
%     else
        average_values  = data_cell{1};
        sem_value       = data_cell{2}; 
        
        if size(data_cell,2) == 3
            x_positions = data_cell{3};
        else
            x_positions = [];
        end        
%     end
    
    % Should check for previously plotted lines, and iterate the x_offset
    % Give option for the offset factor as varargin{1}
    if nargin == 2
        x_offset_factor    = varargin{1};
    else
        x_offset_factor    = .1;
    end
    
    % if the hold on or hold all is selected, we obviously want to plot
    % more than one curve, so have an offset, otherwise, don't mess up the
    % x positions!
    if ishold
        try
            prev_err_handles = get(gca,'Children');
            num_prev_plots = numel(prev_err_handles);
        catch %#ok<CTCH>
            num_prev_plots = 0;
        end
    else
        num_prev_plots = 0;
    end
    
    x_offset = x_offset_factor*num_prev_plots;
    
    if isempty(x_positions)
        x_positions = x_offset + (1:numel(average_values));
    else
        x_positions = x_offset + x_positions;
    end
    
    tune_handle = errorbar(x_positions,average_values,sem_value,...
                                'Marker','o',...
                                'MarkerFaceColor','none',...
                                'MarkerSize',4,...
                                'LineWidth',1);
%                                     'MarkerEdgeColor',color_matrix,...
%                                     'Color',color_matrix);

% 
    % Plot a line at zero (with Tag = 'zero_line')
    % Deterimine the correct color (opp of background white or black)
    if sum(get(gca,'Color')) == 0
        zero_color = [1 1 1];
    else
        zero_color = [0 0 0];
    end
    
    y_vals = get(gca,'YLim');
    x_vals = get(gca,'XLim');
    x_len_vec = x_vals(1):diff(x_vals)/10:x_vals(2);
    if y_vals(1)*y_vals(2) < 1
        hold('all')
        plot(x_len_vec,zeros(1,numel(x_len_vec)),'LineStyle','--','Color',zero_color);
        set(max(get(gca,'Children')),'Tag','zero_line')
    end

%fix_ebar_tee_width(4);

% function fix_ebar_tee_width(width_mod)
% % this function widens the tee on errorbars by the factor specified in
% % width_mod, a factor of 2 doubles the width, 0.5 will halve it. 
% % this does not work for subplots (yet)
% 
% 
% % first get all children of current axes
% axis_children = get(gca,'Children');
% 
% for j = 1:length(axis_children)
%     axis_gen2 = get(axis_children(j), 'Children');
%     if (length(axis_gen2) == 2)
%         %make sure you are dealing with the correct object,
%         % the second child should have 9 times the data points as the first
%         x = get(axis_gen2(1), 'XData');
%         npt = length(x);
%         if (length(get(axis_gen2(2), 'XData')) == 9*npt)
%             XData = get(axis_gen2(2), 'XData');
%             tee = width_mod*(max(x(:))-min(x(:)))/100;  % make tee .02 x-distance for error bars
%             xl = x - tee;
%             xr = x + tee;
%             % build up nan-separated vector for bars
%             xb = zeros(npt*9,1);
%             xb(1:9:end,:) = x;
%             xb(2:9:end,:) = x;
%             xb(3:9:end,:) = NaN;
%             xb(4:9:end,:) = xl;
%             xb(5:9:end,:) = xr;
%             xb(6:9:end,:) = NaN;
%             xb(7:9:end,:) = xl;
%             xb(8:9:end,:) = xr;
%             xb(9:9:end,:) = NaN;     
%             set(axis_gen2(2), 'XData', xb);
%         else
%             warning('something odd here, skip this series');    
%         end
%     end
% end
%     
% end   
end