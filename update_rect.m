function update_rect(x, y)
    global rect_position; 
    if x < rect_position(1)
        start_x = x;
        width = rect_position(1) - x;
    else
        start_x = rect_position(1);
        width = x - rect_position(1);
    end
    
    if y < rect_position(2)
        start_y = y;
        height = rect_position(2) - y;
    else
        start_y = rect_position(2);
        height = y - rect_position(2);
    end
    rect_position = [start_x, start_y, width, height];
    delete( findobj(gca, 'tag', 'rect') );
    rectangle('position', rect_position, 'edgecolor', 'r', 'tag', 'rect')
    refreshdata
end