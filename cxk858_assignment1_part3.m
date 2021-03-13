%% Question 3.1

% Otsu's method(default)

img = imread('cells.png');
gray = rgb2gray(img);
level = graythresh(gray);

otsu = imbinarize(gray, level);
figure;
imshowpair(gray, otsu, 'montage');
title('OTSU method');

% pre-processing for edge detection
% apply gaussian filters with differnet sigma value
filter3 = imgaussfilt(gray, 3);
filter05 = imgaussfilt(gray);

% apply 
adjust3 = imadjust(filter3);
adjust05 = imadjust(filter05);
adapthist3 = adapthisteq(filter3);
adapthist05 = adapthisteq(filter05);

sobel_adjust3 = edge(adjust3, 'sobel');
sobel_adjust05 = edge(adjust05, 'sobel');
sobel_adapthist3 = edge(adapthist3, 'sobel');
sobel_adapthist05 = edge(adapthist05, 'sobel');

canny_adjust3 = edge(adjust3, 'canny');
canny_adapthist3 = edge(adapthist3, 'canny');
canny_adjust05 = edge(adjust05, 'canny');
canny_adapthist05 = edge(adapthist05, 'canny');

sobel_overlay1 = imoverlay(gray, sobel_adjust3, [1 1 .5]);
sobel_overlay2 = imoverlay(gray, sobel_adjust05, [1 1 .5]);
sobel_overlay3 = imoverlay(gray, sobel_adapthist3, [1 1 .5]);
sobel_overlay4 = imoverlay(gray, sobel_adapthist05, [1 1 .5]);

figure;
sgtitle('Edge detection using sobel');

subplot(2,2,1);
imshow(sobel_overlay1);
title('Used imadjust and gaussian filter (sig:3)');

subplot(2,2,2);
imshow(sobel_overlay2);
title('Used imadjust and gaussian filter (sig:0.5)');

subplot(2,2,3);
imshow(sobel_overlay3);
title('Used adapthisteq and gaussian filter (sig:3)');

subplot(2,2,4);
imshow(sobel_overlay4);
title('Used adapthisteq and gaussian filter (sig:0.5)');

canny_overlay1 = imoverlay(gray, canny_adjust3, [1 1 .5]);
canny_overlay2 = imoverlay(gray, canny_adjust05, [1 1 .5]);
canny_overlay3 = imoverlay(gray, canny_adapthist3, [1 1 .5]);
canny_overlay4 = imoverlay(gray, canny_adapthist05, [1 1 .5]);

figure;
sgtitle('Edge detection using canny');

subplot(2,2,1);
imshow(canny_overlay1);
title('Used imadjust and gaussian filter (sig:3)');

subplot(2,2,2);
imshow(canny_overlay2);
title('Used imadjust and gaussian filter (sig:0.5)');

subplot(2,2,3);
imshow(canny_overlay3);
title('Used adapthisteq and gaussian filter (sig:3)');

subplot(2,2,4);
imshow(canny_overlay4);
title('Used adapthisteq and gaussian filter (sig:0.5)');
% imshowpair(otsu, edge_sobel, 'montage');

% Winner is sobel_adjust3
