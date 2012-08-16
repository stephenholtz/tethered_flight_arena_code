function [Page1 Page2 Page3] = plot_telethon_comparison_figure(varargin)
    % iterate over summary structures made with the tfPlot.make... function
    % creates plots using tfPlot stuff
    
    % 2 pages:
    % Page 1 - B2F+F2B*, standard phi*, rev phi*, expansion*
    % Page 2 - Stripe tracking*, on off*, contrast*, optic flow*, closed loop*
    % Page 3 - velocity nulling*, rotation tuning curve*, nulling curve!!
    %     color_order_mat = [1 0 0; 0 1 1];
    %     axes_color      = [0 0 0];
    %     figure_color    = [0 0 0];
    %     font_color      = [1 1 1];
    
    color_order_mat = [1 0 0; 0 1 1];
    axes_color      = [1 1 1];
    figure_color    = [1 1 1];
    font_color      = [0 0 0];
    
    for g = 1:numel(varargin)
        temp = load(varargin{g});
        contents = fieldnames(temp);
        data{g} = getfield(temp,contents{1});
        clear temp
    end
    data{2}.metadata
    a = 1;
    if a
%% Page 1    
Page1 = figure;
set(Page1,'Name','Summary P1','NumberTitle','off','Position',[50 50 612 792],'Color',figure_color)
colormap('jet');

%% unilateralData

for i = 1:2
    
    if i == 1
        % B2F
        points  = [1 2 3];
        location    = [ .1, .85, .115, .08];
        plot_iter   = 1;
    else
        % F2B
        points  = [4 5 6];
        location    = [ .1, .75, .115, .08];
    end
    
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color);  %#ok<*LAXES>
        
        for g = 1:numel(data)
            hold('all');tfPlot.simple_timeseries(data{g}.unilateralData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once 
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})                              
            end
        end

        if cond_iter ~= 1;
        else
            if plot_iter == 1;
                ylabel({'Back2Front','LmR WBA [V]'})
            else
                ylabel({'Front2Back','LmR WBA [V]'})
            end
        end
        
        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.18,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .70
            switch plot_iter
                case 1
                    title(['30' char(176) '/s'],'Color',font_color)
                case 2
                    title(['90' char(176) '/s'],'Color',font_color)
                case 3
                    title(['360' char(176) '/s'],'Color',font_color)
            end
        end
                
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.unilateralData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:3],...
            'XTickLabel',{'30', '90', '360'})
    if location(2) > .80
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.15,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.unilateralData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XTick',[1:3],...        
          'XTickLabel',{'30', '90', '360'})   
    if location(2) > .80;
      title('T_._7_5 mean','Color',font_color);
    end
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

end

%% revPhiData

for i = 1:2
   if i == 1
        points      =  [1 2 3];
        location    = [ .1, .62, .115, .08];
        plot_iter   = 1;

   elseif  i == 2
        points = [4 5 6];
        location    = [ .1, .52, .115, .08];

   end
   
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.revPhiData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end
        
        if cond_iter ~= 1;
        else
            if i == 1;
                ylabel({'30 \lambda RP','LmR WBA [V]'})
            elseif i == 2;
                ylabel({'90 \lambda RP','LmR WBA [V]'})
            end
        end

        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.18,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .5
            switch plot_iter
                case 1
                    title(['15' char(176) '/s'],'Color',font_color)
                case 2
                    title(['90' char(176) '/s'],'Color',font_color)
                case 3
                    title(['270' char(176) '/s'],'Color',font_color)
                case 4
                    title(['540' char(176) '/s'],'Color',font_color)                     
            end
        end
                
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
   
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.revPhiData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:3],...
            'XTickLabel',{'30', '90', '360'})
    if location(2) > .60
        title('\Sigma','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.16,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.revPhiData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XTick',[1:3],...        
          'XTickLabel',{'30', '90', '360'})   
    if location(2) > .60;
      title('T_._7_5 mean','Color',font_color);
    end
    
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
    
end
clear response

%% rotGratingData

