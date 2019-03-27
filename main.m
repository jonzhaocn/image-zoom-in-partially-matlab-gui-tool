% zoom in image partially in matlab GUI
% support zooming several images in the same area, it's convenient to compare different pictures in the same area for writing papers or reports
% for several images, you can select zoom in area in the first image only
% 
% features:
% use left mouse button to control the zoomed area
% use right mouse button (or ctrl + left mouse button)to move the zoomed area
% press 's' to save marked image and zoomed image
%
% config:
% edgecolor: the edge color of marked area
% rect_tag: mask the rectangle and find the rectangle object while update figure
% rect_mode: square or rectangle
% image: the image array
% zoomed_image_size
% imresize_method: like nearest
% zoomed_image_save_dir
clc;
clear;
images_list = {'./data/orig.jpg'};
images = cell(numel(images_list), 1);

for i = 1:numel(images_list)
    img = imread(images_list{i});
    if size(img, 3) == 1
        img = repmat(img, 1, 1, 3);
    end
    images{i} = img;
end
images = cat(4, images{:});

config = struct('edgecolor', 'r', 'rect_tag', 'rect',...
    'rect_mode', 'square', 'images', images, 'zoomed_image_size', [256, 256], ...
    'imresize_method', 'nearest', 'zoomed_image_save_dir', './data');

gui_figure(config, images_list);
