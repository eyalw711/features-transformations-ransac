function [ TransformedIm ] = ComputeProjective( Im, H )
    TransformedIm = imwarp(Im, affine2d(H));
%     s = size(Im);
%     TransformedIm = imresize(TransformedIm, s);

end



