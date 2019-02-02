function cpmat = image2palette(imagemat)
	[im_height, im_width, im_channel] = size(imagemat);
	if im_channel == 1
		imagemat = repmat(imagemat, [1, 1, 3]);
	end
	cpmat = permute(reshape(imagemat, [im_height * im_width, 1, 3]), [3, 1, 2]);
end