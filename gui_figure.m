% reference:
% https://blog.csdn.net/renjinr/article/details/14002143
% https://blog.csdn.net/SMF0504/article/details/51883417

function gui_figure(config, images_list)
    global info;
    info = struct('rect_position', [1,1,1,1], 'rect_position_start_point', [1,1], 'rect_move_start_point', [1,1]);
    num_images = size(config.images, 4);
    
    % operation figure
    operation_figure_handle = figure(1);
    rect_plot_handle = subplot(1,1,1);
    imshow(config.images(:,:,:,1), []);
    
    % zoom in figure
    figure(2);
    zoomed_image_handles = cell(num_images, 1);
    for i = 1:num_images
        subplot(1, num_images, i);
        [~, image_name, ~] = fileparts(images_list{i});
        resized_image = imresize(config.images(:, :, :, i), config.zoomed_image_size, config.imresize_method);
        zi_handle = imshow(resized_image, []);
        title(image_name);
        zoomed_image_handles{i} = zi_handle;
    end
    
    hold on;
    % set button function
    handles = struct('operation_figure_handle', operation_figure_handle, 'rect_plot_handle', rect_plot_handle);
    set(handles.operation_figure_handle,'WindowButtonDownFcn',{@button_down_fun, handles, zoomed_image_handles, config});
    set(handles.operation_figure_handle,'WindowButtonUpFcn',{@button_up_fun, handles, zoomed_image_handles, config});
    
    % get keyboard input, press s to save image
    while 1
        pause(0.5)
        input_char = get(gcf, 'CurrentCharacter');
        set(gcf, 'CurrentCharacter', ' ');
        if strcmp(input_char, 's')
            save_images(config, images_list);
            break;
        end
    end
end

function button_down_fun(src, event, handles, zoomed_image_handles, config)
    point = get(gca, 'CurrentPoint');
    col = point(1, 1);
    row = point(1, 2);
    if col < 1 || col > size(config.images, 2)
        return
    end
    if row < 1 || row > size(config.images, 1)
        return
    end
    
    set(handles.operation_figure_handle,'WindowButtonMotionFcn',{@button_motion_fun, handles, zoomed_image_handles, config});
    switch (get(gcbf, 'SelectionType'))
        % left mouse button
        case 'normal'
            init_rect_position(row, col);
        % right mouse button or ctrl + left mouse button
        case 'alt'
            init_rect_move(row, col);
    end 
end

function button_up_fun(src, event, handles, zoomed_image_handles, config)
    point = get(gca,'CurrentPoint');
    col = point(1, 1);
    row = point(1, 2);
    if col < 1 || col > size(config.images, 2)
        return
    end
    if row < 1 || row > size(config.images, 1)
        return
    end
    
    set(handles.operation_figure_handle, 'WindowButtonMotionFcn', '');
    switch (get(gcbf, 'SelectionType'))
        % left mouse button
        case 'normal'
            update_rect(row, col, handles, config);
            show_zoomed_image(zoomed_image_handles, config);
    end 
end

function button_motion_fun(src, event, handles, zoomed_image_handles, config)
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
        % left mouse button
        case 'normal'
            update_rect(row, col, handles, config);
            show_zoomed_image(zoomed_image_handles, config);
        % right mouse button or ctrl + left mouse button
        case 'alt'
            move_rect(row, col, handles, config);
            show_zoomed_image(zoomed_image_handles, config);
    end 
end
