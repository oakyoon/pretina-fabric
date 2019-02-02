% batch job params.
src_path = 'images/seed-images/';         % where seed images are
dst_path = 'images/pointillist-images/';  % pointillist images will be placed here
file_prefix = {
	'np_';  % file prefix for normal pointillist images
	'sp_';  % file prefix for scrambled pointillist images
	};

% image params.
bg_color  = [128, 128, 128];  % ptb3 screen background color
im_height = 200;
im_width  = 200;
r_dots    = [1.5, 2.0, 2.5];  % radii of dots
n_dots    = [];               % generate_pointset() determines the number of dots

% find image files source folder (src_path)
image_filter = @(s) ~isempty(regexp(s, '\.(bmp|tiff?|jpe?g|png|gif)$', 'once'));
seed_images = dir(src_path);
seed_images = { seed_images.name };
seed_images = seed_images(cellfun(image_filter, seed_images));
n_images = length(seed_images);

fprintf('found %d image files in ''%s''\n', n_images, src_path);

% create destination folder (dst_path)
if ~exist(dst_path, 'dir')
	mkdir(dst_path)
end


try
	rect = [0, 0, im_width, im_height];
	[cxcy(1), cxcy(2)] = RectCenter(rect);
	wptr = Screen('OpenWindow', 0, bg_color, rect);
	Screen('BlendFunction', wptr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	fprintf('processing images:\n');
	for i = 1:n_images
		% command window: print current image number every 25 images
		if mod(i, 25) == 1
			fprintf('[%04d] ', i);
		end

		for s = 1:2
			if s == 1  % command window: generating normal pointillist image
				fprintf('n');
			else       % command window: generating scrambled pointillist image
				fprintf('\bs');
			end

			% load seed image, prepare color palette
			seed_imagemat = imread(fullfile(src_path, seed_images{i}));
			palette  = image2palette(seed_imagemat);
			% generate point set (determine dots' locations)
			pointset = generate_pointset(ones(im_height, im_width), r_dots, n_dots);

			% draw pointillist image
			dot_colors = palette(:, pointset.c);
			if s == 2
				dot_colors = dot_colors(:, randperm(size(dot_colors, 2)));
			end
			Screen('DrawDots', wptr, pointset.xy, pointset.r * 2, dot_colors, cxcy, 2);
			Screen('Flip', wptr);

			% capture ptb3 screen and save to an image file
			scr_imagemat = double(Screen('GetImage', wptr)) / 255;
			imwrite(scr_imagemat, fullfile(dst_path, strcat(file_prefix{s}, seed_images{i})));
		end
		% command window: normal and scrambled pointillist images generated
		fprintf('\b.');

		% command window: progress report to new line every 25 images
		if (mod(i, 25) == 0) || i == n_images
			fprintf('\n');
		end
	end
	fprintf('done.\n');

	Screen('CloseAll');
catch e
	Screen('CloseAll');
	rethrow(e);
end