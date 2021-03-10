%% OTSU default method

img = imread('cells.png');
gray_img = rgb2gray(img);
level = graythresh(gray_img);
defaultMethod = imbinarize(gray_img, level);
imshowpair(gray_img, defaultMethod, 'montage');

%% post-processing

