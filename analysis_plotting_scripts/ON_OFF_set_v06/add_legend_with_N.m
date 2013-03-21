function legend_hand = add_legend_with_N(legend_names,N,location)
    
    [legend_hand,obj_hand,~,text_content]=legend(legend_names);
    set(legend_hand,'location',location,'interpreter','none')

    for u = 1:numel(text_content)
        text = text_content{u};
        set(obj_hand(u),'String',{text,[' N = ' num2str(N(u))]})
        set(obj_hand(u),'linewidth',5)
    end
    
    legend_pos = get(legend_hand,'Position');
    new_legend_pos = [legend_pos(1) legend_pos(2)/2 legend_pos(3) legend_pos(4)*2];
    set(legend_hand,'Position',new_legend_pos,'box','off');

end