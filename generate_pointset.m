function [pset, shapes] = generate_pointset(image_mask, r_dots, n_dots)
	if ischar(image_mask)
		image_mask = load_image_mask(image_mask);
	end
	if ~exist('n_dots', 'var') || isempty(n_dots)
		mask_area = sum(image_mask(:));
		dot_area  = mean((r_dots + .5) .^ 2 * pi);
		n_dots    = round((mask_area * .405) / dot_area);
	end
	n_total = sum(n_dots);
	if ~isscalar(r_dots) && isscalar(n_dots)
		n_dots  = repmat(floor(n_total / length(r_dots)), 1, length(r_dots));
		n_more  = n_total - sum(n_dots);
		n_dots(1:n_more) = n_dots(1:n_more) + 1;
	end

	r_pset = cell2mat(arrayfun(@(i) repmat(r_dots(i), 1, n_dots(i)), 1:length(r_dots), 'UniformOutput', false));
	r_pset = sort(r_pset, 'descend')';

	shapes = shapes_oval(n_total, r_pset);
	[shapes, ~, n_placed] = arrange_shapes(image_mask, shapes);
	if n_placed < n_total
		shapes = shapes(1:n_placed);
		r_pset = r_pset(1:n_placed);
	end

	coords = round(cell2mat({ shapes.coords }'));

	im_height = size(image_mask, 1);
	[im_cxcy(1), im_cxcy(2)] = RectCenter(RectOfMatrix(image_mask));
	color_idx = coords + repmat(im_cxcy, n_placed, 1);
	color_idx = (color_idx(:, 1) - 1) * im_height + color_idx(:, 2);

	pset = struct(...
		'n',  n_placed, ...
		'xy', coords', ...
		'c',  color_idx', ...
		'r',  r_pset' ...
		);
end