for i = 1:3
   if i == 1
        points      =  [1 2 3 4];
        location    = [ .1, .39, .115, .08];
        plot_iter   = 1;

   elseif  i == 2
        points = [5 6 7 8];
        location    = [ .1, .29, .115, .08];
        
   elseif  i == 3
        points = [9 10 11 12];
        location    = [ .1, .19, .115, .08];
        
   end
   
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.rotGratingData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end
        
        if cond_iter ~= 1;
        else
            if i == 1;
                ylabel({'30 \lambda','LmR WBA [V]'})
            elseif i == 2;
                ylabel({'60 \lambda','LmR WBA [V]'})
            else
                ylabel({'90 \lambda','LmR WBA [V]'})
            end
        end
        
        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.14,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .3
            switch plot_iter
                case 1
                    title(['15' char(176) '/s'],'Color',font_color)
                case 2
                    title(['90' char(176) '/s'],'Color',font_color)
                case 3
                    title(['270' char(176) '/s'],'Color',font_color)
                case 4
                    title(['540' char(176) '/s'],'Color',font_color)                     
            end
        end
                
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
        location = [location(1)+.02,...
                    location(2),...
                    location(3),...
                    location(4)]; 

    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.rotGratingData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XLim',[.2 4.75],...          
          'XTick',[1:4],...        
          'XTickLabel',{'15', '90', '270','540'})   
    if location(2) > .30
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.16,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.rotGratingData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XLim',[.2 4.75],...          
          'XTick',[1:4],...        
          'XTickLabel',{'15', '90', '270','540'})   
    if location(2) > .30;
      title('T_._7_5 mean','Color',font_color);
    end

    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

end
%% (Expansion) more rotGratingData
       
    points      =  [13 14];
    location    = [ .1, .06, .115, .08];
 	plot_iter   = 1;
   
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.rotGratingData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end
        if plot_iter == 1
            ylabel({'30 \lambda','LmR WBA [V]'})
        end
        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.14,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > 0
            switch plot_iter
                case 1
                    title(['15' char(176) '/s'],'Color',font_color)
                case 2
                    title(['270' char(176) '/s'],'Color',font_color)                  
            end
        end
                
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
        location = [location(1)+.02,...
                    location(2),...
                    location(3),...
                    location(4)]; 
    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.rotGratingData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XLim',[.2 2.75],...          
          'XTick',[1:2],...        
          'XTickLabel',{'15', '270'})   
    if location(2) > .01
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.16,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.rotGratingData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XLim',[.2 2.75],...          
          'XTick',[1:2],...        
          'XTickLabel',{'15', '270'})   
    if location(2) > .01;
      title('T_._7_5 mean','Color',font_color);
    end

    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
    
    
%% headings-P1
for g = 1:numel(data)
   meta_info{g} = [ '  ' data{g}.metadata.line_name ' Effector = ' data{g}.metadata.effector ' N = ' num2str(data{g}.metadata.N + 2)];
end
if g == 2
    meta_info{1} = ['SHIFTED (red)' meta_info{1}];
    meta_info{2} = ['UNSHIFTED (cyan)' meta_info{2}];
end
annotation(Page1,'Textbox','Position',[.32 .955 .6 .045],'String',meta_info,'EdgeColor','none','FontWeight','demi','LineStyle','none','Interpreter','none','Color',font_color);

