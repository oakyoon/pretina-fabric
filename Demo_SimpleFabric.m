% image size and shape params.
im_height = 200;
im_width  = 200;
shapes = [
	shapes_oval(   16, [6,   1, 0]);     % number of circles,  [radius, width-height ratio,    tilt]
	shapes_polygon(16, [4,   3, 0]);     % number of polygons, [inner-radius, number of sides, tilt]
	shapes_polygon(16, [5.5, 5, 0]);     % number of polygons, [inner-radius, number of sides, tilt]
	shapes_oval(   16, [6,   1, 0, 2]);  % number of circles,  [radius, width-height ratio,    tilt, outline thickness]
	shapes_polygon(16, [4,   3, 0, 2]);  % number of polygons, [inner-radius, number of sides, tilt, outline thickness]
	shapes_polygon(16, [5.5, 5, 0, 2]);  % number of polygons, [inner-radius, number of sides, tilt, outline thickness]
	];

% place shapes inside image mask (mask size must be im_width by im_height)
image_mask = imread('images/circular-mask_200px.png');
image_mask = double(image_mask) / 255;
if size(image_mask, 3) > 1
	image_mask = rgb2gray(image_mask);
end
shapes = arrange_shapes(image_mask, shapes);

% following one-liner will do the same job as 6 lines above
%shapes = arrange_shapes('demo-images/simple-fabric-mask.png', shapes);

% or, you can place shapes anywhere in a im_width-by-im_height canvas
%shapes = arrange_shapes(ones(im_height, im_width), shapes);


% open new figure
h = figure;

% draw shapes to 4-channel (RGB + alpha) image
% shapes colored with black [0 0 0]
imagemat = fabricate(im_height, im_width, shapes, [0 0 0]);
subplot(2, 2, 1);
ptb.imshow_alpha(imagemat);  % imshow() function wrapper for 4-channel image 

% shapes colored with random gray
random_gray = @(~) repmat(rand, 1, 3);
imagemat = fabricate(im_height, im_width, shapes, random_gray);
subplot(2, 2, 2);
ptb.imshow_alpha(imagemat);

% shapes colored with random hues
random_hue = @(~) hsv2rgb(cat(3, rand, .9, .9));
imagemat = fabricate(im_height, im_width, shapes, random_hue);
subplot(2, 2, 3);
ptb.imshow_alpha(imagemat);

% shapes colored with their hues determined by their positions
color_wheel = @(s) hsv2rgb(cat(3, xy2angle(s.coords(1), s.coords(2)) / 360, .9, .9));
imagemat = fabricate(im_height, im_width, shapes, color_wheel);
subplot(2, 2, 4);
ptb.imshow_alpha(imagemat);

% set figure size to true image size
truesize(h, [im_height, im_width]);
