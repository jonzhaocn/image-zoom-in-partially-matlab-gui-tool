clc;
clear;
global info;

images_list = {'./12-orig.jpg'};
image = imread(images_list{1});
config = struct('edgecolor', 'r', 'rect_tag', 'rect',...
    'rect_mode', 'square', 'image', image, 'zoomed_image_size', [256, 256], ...
    'imresize_method', 'nearest', 'zoomed_image_save_dir', './');

info = struct('rect_position', [1,1,1,1], 'rect_position_start_point', [1,1], 'rect_move_start_point', [1,1]);

operation_figure_handle = figure(1);
rect_plot_handle = subplot(1,1,1);
imshow(image, []);
figure(2); 
resized_image = imresize(image, config.zoomed_image_size, config.imresize_method);
zoomed_image_handle = imshow(resized_image, []);
hold on;
handles = struct('operation_figure_handle', operation_figure_handle, 'rect_plot_handle', rect_plot_handle, 'zoomed_image_handle', zoomed_image_handle);
gui_main(handles, config, images_list);
