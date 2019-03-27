function update_rect(x, y, figure_handle, config)
    global info; 
    if x < info.rect_position_start_point(1)
        start_x = x;
        width = info.rect_position_start_point(1) - x;
    else
        start_x = info.rect_position_start_point(1);
        width = x - info.rect_position_start_point(1);
    end
    
    if y < info.rect_position_start_point(2)
        start_y = y;
        height = info.rect_position_start_point(2) - y;
    else
        start_y = info.rect_position_start_point(2);
        height = y - info.rect_position_start_point(2);
    end
    
    if config.rect_mode == 'square'
        min_val = min([width, height]);
        width = min_val;
        height = min_val;
    elseif config.rect_mode == 'rectangular'
        
    else
        error('rect_mode shoule be square or rectangular')
    end
    
    info.rect_position = [start_x, start_y, width, height];
    delete(findobj(gca, 'tag', config.rect_tag));
    rectangle('position', info.rect_position, 'edgecolor', config.edgecolor, 'tag', config.rect_tag)
    refreshdata(figure_handle)
end