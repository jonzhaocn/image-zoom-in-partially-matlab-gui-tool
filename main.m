% zoom in image partially in matlab GUI
% support zooming several images in the same area, it's convenient to compare different pictures in the same area for writing papers or reports
% for several images, you can select zoom in area in the first image only
% 
% features:
% use left mouse button to control the zoomed area
% use right mouse button (or ctrl + left mouse button)to move the zoomed area
% press 's' to save marked image and zoomed image
% 
% 使用鼠标左键确定裁剪框位置，点击鼠标左键，按住并拖动，即可绘制矩形
% 使用鼠标右键点击矩形，按住并拖动，可以移动矩形位置
% 按下`s`键保存结果
%
% config:
% edgecolor: 裁剪框的颜色，定义在get_color中
% rect_tag: 裁剪框的tag，在更新矩形位置，形状时需要使用，需要根据tag找到原有的矩形，并删除
% rect_mode: square 裁剪框为正方形；rectangle 裁剪框为矩形；keep 长宽比与原图一致
% images: 用于保存图像的数组
% res_dir：结果文件夹

clc;
clear;
images_list = {'./data/orig.jpg', './data/pred.jpg'};
images = cell(numel(images_list), 1);

for i = 1:numel(images_list)
    img = imread(images_list{i});
    if size(img, 3) == 1
        img = repmat(img, 1, 1, 3);
    end
    images{i} = img;
end
images = cat(4, images{:});

config = struct('edgecolor', 'r', 'rect_mode', 'keep', 'line_width', 2, ...
    'images', images, 'res_dir', './data', 'rect_tag', 'rect');

gui_figure(config, images_list);