% page specific
annotation(Page1,'Textbox','Position',[.02 .93 .2 .05],'String','Unilateral Motion','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color);
annotation(Page1,'Textbox','Position',[.02 .679 .2 .05],'String','Reverse Phi','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
annotation(Page1,'Textbox','Position',[.02 .45 .2 .05],'String','Rotation','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
annotation(Page1,'Textbox','Position',[.02 .12 .2 .05],'String','Expansion','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
tfPlot.reduce_gcf_fontsize

%% Page 2
Page2 = figure;
set(Page2,'Name','Summary P2','NumberTitle','off','Position',[50 50 612 792],'Color',figure_color)
colormap('jet');

%% stripeFixData 
for i = 1:3
    
    if i == 1
        % DonB
        points  = [1 2 3];
        location    = [ .1, .85, .115, .08];
        plot_iter   = 1;
    elseif i == 2
        % BonD
        points  = [4 5 6];
        location    = [ .1, .75, .115, .08];
    else 
        % Grating
        points  = [7 8 9];
        location    = [ .1, .65, .115, .08];
    end
    
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.stripeFixData.lmr_ts_mean_sem{cond},data{g}.stripeFixData.x_pos{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end

        if cond_iter ~= 1;
        else
            if i == 1;
                ylabel({'Dark on Bright','LmR WBA [V]'})
            elseif i == 2
                ylabel({'Bright on Dark','LmR WBA [V]'})
            else
                ylabel({'Square Grating','LmR WBA [V]'})
            end
        end

        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.18,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .70
            switch plot_iter
                case 1
                    title('1 Hz','Color',font_color)
                case 2
                    title('3 Hz','Color',font_color)
                case 3
                    title('5 Hz','Color',font_color)
            end
        end
        
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
    % ###### X Correlation tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.stripeFixData.corr_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:3],...
            'XTickLabel',{'1', '3', '5'})
    if location(2) > .80
        title('Correlation','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.16,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Lag tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.stripeFixData.lag_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
          'XTick',[1:3],...        
          'XTickLabel',{'1', '3', '5'})   
    if location(2) > .80;
      title('Lag','Color',font_color);
    end

end

%% contrastData

for i = 1
    
    if i == 1
        points  = [1 2 3 4];
        location    = [ .1, .53, .115, .08];
        plot_iter   = 1;
    end
    
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.contrastData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end
        
        if cond_iter ~= 1;
        else
            if i == 1;
                ylabel({['8 Hz (180' char(176) '/s'],'LmR WBA [V]'})
            end
        end

        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.13,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .5
            switch plot_iter
                case 1
                    title('mc = .23','Color',font_color)
                case 2
                    title('mc = .07','Color',font_color)
                case 3
                    title('mc = .06','Color',font_color)
                case 4
                    title('mc = .24','Color',font_color)
            end
        end
        
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
        
        % move the location of the next graph, and add to the plot iterator
     
    end
        location = [location(1)+.0185,...
                    location(2),...
                    location(3),...
                    location(4)];    
 
    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.contrastData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:4],...
            'XTickLabel',{'.23', '.07', '.06', '.24'})
        
    if location(2) > .80
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.15,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.contrastData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:4],...
            'XTickLabel',{'.23', '.07', '.06', '.24'})
        
    if location(2) > .80;
      title('T_._7_5 mean','Color',font_color);
    end

    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
    
end

%% onOffData

for i = 1:2
    
    if i == 1
        % On-Exp Off-Exp
        points  = [1 2];
        location    = [ .1, .40, .115, .08];
        plot_iter   = 1;
    elseif i == 2
        % On-Saw Off-Saw
        points  = [3 4];
        location    = [ .1, .29, .115, .08];
    end
    
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.onOffData.lmr_ts_mean_sem{cond});
            set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                              'XTickLabel',{'0', '1', '2', '3'})
        end
        
        if cond_iter ~= 1;
        else
            if i == 1;
                ylabel({'Left Expansion','LmR WBA [V]'})
            elseif i == 2
                ylabel({'Left Sawtooth','LmR WBA [V]'})
            end
        end

        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.13,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .3
            switch plot_iter
                case 1
                    title('ON','Color',font_color)
                case 2
                    title('OFF','Color',font_color)
            end
        end
        
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
        
        % move the location of the next graph, and add to the plot iterator
     
    end
        location = [location(1) + .03,...
                    location(2),...
                    location(3)-.02,...
                    location(4)];    

    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.contrastData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end
    
    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XLim',[0.5 2.5],...
            'XTickLabel',{'on', 'off'})
        
    if location(2) > .30
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.15,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

   
    % ###### Time to 75% of mean tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.contrastData.t75mean_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XLim',[0.5 2.5],...
            'XTickLabel',{'on','off'})
        
    if location(2) > .30;
      title('T_._7_5 mean','Color',font_color);
    end
    

    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
end

%% closedLoopData
% this one is a bit different
axes('Position',[.68 .3 .18 .15],'Color',axes_color); hold all;
for g = 1:numel(data)
    plot([data{g}.closedLoopData.x_pos_ts_mean_sem{:}],1:numel([data{g}.closedLoopData.x_pos_ts_mean_sem{:}]),'Color',axes_color); box off;
end

set(gca,'Box','off','Xcolor',font_color,'YColor',font_color)
title('X Pos During Stripe Fix','Color',font_color)

%% opticFlowData

