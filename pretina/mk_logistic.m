function logisticmat = mk_logistic(varargin)
%MK_LOGISTIC Converts a matrix using a sigmoid function.
%
%   LOGISTICMAT = MK_LOGISTIC(PIXELMAP, RADIUS [,K]) returns a matrix with the
%   same size as PIXELMAP. Values in the PIXELMAP are transformed using a
%   sigmoid function with a midpoint of RADIUS and a steepness of K.
%
%   Arguments:
%      PIXELMAP - an image matrix, usually generated by MAP_* functions.
%      RADIUS   - the midpoint of a sigmoid.
%      K        - the steepness of a sigmoid, -1 if empty or not provided.
%
%   Example:
%      <a href="matlab:imshow(mk_logistic(map_rectangular(200, [], [], 15), 50, -.5));">imshow(mk_logistic(map_rectangular(200, [], [], 15), 50, -.5));</a>
%
%   See also MAP_SYMMETRIC, MAP_RADIAL, MAP_RECTANGULAR.

	pixelmap = pretina_arg(varargin, 1, mfilename, 'pixelmap', [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan'});
	radius   = pretina_arg(varargin, 2, mfilename, 'radius',   [], {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});
	k        = pretina_arg(varargin, 3, mfilename, 'k',        -1, {'numeric'}, {'scalar', 'real', 'nonnan'});

	logisticmat = 1 ./ (1 + exp(-k * (pixelmap - radius)));
end