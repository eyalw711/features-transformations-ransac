%RGB = imread('Hindenburg_disaster.jpg');
%Im = rgb2gray(RGB);
image1name = 'left.pgm';
image2name = 'right.pgm';

%% Q1
Im = imread(image1name);
H = [1 .2 0; .1 1 0; 0.5 0.2 1];
TransformedIm = ComputeProjective(Im, H);

imwrite(TransformedIm,'myright.pgm');

%% Q2
Im = imread(image1name);
TransformedIm = imread(image2name);
[num_matches, matches, dist_vals] = match(image1name, image2name, 0.5);
%displayedCorr = DisplayCorr(Im, TransformedIm, matches, dist_vals, 10);

%% Q3
H_comp = DLT(matches);

%% Q4
[pnts_gt, pnts_computed] = ComputeTestPoints(H, H_comp);
error_dlt = ComputeError(pnts_gt, pnts_computed);

%% Q5
s = 10;
t = 10;
H_ransac = RANSAC_Wrapper(matches, @ransac_fitting, @affine_trans_dist, @(x) 0, s, t, 0, 100, 1000);
[pnts_gt, pnts_ransac] = ComputeTestPoints(H, H_ransac);
error_ransac = ComputeError(pnts_gt, pnts_ransac);
%error_ransac

fprintf('DLT error: %.3g, RANSAC error: %.3g\n', error_dlt, error_ransac);
fprintf('RANSAC error is %.3g%% of DLT error\n', 100*error_ransac/error_dlt);

%% Qualitative error evaluation:

inv_trans_ransac = invert(affine2d(H_ransac));
reconstructed_ransac = imwarp(TransformedIm, inv_trans_ransac);

% fix H_comp if valid:
if sum(abs(H_comp(1:2,3))) < 0.01
    H_comp(:,3) = [0; 0; 1];
    inv_trans_dlt = invert(affine2d(H_comp));
    reconstructed_dlt = imwarp(TransformedIm, inv_trans_dlt);
    imshowpair(reconstructed_ransac, imresize(reconstructed_dlt, size(reconstructed_ransac)), 'montage');
else
    printf('H_comp is not affine and qualitative evaluation is not possible.\n');
end



