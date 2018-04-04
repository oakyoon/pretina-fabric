function shape = marginfunc_ratio(shape, margin)
	if nargin < 2
		margin = 1;
	end
	pr1 = shape.params(1) + margin;
	if size(shape.params, 2) >= 2
		pr2 = shape.params(1) / shape.params(2) + margin;
		shape.params(1:2) = [pr1, pr1 / pr2];
	else
		shape.params(1) = pr1;
	end
end