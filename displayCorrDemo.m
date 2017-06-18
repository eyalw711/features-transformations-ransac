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
H_comp

%% Q4

[pnts_gt, pnts_computed] = ComputeTestPoints(H, H_comp);
error = ComputeError(pnts_gt, pnts_computed);
error

%% Q5

