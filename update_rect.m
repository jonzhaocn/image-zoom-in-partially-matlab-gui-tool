function update_rect(row, col, handles, config)
    % update zoom in area size
    global info; 
    if row < info.rect_position_start_point(1)
        start_row = row;
        num_row = info.rect_position_start_point(1) - row;
    else
        start_row = info.rect_position_start_point(1);
        num_row = row - info.rect_position_start_point(1);
    end
    
    if col < info.rect_position_start_point(2)
        start_col = col;
        num_col = info.rect_position_start_point(2) - col;
    else
        start_col = info.rect_position_start_point(2);
        num_col = col - info.rect_position_start_point(2);
    end
    
    if strcmp(config.rect_mode, 'square')
        min_val = min([num_row, num_col]);
        num_row = min_val;
        num_col = min_val;
    elseif strcmp(config.rect_mode, 'rectangular')
        
    else
        error('rect_mode shoule be square or rectangular')
    end
    info.rect_position = [start_col, start_row, num_col, num_row];
    delete(findobj(gca, 'tag', config.rect_tag));
    rectangle(handles.rect_plot_handle, 'position', info.rect_position, 'edgecolor', config.edgecolor, 'tag', config.rect_tag);
    refreshdata(handles.operation_figure_handle);
end