% load seed image
seed_imagemat = imread('images/seed-images/image01.png');
seed_imagemat = double(seed_imagemat) / 255;
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
[pointset, shapes] = generate_pointset(ones(im_height, im_width), r_dots, n_dots);
% or, you can constrain dots to be placed inside an image mask
%[pointset, shapes] = generate_pointset('images/circular-mask_200px.png', r_dots, n_dots);
fprintf('done.\n');

% draw dots to 4-channel matrix (RGB + alpha)
fprintf('drawing normal pointillist image... ');
dot_colors   = palette(:, pointset.c)';
image_normal = fabricate(im_height, im_width, shapes, dot_colors);
fprintf('done.\n');

% draw dots to 4-channel matrix (RGB + alpha)
fprintf('drawing scrambled pointillist image... ');
scrambled_colors = dot_colors(randperm(size(dot_colors, 1)), :);
image_scrambled  = fabricate(im_height, im_width, shapes, scrambled_colors);
fprintf('done.\n');


% show seed and normal/scrambled pointillist images
h = figure;
subplot(1, 3, 1);
imshow(seed_imagemat);
title('Seed image');

subplot(1, 3, 2);
init_pretina();
ptb.imshow_alpha(image_normal);  % imshow() function wrapper for 4-channel images
title('Normal pointillist image');

subplot(1, 3, 3);
ptb.imshow_alpha(image_scrambled);
title('Scrambled pointillist image');

% set figure size to true image size
truesize(h, [im_height, im_width]);
