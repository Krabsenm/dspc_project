%% KBE, 26/2-2013
clear, close all;

%% Read image and save as ascii hex file

%img = imread('rice.tif');
img = imread('blood1.tif');
figure;
imshow(img);
SaveImgInTextFile(img, 'ImageIn12.txt', '%d'); % Format %d or %x

%% Use orig img for formatting output image
imgEdge = LoadImgFromTextFile(img, 'ImageOut.txt');
figure;
imshow(imgEdge);