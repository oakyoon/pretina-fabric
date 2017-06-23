function shapemat = shapefunc_rect(bx, by, params)
	[radius, ratio, tilt, outline_t] = pretina_params(params, [], 1, 0, 0);

	[rx, ry] = rotate_xy(bx, by, tilt);
	if (outline_t > 0) && (outline_t < radius)
		radius_inner = radius - outline_t;
		ratio_inner  = radius_inner / (radius / ratio - outline_t);
		shapemat = mk_shape(max(abs(rx), abs(ry) * ratio), radius) - ...
			mk_shape(max(abs(rx), abs(ry) * ratio_inner), radius_inner);
	else
		shapemat = mk_shape(max(abs(rx), abs(ry) * ratio), radius);
	end
end