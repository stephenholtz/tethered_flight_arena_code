
figure_children = get(gcf,'Children');
for g = 1:numel(figure_children)
    % Change font size on all the axes (Tick labels etc.,)
    set(figure_children(g),'FontSize',7.5)
    % set(figure_children(g),'YColor',[1 1 1],'XColor',[0 0 0],'YColor',[0 0 0])
    % Change the font size of all the axis titles
    set(get(figure_children(g),'YLabel'), 'FontSize',8);
    set(get(figure_children(g),'XLabel'), 'FontSize',8);
    set(get(figure_children(g),'Title' ), 'FontSize',8);
    
    % Change the font size of the annotations... somehow
%     ax_children = get(figure_children(g),'Children');
%     for j = 1:numel(ax_children)
%         try
%         temp = get(ax_children(j),'Children');
%         for p = 1:numel(temp)
%             a=get(temp(p));
%             if ~strcmpi(a.type,'line')
%                 a
%             end
%         end
%         catch CHILLENERR
%             'NO CHILLENZ';
%         end
%     end
end