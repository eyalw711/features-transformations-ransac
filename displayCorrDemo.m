RGB = imread('Hindenburg_disaster.jpg');
Im = rgb2gray(RGB);
H = [1 .2 0; .1 1 0; 0.5 0.2 1];

TransformedIm = ComputeProjective(Im, H);
imwrite(Im,'myleft.pgm');
imwrite(TransformedIm,'myright.pgm');

[num_matches, matches, dist_vals] = match('myleft.pgm', 'myright.pgm', 0.5);
displayedCorr = DisplayCorr(Im, TransformedIm, matches, dist_vals, 10);