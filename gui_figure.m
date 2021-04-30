% reference:
% https://blog.csdn.net/renjinr/article/details/14002143
% https://blog.csdn.net/SMF0504/article/details/51883417

function gui_figure(config, img_list)
    global info;
    info = struct('rect_position', [1,1,1,1], 'rect_position_start_point', [1,1], 'rect_move_start_point', [1,1]);
    num_images = size(config.images, 4);
    
    % 在figure 1中展示第一幅图像，在figure 1上绘制矩形，该矩形会同时作用于其他图像
    mainfig_h = figure(1);
    mainplot_h = subplot(1,1,1);
    imshow(config.images(:,:,:,1), []);
    
    % 在figure 2中展示所有图像
    figure(2);
    subfig_row = floor(sqrt(num_images));
    subfig_col = ceil(num_images/subfig_row);
    
    res_handle = cell(num_images, 1);
    
    for i = 1:num_images
        subplot_h = subplot(subfig_row, subfig_col, i);
        
        [~, image_name, ~] = fileparts(img_list{i});
        image_name = replace(image_name, '_', '-');
        
        imshow_h = imshow(config.images(:, :, :, i), []);
        title(image_name);
        
        res_handle{i}.img = imshow_h;
        res_handle{i}.plot = subplot_h;
    end
    
    hold on;
    % 将mainfig_handle与rectplot_handle保存在结构体handle_struct中
    main_handle = struct('fig', mainfig_h, 'plot', mainplot_h);
    % 为mainfig_handle绑定鼠标点击、鼠标松开事件
    set(mainfig_h,'WindowButtonDownFcn',{@button_down_fun, main_handle, res_handle, config});
    set(mainfig_h,'WindowButtonUpFcn',{@button_up_fun, main_handle, res_handle, config});
    
    % 监听键盘，是否点击了`s`键，如果点击了s键，则保存当前结果
    while 1
        pause(0.5)
        input_char = get(gcf, 'CurrentCharacter');
        set(gcf, 'CurrentCharacter', ' ');
        if strcmp(input_char, 's')
            save_images(config, img_list);
            break;
        elseif strcmp(input_char, 'q')
            return
        end
    end
end

function button_down_fun(src, event, main_handle, res_handle, config)
% 鼠标按下事件

    % 获取鼠标点击的位置
    point = get(gca, 'CurrentPoint');
    col = point(1, 1);
    row = point(1, 2);
    if col < 1 || col > size(config.images, 2)
        return
    end
    if row < 1 || row > size(config.images, 1)
        return
    end
    
    % 绑定鼠标移动事件
    set(main_handle.fig,'WindowButtonMotionFcn',{@button_motion_fun, main_handle, res_handle, config});
    
    % 如果点击的是左键，则初始化矩形的位置，如果点击的是右键，为矩形移动作初始化
    switch (get(gcbf, 'SelectionType'))
        % left mouse button
        case 'normal'
            init_rect_position(row, col);
        % right mouse button or ctrl + left mouse button
        case 'alt'
            init_rect_move(row, col);
    end 
end

function button_up_fun(src, event, main_handle, res_handle, config)
% 鼠标松开事件

    % 获取鼠标最终的位置
    point = get(gca,'CurrentPoint');
    col = point(1, 1);
    row = point(1, 2);
    if col < 1 || col > size(config.images, 2)
        return
    end
    if row < 1 || row > size(config.images, 1)
        return
    end
    
    set(main_handle.fig, 'WindowButtonMotionFcn', '');
    % 如果点击的是左键，则可以根据鼠标点击位置与松开位置绘制矩形
    switch (get(gcbf, 'SelectionType'))
        % left mouse button
        case 'normal'
            update_rect(row, col, main_handle, config);
            show_images(res_handle, config);
    end 
end

function button_motion_fun(src, event, main_handle, res_handle, config)
% 鼠标移动事件
    point = get(gca,'CurrentPoint');
    col = point(1, 1);
    row = point(1, 2);
    if col < 1 || col > size(config.images, 2)
        return
    end
    if row < 1 || row > size(config.images, 1)
        return
    end
    
    switch (get(gcbf, 'SelectionType'))
        % 如果移动的是左键，则根据鼠标位置更新矩形
        case 'normal'
            update_rect(row, col, main_handle, config);
            show_images(res_handle, config);
        % right mouse button or ctrl + left mouse button
        % 如果是右键，则移动矩形位置
        case 'alt'
            move_rect(row, col, main_handle, config);
            show_images(res_handle, config);
    end 
end