% will be a bit different: Plot LMR TS, Plot integ
% Plot Lag, Plot Xcorr (each will be 3 wide)

for i = 1:3
    
    if     i == 1
        % First 2
        points      = [1 2];
        location    = [ .1, .205, .115, .06];
        plot_iter   = 1;
    elseif  i == 2
        % Second 2
        points      = [3 4];
        location    = [ .1, .135, .115, .06];
    elseif  i == 3
        % last 2
        points      = [ 5 6];
        location    = [ .1, .065, .115, .06];
    end
    
    % Raw TS
    for cond = points
        
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color); 
        
        for g = 1:numel(data)
            hold('all'); tfPlot.simple_timeseries(data{g}.opticFlowData.lmr_ts_mean_sem{cond},data{g}.opticFlowData.x_pos{cond});
            % only apply the settings to the axis once
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'YLim',[-3.2 3.2],'Box','off','XTickLabel',{''})
            end
        end
        
        switch cond(1)
            case 1
                ylabel('Lift')
            case 3
                ylabel('Pitch')
            case 5
                ylabel('Roll')
            case 2
                ylabel('SideSlip')
            case 4
                ylabel('Thrust')
            case 6
                ylabel('Yaw')
        end        
        
        if points(1) == 5 || points(1) == 6
            set(gca,'XTick',[0:3],'XTickLabel',{'0', '1', '2', '3'})
        end
        
        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.15,...
                    location(2),...
                    location(3)-.05,...
                    location(4)];
        
        plot_iter = plot_iter + 1;

    % ###### X Correlation tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = cond
            response{1}  = data{g}.opticFlowData.corr_mean_sem{j}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle = tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end
    
    set(get(tc_handle,'Parent'),'XLim',[.5 1.5],'XTickLabel',{''},'XColor',font_color,'YColor',font_color)
    
%     if points(1) == 5 || points(2) == 6
%         set(get(tc_handle,'Parent'),'XTickLabel',{''},'XTick',[.5 1.5])
%     end

    if location(2) > .15
        title('Correlation','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.08,...
                location(2),...
                location(3),...
                location(4)]; 
            
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
    
    % ###### Lag tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = cond
            response{1}  = data{g}.opticFlowData.lag_mean_sem{j}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle = tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end
    
    set(get(tc_handle,'Parent'),'XLim',[.5 1.5],'XTickLabel',{''},'XColor',font_color,'YColor',font_color)
    
    if points(1) == 5 || points(2) == 6
        set(get(tc_handle,'Parent'),'XTickLabel',{''},'XTick',[.5 1.5])
    end

    if location(2) > .150;
        title('Lag','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.08,...
                location(2),...
                location(3),...
                location(4)];     
    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = cond
            response{1}  = data{g}.opticFlowData.int_mean_sem{j}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle = tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end
    
    set(get(tc_handle,'Parent'),'XLim',[.5 1.5],'XTickLabel',{''},'XColor',font_color,'YColor',font_color)


    if location(2) > .150;
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...

    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.14,...
                location(2),...
                location(3)+.05,...
                location(4)];     
    end
end

%% headings-P1

