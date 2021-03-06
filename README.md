# image-zoom-in-partially-matlab-gui-tool
* `zoom in image partially in matlab GUI`
* `support zooming several images in the same area, it's convenient to compare different pictures in the same area for writing papers or reports`
* `for several images, you can select zoom in area in the first image only`
## Introduction
### Usage
* `use left mouse button to control the zoomed area`
* `use right mouse button (or ctrl + left mouse button)to move the zoomed area`
* `press 's' to save marked image and zoomed image`
### Config
* `edgecolor: the edge color of marked area`
* `rect_tag: mask the rectangle and find the rectangle object while update figure`
* `rect_mode: square or rectangle`
* `image: the image array`
* `zoomed_image_size`
* `imresize_method: like nearest`
* `zoomed_image_save_dir`

## Example
* `example images(original image) is downloaded from http://mridata.org/, it's in Stanford Fullysampled 3D FSE Knees project`

<p align="center">
	<img src="/data/orig_marked.png" height="256px" width="256px">
	<img src="/data/pred_marked.png" height="256px" width="256px">
</p>

<p align="center">
	<img src="/data/orig_zoomed.png" height="256px" width="256px">
	<img src="/data/pred_zoomed.png" height="256px" width="256px">
</p>

