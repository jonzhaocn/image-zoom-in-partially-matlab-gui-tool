function move_rect(x, y)
    global rect_position;
    global rect_move_start_point;
    
    x_move = x - rect_move_start_point(1);
    y_move = y - rect_move_start_point(2);
    
    rect_move_start_point(1) = x;
    rect_move_start_point(2) = y;
    
    delete( findobj(gca, 'tag', 'rect') );
    rect_position(1) = rect_position(1) + x_move;
    rect_position(2) = rect_position(2) + y_move;
    rectangle('position', rect_position, 'edgecolor', 'r', 'tag', 'rect')
    refreshdata
end