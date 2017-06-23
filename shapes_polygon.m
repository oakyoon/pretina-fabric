function shapes = shapes_polygon(varargin)
	init_pretina();
	n_shapes = pretina_arg(varargin, 1,  mfilename, 'n_shapes',   [], {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	params   = pretina_arg(varargin, 2,  mfilename, 'params',     [], {'numeric', 'struct'}, {'nonempty', '2d'});

	shapes = shapes_base(n_shapes, params, ...
		@shapefunc_polygon, @marginfunc_simple, ...
		@prefunc_polygon, @postfunc_polygon);
end