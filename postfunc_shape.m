function voidmap = postfunc_shape(voidmap, params, mx, my)
	voidmap = params.postfunc(voidmap, params.params, mx, my);
end