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
            croped_img_path = fullfile(config.res_dir, sprintf('./%s_croped.jpg', img_name));
            imwrite(croped_img, croped_img_path);
            fprintf('save image:%s\n', croped_img_path);
            % -------------------------------- marked image
            hwidth = floor(config.line_width/2);
            if mod(config.line_width, 2)==1
                img(row_s:row_e, [col_s-hwidth:col_s+hwidth, col_e-hwidth:col_e+hwidth], :) = repmat(color_value, row_e-row_s+1, config.line_width*2, 1);
                img([row_s-hwidth:row_s+hwidth, row_e-hwidth:row_e+hwidth], col_s:col_e, :) = repmat(color_value, config.line_width*2, col_e-col_s+1, 1); 
            else
                img(row_s:row_e, [col_s-hwidth+1:col_s+hwidth, col_e-hwidth:col_e+hwidth-1], :) = repmat(color_value, row_e-row_s+1, config.line_width*2, 1);
                img([row_s-hwidth+1:row_s+hwidth, row_e-hwidth:row_e+hwidth-1], col_s:col_e, :) = repmat(color_value, config.line_width*2, col_e-col_s+1, 1);
            end
            marked_img_path = fullfile(config.res_dir, sprintf('./%s_marked.jpg', img_name));
            imwrite(img, marked_img_path);
            fprintf('save image:%s\n', marked_img_path);
        else
            break;
        end
    end
end