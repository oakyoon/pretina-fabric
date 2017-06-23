% image size and shape params.
im_height = 200;
im_width  = 200;
shapes = [
	shapes_oval(   20, [6,   1, 0]);
	shapes_polygon(20, [4,   3, 0]);
	shapes_polygon(20, [5.5, 5, 0]);
	shapes_oval(   20, [6,   1, 0, 2]);
	shapes_polygon(20, [4,   3, 0, 2]);
	shapes_polygon(20, [5.5, 5, 0, 2]);
	];

% arrange shapes
shapes = arrange_shapes(ones(im_height, im_width), shapes);

% color shapes w/ black
imagemat = fabricate(im_height, im_width, shapes, [0 0 0]);
subplot(2, 2, 1);
ptb.imshow_alpha(imagemat);

% color shapes w/ random gray
random_gray = @(~) repmat((rand ^ .5) * (randi(2) - 1.5) + .5, 1, 3);
imagemat = fabricate(im_height, im_width, shapes, random_gray);
subplot(2, 2, 2);
ptb.imshow_alpha(imagemat);

% color shapes w/ random hue
random_hue = @(~) hsv2rgb(cat(3, rand, .9, .9));
imagemat = fabricate(im_height, im_width, shapes, random_hue);
subplot(2, 2, 3);
ptb.imshow_alpha(imagemat);

% color shapes w/ color wheel
color_wheel = @(s) hsv2rgb(cat(3, xy2angle(s.coords(1), s.coords(2)) / 360, .9, .9));
imagemat = fabricate(im_height, im_width, shapes, color_wheel);
subplot(2, 2, 4);
ptb.imshow_alpha(imagemat);
