RGB = imread('Hindenburg_disaster.jpg');
Im = rgb2gray(RGB);
H = [1 .2 0; .1 1 0; 0.5 0.2 1];

TransformedIm = ComputeProjective(Im, H);

figure
imshow(TransformedIm);