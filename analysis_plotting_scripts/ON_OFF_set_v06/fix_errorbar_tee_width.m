function fix_errorbar_tee_width(width_mod)
% this function widens the tee on errorbars by the factor specified in
% width_mod, a factor of 2 doubles the width, 0.5 will halve it. 
% this does not work for subplots (yet)


% first get all children of current axes
axis_children = get(gca,'Children');
x_axis_range=get(gca,'XLim');
x_axis_range= range(x_axis_range);

for j = 1:length(axis_children)
    axis_gen2 = get(axis_children(j), 'Children');
    if (length(axis_gen2) == 2)
        %make sure you are dealing with the correct object,
        % the second child should have 9 times the data points as the first
        x = get(axis_gen2(1), 'XData');
        npt = length(x);
        if (length(get(axis_gen2(2), 'XData')) == 9*npt)
            XData = get(axis_gen2(2), 'XData');
            tee = width_mod*(x_axis_range)/100;  % make tee .02 x-distance for error bars
            %tee = width_mod*(max(x(:))-min(x(:)))/100;  % make tee .02 x-distance for error bars
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
    else
        warning('this is probably not an errorbarseries, I will skip it') ;
    end
end

