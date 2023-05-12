%clear the command window, workspace, and any open figures.
clc;
clear all;
close all;
% inputs-pan1,pan2.
image1 = imread('pan1.jpg');
image2 = imread('pan2.jpg');
%converting the two images to gray scale ,then normalizing the grayscale
intensity values to be in the range [0,1].
image1 = im2double(rgb2gray(image1));
image2 = im2double(rgb2gray(image2));
[rows, colums] = size(image1);
disp("Number of rows: ")
disp(rows)
disp("Number of columns:")
disp(colums)
% initializing some variables that will be used later in the code.
Tmp = [];
temp = 0;
image_new = [];
%copying leftmost 5 coloums to the new_image(2D-array) from the second
image
k = 0;
for j = 1:5
 for i = 1:rows
 image_new(i,j) = image2(i,j);
 end
end
%computing cross-correlation between a 5-column wide window of image1
(sliding from left to right) first image and the leftmost 5colums of
second image
for k = 0:colums-5
 % to prevent j to go beyond colums boundaries.
 for j = 1:5
 image_new2(:,j) = image1(:,k+j);
 end
 temp = corr2(image_new2,image_new);
 % Tmp keeps growing, forming a matrix of 1*cols
 Tmp = [Tmp temp];
 temp = 0;
end
%finding the maximum correlation coefficient and the corresponding column
index (Index) in Tmp
[Max_value, Index] = max(Tmp);
disp("Maxvalue:")
disp(Max_value)
disp("Index value at maximum correlation:")
disp(Index)
% New column of output image.
new_columns = Index + colums - 1;
%creating the panoramic image
pano_img = [];
for i = 1:rows
 % First image is pasted till Index.
 for j = 1:Index-1
 pano_img(i,j) = image1(i,j);
 end
 %Second image is pasted after Index.
 for k = Index:new_columns
 pano_img(i,k) = image2(i,k-Index+1);
 end
end
[rows_pano_img, colums_pano_img] = size(pano_img);
%displaying the input images
figure
imshow(image1);
title('First Image');
figure
imshow(image2);
title('Second Image');
figure
%displaying the final stitched image
imshow(pano_img);
title('Stitched Image');
