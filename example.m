clc;
clear;
global info;
config = struct('edgecolor', 'r', 'rect_tag', 'rect', 'rect_mode', 'square');
info = struct('rect_position', [1,1,1,1], 'rect_position_start_point', [1,1], 'rect_move_start_point', [1,1]);

image_path = './12-orig.jpg';
image = imread(image_path);
figure_handle = figure(1);
imshow(image, []);
hold on;
gui_main(figure_handle, config);
