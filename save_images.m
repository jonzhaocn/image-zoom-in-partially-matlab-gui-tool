function save_images(config, images_list)
    % save zoomed image and marked image
    global info;
    position = info.rect_position;
    crop_box = [round(position(1)), round(position(2)), round(position(1)+position(3)-1), round(position(2)+position(4)-1)];
    color_value = get_color(config.edgecolor);
    for i = 1:numel(images_list)
        img_path = images_list{i};
        [~,img_name,~] = fileparts(img_path);
        
        img = imread(img_path);
        if size(img, 3) == 1
            img = repmat(img, 1, 1, 3);
        end
        
        zoomed_img = img(crop_box(1):crop_box(3), crop_box(2):crop_box(4), :);
        if numel(zoomed_img) > 0
            % ------------------------------- zoomed image
            zoomed_img = imresize(zoomed_img, config.zoomed_image_size, config.imresize_method);
            zoomed_img_path = fullfile(config.zoomed_image_save_dir, sprintf('./%s_zoomed.png', img_name));
            imwrite(zoomed_img, zoomed_img_path);
            fprintf('save image:%s\n', zoomed_img_path);
            % -------------------------------- marked image
            img(crop_box(1):crop_box(3), [crop_box(2),crop_box(4)], :) = repmat(color_value, crop_box(3)-crop_box(1)+1, 2, 1);
            img([crop_box(1),crop_box(3)], crop_box(2):crop_box(4), :) = repmat(color_value, 2, crop_box(4)-crop_box(2)+1, 1);
            marked_img_path = fullfile(config.zoomed_image_save_dir, sprintf('./%s_marked.png', img_name));
            imwrite(img, marked_img_path);
            fprintf('save image:%s\n', marked_img_path);
        else
            break;
        end
    end
end