function [ TransformedIm ] = ComputeProjective( Im, H )
    TransformedIm = imwarp(Im, affine2d(H));
end



