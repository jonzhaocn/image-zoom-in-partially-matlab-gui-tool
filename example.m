clc;
clear;
global info;
image_path = './12-orig.jpg';


image = imread(image_path);
config = struct('edgecolor', 'r', 'rect_tag', 'rect', 'rect_mode', 'square', 'image', image, 'zoomed_image_size', [256, 256], 'imresize_method', 'nearest');
info = struct('rect_position', [1,1,1,1], 'rect_position_start_point', [1,1], 'rect_move_start_point', [1,1]);

operation_figure_handle = figure(1);
rect_plot_handle = subplot(1,1,1);
imshow(image, []);
figure(2); 
zoomed_image_handle = imshow(imresize(image, config.zoomed_image_size), []);
hold on;
handles = struct('operation_figure_handle', operation_figure_handle, 'rect_plot_handle', rect_plot_handle, 'zoomed_image_handle', zoomed_image_handle);
gui_main(handles, config);
