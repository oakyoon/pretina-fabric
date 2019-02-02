% load seed image
seed_imagemat = imread('images/seed-images/image01.png');
[im_height, im_width, ~] = size(seed_imagemat);
% prepare color palette
palette = image2palette(seed_imagemat);

% dot params.
r_dots = [1.5, 2.0, 2.5];  % radii of dots
n_dots = [];               % generate_pointset() determines the number of dots
%n_dots = 800;             % you can specify the total number of dots
%n_dots = [100 100 500];   % or, you can specify the number of dots for each radius

% generate point set (determine dots' locations)
fprintf('generating point set... ');
pointset = generate_pointset(ones(im_height, im_width), r_dots, n_dots);
% or, you can constrain dots to be placed inside an image mask
%pointset = generate_pointset('images/circular-mask_200px.png', r_dots, n_dots);
fprintf('done.\n');


try
	rect = [0, 0, im_width, im_height];
	[cxcy(1), cxcy(2)] = RectCenter(rect);
	wptr = Screen('OpenWindow', 0, [128 128 128], rect);
	Screen('BlendFunction', wptr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	% draw normal pointillist image
	dot_colors = palette(:, pointset.c);
	Screen('DrawDots', wptr, pointset.xy, pointset.r * 2, dot_colors, cxcy, 2);
	Screen('Flip', wptr);

	% leave image on screen for 3 seconds
	WaitSecs(3);

	% draw scrambled pointillist image
	scrambled_colors = dot_colors(:, randperm(size(dot_colors, 2)));
	Screen('DrawDots', wptr, pointset.xy, pointset.r * 2, scrambled_colors, cxcy, 2);
	Screen('Flip', wptr);

	% leave image on screen for 3 seconds
	WaitSecs(3);

	Screen('CloseAll');
catch e
	Screen('CloseAll');
	rethrow(e);
end