function show_zoomed_image(handles, config)
    % show zoomed image in the second figure
    global info;
    col = info.rect_position(1);
    row = info.rect_position(2);
    num_col = info.rect_position(3);
    num_row = info.rect_position(4);
    
    image = config.image;
    zoomed_image = image(round(row):round(row+num_row-1), ...
        round(col):round(col+num_col-1), :);
    if numel(zoomed_image) > 0
        zoomed_image = imresize(zoomed_image, config.zoomed_image_size, config.imresize_method);
        set(handles.zoomed_image_handle ,'CData',zoomed_image);
    end
end