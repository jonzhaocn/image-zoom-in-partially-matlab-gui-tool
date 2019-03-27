% reference:
% https://blog.csdn.net/renjinr/article/details/14002143
% https://blog.csdn.net/SMF0504/article/details/51883417

function mouse_track(figure_handle)
    set(gcf,'WindowButtonDownFcn',{@button_down_fun, figure_handle});
    set(gcf,'WindowButtonUpFcn',{@button_up_fun, figure_handle});
end

function button_down_fun(src, event, figure_handle)
    point = get(gca,'CurrentPoint');    %获取当前点坐标
    set(gcf,'WindowButtonMotionFcn',{@button_motion_fun, figure_handle}); %设置鼠标移动响应
    switch (get(gcbf, 'SelectionType'))
        case 'normal'
            init_rect_position(point(1,1), point(1,2));
        case 'alt'
            init_rect_move(point(1,1), point(1,2));
    end 
end

function button_up_fun(src, event, figure_handle)
    point = get(gca,'CurrentPoint');    %获取当前点坐标
    set(gcf, 'WindowButtonMotionFcn', '');    %取消鼠标移动响应
    switch (get(gcbf, 'SelectionType'))
        case 'normal'
            update_rect(point(1,1), point(1,2));
        case 'alt'
            
    end 
end

function button_motion_fun(src, event, figure_handle)
    point = get(gca,'CurrentPoint');
    switch (get(gcbf, 'SelectionType'))
        case 'normal'
            update_rect(point(1,1), point(1,2));
        case 'alt'
            move_rect(point(1,1), point(1,2));
    end 
end
