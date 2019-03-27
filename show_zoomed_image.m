function show_zoomed_image(handles, config)
    global info;
    position = info.rect_position;
    image = config.image;
    zoomed_image = image(round(position(1)):round(position(1)+position(3)-1), ...
        round(position(2)):round(position(2)+position(4)-1), :);
    if numel(zoomed_image) > 0
        zoomed_image = imresize(zoomed_image, config.zoomed_image_size, config.imresize_method);
        set(handles.zoomed_image_handle ,'CData',zoomed_image);
    end
end