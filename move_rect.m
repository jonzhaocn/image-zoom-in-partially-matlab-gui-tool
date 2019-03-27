function move_rect(x, y, handles, config)
    % move zoom in area according mouse position
    global info;
    x_move = x - info.rect_move_start_point(1);
    y_move = y - info.rect_move_start_point(2);
    
    info.rect_move_start_point(1) = x;
    info.rect_move_start_point(2) = y;
    
    delete( findobj(gca, 'tag', config.rect_tag) );
    info.rect_position(1) = info.rect_position(1) + x_move;
    info.rect_position(2) = info.rect_position(2) + y_move;
    rectangle(handles.rect_plot_handle, 'position', info.rect_position, 'edgecolor', config.edgecolor, 'tag', config.rect_tag);
    refreshdata(handles.operation_figure_handle);
    show_zoomed_image(handles, config);
end