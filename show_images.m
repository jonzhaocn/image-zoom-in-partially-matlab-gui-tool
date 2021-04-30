function show_images(res_handle, config)
    % show images in the second figure
    global info;
    col = info.rect_position(1);
    row = info.rect_position(2);
    num_col = info.rect_position(3);
    num_row = info.rect_position(4);
    
    for i = 1:size(config.images, 4)
        curr_img = config.images(round(row):round(row+num_row-1), ...
        round(col):round(col+num_col-1), :, i);
    
        if numel(curr_img) > 0
            res_handle{i}.img.CData = curr_img;
            res_handle{i}.plot.XLim = [0.5, 0.5+size(curr_img, 2)];
            res_handle{i}.plot.YLim = [0.5, 0.5+size(curr_img, 1)];
        else
            break;
        end
    end
end