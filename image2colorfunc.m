function colorfunc = image2colorfunc(varargin)
	init_pretina();
	imagemat = pretina_arg(varargin, 1, mfilename, 'imagemat', [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', '3d'});
	if nargin < 2 || isempty(varargin{2})
		bg_color = [];
	else
		bg_color = pretina_arg(varargin, 2, mfilename, 'bg_color', [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1 3]});
	end

	image_info = struct( ...
		'mat',  imagemat, ...
		'wwhh', [size(imagemat, 1), size(imagemat, 2)], ...
		'cxcy', [size(imagemat, 2), size(imagemat, 1)] / 2, ...
		'bg',   bg_color);
	function c = pixel_color(s)
		if ~isempty(s.coords)
			coords = round(image_info.cxcy + s.coords);
			if all([coords > 0, coords < image_info.wwhh])
				c = image_info.mat(coords(2), coords(1), :);
				c = c(:)';
			else
				c = image_info.bg;
			end
		else
			c = [];
		end
	end
	colorfunc = @pixel_color;
end