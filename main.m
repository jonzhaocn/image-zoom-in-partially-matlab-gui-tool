% zoom in image partially in matlab GUI
% support zooming serveral images in the same area, it's convenient to
% compare different pictures in the same area for writing papers or reports
% 
% 
% features:
% use left mouse button to control the zoomed area
% use right mouse button (or ctrl + left mouse button)to move the zoomed area
% press 's' to save marked image and zoomed image
%
% config:
% edgecolor: the color of rectangle in the masked area
% rect_tag: mask the rectangle and find the rectangle object while update figure
% rect_mode: square or rectangle
% image: the image array
% zoomed_image_size
% imresize_method: like nearest
% zoomed_image_save_dir
clc;
clear;
images_list = {'./data/orig.jpg', './data/pred.jpg'};

image = imread(images_list{1});
if size(image, 3) == 1
    image = repmat(image, 1, 1, 3);
end

config = struct('edgecolor', 'r', 'rect_tag', 'rect',...
    'rect_mode', 'square', 'image', image, 'zoomed_image_size', [256, 256], ...
    'imresize_method', 'nearest', 'zoomed_image_save_dir', './data');

gui_figure(config, images_list);
