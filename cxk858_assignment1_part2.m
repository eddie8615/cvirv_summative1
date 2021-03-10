%% Question 2.1.1

img = imread('dom.jpg');
grayscaled_img = rgb2gray(img);
img_gaussian_noise = imnoise(grayscaled_img, 'gaussian', 0.3, 0.5);
img_saltpepper_noise = imnoise(grayscaled_img, 'salt & pepper', 0.075);
img_speckled_noise = imnoise(grayscaled_img, 'speckle');

figure;
sgtitle('Solution of Task 2.1.1');
subplot(2,2,1);
imshow(grayscaled_img);
title('Original image');

subplot(2,2,2);
imshow(img_gaussian_noise);
title('Gaussian noise');

subplot(2,2,3);
imshow(img_saltpepper_noise);
title('Salt and pepper noise');

subplot(2,2,4);
imshow(img_speckled_noise);
title('Speckle noise');

pause(0.5);

%% Question 2.1.2

imageSize = size(grayscaled_img)
output_template = zeros(imageSize(1), imageSize(2));
gaussian_min_output = output_template;
gaussian_max_output = output_template;
gaussian_mean_output = output_template;
gaussian_median_output = output_template;

sp_min_output = output_template;
sp_max_output = output_template;
sp_mean_output = output_template;
sp_median_output = output_template;

padded_gaussian = padarray(img_gaussian_noise, [2 2]);
padded_saltpepper = padarray(img_saltpepper_noise, [2 2]);


for i = 3:imageSize(1)+2
    for j = 3:imageSize(2)+2
        gaussian_window=padded_gaussian(i-2:i+2, j-2:j+2);
        sp_window = padded_saltpepper(i-2:i+2, j-2:j+2);
        gaussian_flatten = gaussian_window(:);
        sp_flatten  = sp_window(:);
        gaussian_min_output(i-2,j-2) = min(gaussian_flatten);
        gaussian_max_output(i-2,j-2) = max(gaussian_flatten);
        gaussian_mean_output(i-2,j-2) = mean(gaussian_flatten);
        gaussian_median_output(i-2,j-2) = median(gaussian_flatten);
        
        sp_min_output(i-2,j-2) = min(sp_flatten);
        sp_max_output(i-2,j-2) = max(sp_flatten);
        sp_mean_output(i-2,j-2) = mean(sp_flatten);
        sp_median_output(i-2,j-2) = median(sp_flatten);
        
        
    end
end

gaussian_min_output = uint8(gaussian_min_output);
gaussian_max_output = uint8(gaussian_max_output);
gaussian_mean_output = uint8(gaussian_mean_output);
gaussian_median_output = uint8(gaussian_median_output);

sp_min_output = uint8(sp_min_output);
sp_max_output = uint8(sp_max_output);
sp_mean_output = uint8(sp_mean_output);
sp_median_output = uint8(sp_median_output);

figure;
sgtitle('Solution of Task 2.1.2');
subplot(2,5,1);
imshow(img_gaussian_noise);
title('Image with Gaussian noise');

subplot(2,5,2);
imshow(gaussian_min_output);
title('Gaussian noise 5x5 min filter');

subplot(2,5,3);
imshow(gaussian_max_output);
title('Gaussian noise 5x5 max filter');

subplot(2,5,4);
imshow(gaussian_mean_output);
title('Gaussian noise 5x5 mean filter');

subplot(2,5,5);
imshow(gaussian_median_output);
title('Gaussian noise 5x5 med filter');

subplot(2,5,6);
imshow(img_saltpepper_noise);
title('Image with Salt & Pepper noise');

subplot(2,5,7);
imshow(sp_min_output);
title('Salt & Pepper noise 5x5 min filter');

subplot(2,5,8);
imshow(sp_max_output);
title('Salt & Pepper noise 5x5 max filter');

subplot(2,5,9);
imshow(sp_mean_output);
title('Salt & Pepper noise 5x5 mean filter');

subplot(2,5,10);
imshow(sp_median_output);
title('Salt & Pepper noise 5x5 med filter');
pause(1);

%% Question 2.2
noise_features = detectSURFFeatures(img_saltpepper_noise);
denoised_features = detectSURFFeatures(sp_median_output);

figure;
imshow(img_saltpepper_noise);
hold on;
plot(selectStrongest(noise_features, 100));

figure;
imshow(sp_median_output);
hold on;
plot(selectStrongest(denoised_features, 100));

[noiseFeatures, noisePoints] = extractFeatures(img_saltpepper_noise, noise_features);
[denoiseFeatures, denoisePoints] = extractFeatures(sp_median_output, denoised_features);
featurePairs = matchFeatures(noiseFeatures, denoiseFeatures, 'Unique', true);
matchedNoisePoints = noisePoints(featurePairs(:,1),:);
matchedDenoisePoints = denoisePoints(featurePairs(:,2),:);
figure;
showMatchedFeatures(img_saltpepper_noise, sp_median_output, matchedNoisePoints, matchedDenoisePoints,'montage');

