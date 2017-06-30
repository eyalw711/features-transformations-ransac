function [ H ] = ransac_fitting( matches )
    pts1 = matches(1:2, :)';
    pts2 = matches(3:4, :)';
    [tform,~,~] = estimateGeometricTransform(pts1,pts2,'affine');
    H = tform.T;
end