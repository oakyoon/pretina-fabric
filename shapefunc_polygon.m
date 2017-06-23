function shapemat = shapefunc_polygon(bx, by, params)
	[radius, sides, tilt, outline_t] = pretina_params(params, [], 3, 0, 0);

	angles = linspace(0, 360, sides + 1);
	angles = angles(angles < 360) + tilt;
	[rows, cols] = size(bx);
	shapemat = zeros(rows, cols, length(angles));
	for i = 1:length(angles)
		[~, shapemat(:, :, i)] = rotate_xy(bx, by, angles(i));
	end

	if (outline_t > 0) && (outline_t < radius)
		shapemat = max(shapemat, [], 3);
		shapemat = mk_shape(shapemat, radius) - ...
			mk_shape(shapemat, radius - outline_t);
	else
		shapemat = mk_shape(max(shapemat, [], 3), radius);
	end
end