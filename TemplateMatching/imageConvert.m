%% KBE, 26/2-2013
clear, close all;

%% Read image and save as ascii hex file

%img = imread('rice.tif');
%img = imread('test_img2.jpg');
%img = rgb2gray(img);
x = ones(32,1);
y = 1:120; 

img  = x*y;
img = img./max(img(:));

img = [img ones(32,120)];
%img = img(1:32, 1:240);
figure;
imshow(img);

SaveImgInTextFile(img, 'ImageIn12.txt', '%d'); % Format %d or %x

%% Use orig img for formatting output image
imgEdge = LoadImgFromTextFile(img, 'ImageOut.txt');
figure;
imshow(imgEdge);