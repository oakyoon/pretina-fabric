function image_mask = load_image_mask(varargin)
	init_pretina();
	image_file = pretina_arg(varargin, 1, mfilename, 'image_file', [], {'char'}, {'nonempty', 'row'});

	image_mask = double(ptb.imread_alpha(image_file)) / 255;
	n_layers = size(image_mask, 3);
	if n_layers == 4
		image_mask = apply_alpha(0, ...
			rgb2gray(image_mask(:, :, 1:3)), ...
			image_mask(:, :, 4));
	elseif n_layers == 3
		image_mask = rgb2gray(image_mask(:, :, 1:3));
	elseif n_layers == 2
		image_mask = apply_alpha(0, image_mask);
	end
	image_mask = normalize_map(image_mask, 0);
end