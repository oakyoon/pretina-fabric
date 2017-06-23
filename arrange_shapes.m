function [shapes, availmap, n_placed] = arrange_shapes(varargin)
	init_pretina();
	if nargin >= 1 && ischar(varargin{1})
		image_mask = pretina_arg(varargin, 1, mfilename, 'image_mask', [], {'char'}, {'nonempty', 'row'});
		image_mask = load_image_mask(image_mask);
	else
		image_mask = pretina_arg(varargin, 1, mfilename, 'image_mask', [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', '2d'});
		image_mask = normalize_map(image_mask, 0);
	end
	shapes = pretina_arg(varargin, 2, mfilename, 'shapes', [], {'struct'},  {'nonempty'});

	[coords, availmap, n_placed] = random_coords(image_mask, ...
		arrayfun(@(s) s.marginfunc(s), shapes), ...
		@postfunc_shape, @prefunc_shape ...
		);
	coords_cell = mat2cell(coords(1:n_placed, :), ones(n_placed, 1), 2);
	[shapes(1:n_placed).coords] = deal(coords_cell{:});
	if n_placed < length(shapes)
		fprintf(2, 'only %d out of %d elements placed.\n', n_placed, length(shapes));
	end
end