% defined above
annotation(Page2,'Textbox','Position',[.32 .955 .6 .045],'String',meta_info,'EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Interpreter','none','Color',font_color);
% page specific
annotation(Page2,'Textbox','Position',[.02 .915 .2 .05],'String','Stripe Tracking','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color);
annotation(Page2,'Textbox','Position',[.02 .59 .2 .05],'String','Contrast','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
annotation(Page2,'Textbox','Position',[.02 .46 .2 .05],'String','ON OFF','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
annotation(Page2,'Textbox','Position',[.02 .225 .2 .05],'String','Optic Flow','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color)
tfPlot.reduce_gcf_fontsize
%% Page 3
    end
Page3 = figure;
set(Page3,'Name','Summary P3','NumberTitle','off','Position',[50 50 612 792],'Color',figure_color)
plot_iter = 1;
colormap('jet');

%% velNullData

% one for each of the temporal frequencies tested across contrasts
for c = 1:5
    switch c
        case 1
            points = [1 6 11];
            location    = [ .1, .85, .115, .08];
            
        case 2
            points = [2 7 12];            
            location    = [ .1, .75, .115, .08];
            
        case 3
            points = [3 8 13];            
            location    = [ .1, .65, .115, .08];
            
        case 4
            points = [4 9 14];            
            location    = [ .1, .55, .115, .08];
        case 5
            points = [5 10 15];            
            location    = [ .1, .45, .115, .08];            
    end
    % Raw TS
    cond_iter = 1;
    for cond = points
        gca = axes('position',location,'Colororder',color_order_mat,'color',axes_color);  %#ok<*LAXES>
        
        for g = 1:numel(data)
            hold('all');tfPlot.simple_timeseries(data{g}.velNullData.lmr_ts_mean_sem{cond});
            % only apply the settings to the axis once 
            if g == numel(data)
                set(gca,'Box','off','Xcolor',font_color,'YColor',font_color,'XLim',[0 3000],'Box','off',...
                                  'XTickLabel',{'0', '1', '2', '3'})     
            end
        end
        if cond_iter == 1;
        switch c
            case 1
                ylabel({'tf 0.30','LmR WBA [V]'})
            case 2
                ylabel({'tf 1.30','LmR WBA [V]'})
            case 3
                ylabel({'tf 5.30','LmR WBA [V]'})
            case 4
                ylabel({'tf 10.6','LmR WBA [V]'})
            case 5
                ylabel({'tf 16.0','LmR WBA [V]'})                
        end
        end
        
        % move the location of the next graph, and add to the plot iterator
        location = [location(1)+.18,...
                    location(2),...
                    location(3),...
                    location(4)]; 
        
        if location(2) > .70
            switch plot_iter
                case 1
                    title(['mc = 0.09'],'Color',font_color)
                case 2
                    title(['mc = 0.27'],'Color',font_color)
                case 3
                    title(['mc = 0.45'],'Color',font_color)
            end
        end
                
        plot_iter = plot_iter + 1;  
        cond_iter = cond_iter + 1;
    end
    
    % ###### Integration tuning curve ######
    
    % Make new axes at 'nudged' position
    axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
    hold all;
    for g = 1:numel(data)
        for j = 1:numel(points)
            response{j}  = data{g}.velNullData.int_mean_sem{points(j)}; %#ok<*AGROW>
        end
        %specify the second input type for the plot function
        tc_handle =  tfPlot.simple_tuning_curve(response,8,.1,2);
        clear response
    end

    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:3],...
            'XTickLabel',{'0.09', '0.27', '0.45'})
    if location(2) > .80
        title('\Sigma _L_m_R','Color',font_color);
    end
    
    % move the location of the next graph, and add to the plot iterator
    location = [location(1)+.15,...
                location(2),...
                location(3),...
                location(4)]; 
    % keep track of the absolute number of my plots!
    plot_iter = plot_iter + 1; 
    % next section...
end

%% rotGratingData
location    = [ .1, .15, .25, .20];

points          = [    9,    5,   1, 10,    6, 2,    7, 12,  3,   4];
tune_points_tf  = {'.17','.25','.5','1','1.5','3','4.5','6','9','18'};
axes('position',location,'Colororder',color_order_mat,'color',axes_color);        
hold all

for g = 1:numel(data)
    for j = 1:numel(points)
        response{j}  = data{g}.rotGratingData.int_mean_sem{points(j)}; %#ok<*AGROW>
    end
    tc_handle =  tfPlot.simple_tuning_curve(response,1.75,.1,2);
    clear response
end
    % Same olde
    set(get(tc_handle,'Parent'),'Xcolor',font_color,'YColor',font_color,'Box','off',...
            'XTick',[1:numel(points)],...
            'XTickLabel',tune_points_tf,'XLim',[0 numel(points)+g/5])
    title('\Sigma _L_m_R','Color',font_color);
    ylabel('\Sigma LmR WBA [V]','Color',font_color);
    xlabel('Temporal Frequency [Hz]','Color',font_color);
    
annotation(Page3,'Textbox','Position',[.32 .955 .6 .045],'String',meta_info,'EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Interpreter','none','Color',font_color);
% page specific
annotation(Page3,'Textbox','Position',[.02 .915 .2 .25],'String','Velocity Nulling: Reference Contrast = .27, tf = 4','EdgeColor',[1 1 1],'FontWeight','demi','LineStyle','none','Color',font_color);
tfPlot.reduce_gcf_fontsize


end