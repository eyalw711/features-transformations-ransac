Im = imread('simpsons.pgm');
TransformedIm = imread('simpsons_trans.pgm');

H_rot = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
H_skew = [1 0.4 0; 0 1 0; 0 0 1];
H_trans = H_rot * H_skew;
fprintf('theoretic transform:\n');
display(H_trans);

[num_matches, matches, dist_vals] = match('simpsons.pgm', 'simpsons_trans.pgm', 0.5);

H_dlt = DLT(matches);

% to make into an affine transform must set last column
if sum(abs(H_dlt(1:2,3))) < 0.01 %check if reasonable to zero
    H_dlt(:,3) = [0; 0; 1];
else
    fprintf('cannot take H_dlt as an affine transform\n');
    return;
end

fprintf('transform by DLT:\n');
display(H_dlt);

[pnts_gt, pnts_computed] = ComputeTestPoints(H, H_dlt);
error_dlt = ComputeError(pnts_gt, pnts_computed);

s = 10;
t = 10;
fprintf('running ransac with s=%d, t=%f\n', s, t);
H_ransac = RANSAC_Wrapper(matches, @ransac_fitting, @affine_trans_dist, @(x) 0, s, t, 0, 100, 1000);

fprintf('transform by RANSAC:\n');
display(H_ransac);

[pnts_gt, pnts_ransac] = ComputeTestPoints(H, H_ransac);
error_ransac = ComputeError(pnts_gt, pnts_ransac);

% Quantative error evaluation:

fprintf('DLT error: %.3g, RANSAC error: %.3g\n', error_dlt, error_ransac);
fprintf('RANSAC error is %.3f%% of DLT error\n', 100*error_ransac/error_dlt);

% Qualitative error evaluation:

inv_trans_dlt = invert(affine2d(H_comp));
reconstructed_dlt = imwarp(TransformedIm, inv_trans_dlt);

inv_trans_ransac = invert(affine2d(H_ransac));
reconstructed_ransac = imwarp(TransformedIm, inv_trans_ransac);

legend_dlt = insertText(reconstructed_dlt, [0 0], 'inverse using H_dlt','FontSize' ,32);
legend_ransac = insertText(reconstructed_ransac, [0 0], 'inverse using H_ransac','FontSize' ,32);
imshowpair(legend_dlt, imresize(legend_ransac, size(legend_dlt(:,:,1))), 'montage');