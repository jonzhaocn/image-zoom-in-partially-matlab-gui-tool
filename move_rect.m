function move_rect(row, col, handles, config)
% 移动矩形

    global info;
    row_move = row - info.rect_move_start_point(1);
    col_move = col - info.rect_move_start_point(2);
    
    if info.rect_position(1) + col_move < 1
        col_move = 1 - info.rect_position(1);
        col = col_move + info.rect_move_start_point(2);
    end
    if info.rect_position(1) + col_move + info.rect_position(3) > size(config.images, 2)
        col_move = size(config.images, 2) - info.rect_position(1) - info.rect_position(3);
        col = col_move + info.rect_move_start_point(2);
    end
    
    if info.rect_position(2) + row_move < 1
        row_move = 1 - info.rect_position(2);
        row = row_move + info.rect_move_start_point(1);
    end
    if info.rect_position(2) + row_move + info.rect_position(4) > size(config.images, 1)
        row_move = size(config.images, 1) - info.rect_position(2) - info.rect_position(4);
        row = row_move + info.rect_move_start_point(1);
    end
    
    info.rect_move_start_point(1) = row;
    info.rect_move_start_point(2) = col;
    delete(findobj(gca, 'tag', config.rect_tag));
    
    info.rect_position(1) = info.rect_position(1) + col_move;
    info.rect_position(2) = info.rect_position(2) + row_move;
    rectangle(handles.rectplot_handle, 'position', info.rect_position, 'edgecolor', ...
        config.edgecolor, 'tag', config.rect_tag, 'linewidth', config.line_width);
    refreshdata(handles.mainfig_handle);
end