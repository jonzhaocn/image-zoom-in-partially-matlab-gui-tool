function show_zoomed_image(zoomed_image_handles, config)
    % show zoomed image in the second figure
    global info;
    col = info.rect_position(1);
    row = info.rect_position(2);
    num_col = info.rect_position(3);
    num_row = info.rect_position(4);
    
    for i = 1:size(config.images, 4)
        zoomed_image = config.images(round(row):round(row+num_row-1), ...
        round(col):round(col+num_col-1), :, i);
    
        if numel(zoomed_image) > 0
            zoomed_image = imresize(zoomed_image, config.zoomed_image_size, config.imresize_method);
            set(zoomed_image_handles{i} ,'CData', zoomed_image);
        else
            break;
        end
    end
end