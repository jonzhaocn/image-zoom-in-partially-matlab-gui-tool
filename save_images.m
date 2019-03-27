function save_images(config, images_list)
    global info;
    position = info.rect_position;
    crop_box = [round(position(1)), round(position(2)), round(position(1)+position(3)-1), round(position(2)+position(4)-1)];
    for i = 1:numel(images_list)
        img_path = images_list{i};
        [~,img_name,~] = fileparts(img_path);
        img = imread(img_path);
        zoomed_img = img(crop_box(1):crop_box(3), crop_box(2):crop_box(4));
        if numel(zoomed_img) > 0
            zoomed_img = imresize(zoomed_img, config.zoomed_image_size, config.imresize_method);
            zoomed_img_path = fullfile(config.zoomed_image_save_dir, sprintf('./%s_zoomed.png', img_name));
            imwrite(zoomed_img, zoomed_img_path);
            fprintf('save image:%s\n', zoomed_img_path);
        end
    end
end