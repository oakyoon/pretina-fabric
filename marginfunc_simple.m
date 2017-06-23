function shape = marginfunc_simple(shape, margin)
	if nargin < 2
		margin = 1;
	end
	shape.params(1) = shape.params(1) + margin;
end