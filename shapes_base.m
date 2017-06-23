function shapes = shapes_base(varargin)
	init_pretina();
	n_shapes   = pretina_arg(varargin, 1,  mfilename, 'n_shapes',   [], {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	params     = pretina_arg(varargin, 2,  mfilename, 'params',     [], {'numeric', 'struct'}, {'nonempty', '2d'});
	shapefunc  = pretina_arg(varargin, 3,  mfilename, 'shapefunc',  [], {'function_handle'},  { });
	marginfunc = pretina_arg(varargin, 4,  mfilename, 'marginfunc', [], {'function_handle'},  { });
	prefunc    = pretina_arg(varargin, 5,  mfilename, 'prefunc',    [], {'function_handle'},  { });
	postfunc   = pretina_arg(varargin, 6,  mfilename, 'postfunc',   [], {'function_handle'},  { });

	sidx = 1:n_shapes;
	shapes = struct([]);
	if size(params, 1) == 1
		[shapes(sidx, 1).params] = deal(params);
	elseif size(params, 1) == n_shapes
		params_cell = mat2cell(params, ones(n_shapes, 1), size(params, 2));
		[shapes(sidx, 1).params] = deal(params_cell{:});
	end
	[shapes(sidx, 1).shapefunc]  = deal(shapefunc);
	[shapes(sidx, 1).marginfunc] = deal(marginfunc);
	[shapes(sidx, 1).prefunc]    = deal(prefunc);
	[shapes(sidx, 1).postfunc]   = deal(postfunc);
	[shapes(sidx, 1).im_layer]   = deal(1);
end