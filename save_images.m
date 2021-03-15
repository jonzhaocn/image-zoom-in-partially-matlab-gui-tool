function save_images(config, images_list)
% save croped image and marked image

    global info;
    col = info.rect_position(1);
    row = info.rect_position(2);
    num_col = info.rect_position(3);
    num_row = info.rect_position(4);
    
    row_s = round(row);
    row_e = round(row+num_row-1);
    col_s = round(col);
    col_e = round(col+num_col-1);
    
    color_value = get_color(config.edgecolor);
    for i = 1:numel(images_list)
        img_path = images_list{i};
        [~,img_name,~] = fileparts(img_path);
        
        img = imread(img_path);
        if size(img, 3) == 1
            img = repmat(img, 1, 1, 3);
        end
        
        croped_img = img(row_s:row_e, col_s:col_e, :);
        if numel(croped_img) > 0
            % ------------------------------- zoomed image
            croped_img_path = fullfile(config.res_dir, sprintf('./%s_croped.png', img_name));
            imwrite(croped_img, croped_img_path);
            fprintf('save image:%s\n', croped_img_path);
            % -------------------------------- marked image
            img(row_s:row_e, [col_s, col_e], :) = repmat(color_value, row_e-row_s+1, 2, 1);
            img([row_s,row_e], col_s:col_e, :) = repmat(color_value, 2, col_e-col_s+1, 1);
            marked_img_path = fullfile(config.res_dir, sprintf('./%s_marked.png', img_name));
            imwrite(img, marked_img_path);
            fprintf('save image:%s\n', marked_img_path);
        else
            break;
        end
    end
end