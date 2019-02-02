function imagemats = fabricate(varargin)
	init_pretina();
	rows   = pretina_arg(varargin, 1, mfilename, 'rows',   [],   {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols   = pretina_arg(varargin, 2, mfilename, 'cols',   rows, {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	shapes = pretina_arg(varargin, 3, mfilename, 'shapes', [],   {'struct'},  {'nonempty'});
	shapes = shapes(arrayfun(@(s) ~isempty(s.coords), shapes));

	n_shapes = size(shapes, 1);
	if (nargin >= 4) && (size(varargin{4}, 1) == 1)
		if isa(varargin{4}, 'function_handle')
			colors = cell2mat(arrayfun(varargin{4}, shapes, 'UniformOutput', false));
		else
			colors = pretina_arg(varargin, 4, mfilename, 'colors',  [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1, 3]});
			colors = repmat(colors, n_shapes, 1);
		end
	else
		colors = pretina_arg(varargin, 4, mfilename, 'colors',  [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [n_shapes, 3]});
	end

	n_layers = max(arrayfun(@(s) s.im_layer, shapes));
	imagemats = repmat({zeros(rows, cols, 4)}, n_layers, 1);
	[bx, by] = base_xy(cols, rows);
	for i = 1:n_shapes
		im_layer = shapes(i).im_layer;
		shapemat = shapes(i).shapefunc( ...
				bx - shapes(i).coords(1), ...
				by - shapes(i).coords(2), ...
				shapes(i).params);
		imagemats{im_layer}(:, :, 1:3) = apply_alpha( ...
			imagemats{im_layer}(:, :, 1:3), ...
			rgb2map(colors(i, :), rows, cols), ...
			double(shapemat > 0));
		imagemats{im_layer}(:, :, 4) = apply_alpha( ...
			imagemats{im_layer}(:, :, 4), ...
			ones(rows, cols), shapemat);
	end

	if n_layers == 1
		imagemats = imagemats{1};
	end
end