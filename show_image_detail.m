function show_image_detail(handles, config)
    global info;
    position = info.rect_position;
    image = config.image;
    image_detail = image(round(position(1)):round(position(1)+position(3)-1), ...
        round(position(2)):round(position(2)+position(4)-1), :);
    if numel(image_detail) > 0
        image_detail = imresize(image_detail, config.image_detail_size);
        set(handles.image_detail_handle ,'CData',image_detail);
    end
end