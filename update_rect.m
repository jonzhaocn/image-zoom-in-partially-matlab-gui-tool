function update_rect(row, col, handle_struct, config)
    % update zoom in area size
    global info; 
    % 由于鼠标的点击位置是不固定的，所以根据鼠标点击位置与松开位置的坐标大小，确定矩形的起点
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
    
    % 如果设置要求裁剪形状是正方形
    if strcmp(config.rect_mode, 'square')
        min_val = min([num_row, num_col]);
        num_row = min_val;
        num_col = min_val;
    elseif strcmp(config.rect_mode, 'keep')
        img_row = size(config.images, 1);
        img_col = size(config.images, 2);
        if num_row <= num_col
            num_col = num_row * img_col/img_row;
        else
            num_row = num_col * img_row/img_col;
        end
        
    elseif strcmp(config.rect_mode, 'rectangular')
        
    else
        error('rect_mode shoule be square or rectangular')
    end
    
    info.rect_position = [start_col, start_row, num_col, num_row];
    % 删除原先绘制的矩形
    delete(findobj(gca, 'tag', config.rect_tag));
    % 绘制新的矩形
    rectangle(handle_struct.rectplot_handle, 'position', info.rect_position, 'edgecolor', config.edgecolor, 'tag', config.rect_tag);
    refreshdata(handle_struct.mainfig_handle);
end