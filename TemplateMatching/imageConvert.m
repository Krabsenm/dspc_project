%% KBE, 26/2-2013
clear, close all;

%% Read image and save as ascii hex file

img = imread('naturedogetemplate2.png');
img = rgb2gray(img); 

% figure;
% imshow(img, []);
SaveImgInTextFile(img, 'naturedogetemplate2.txt', '%d'); % Format %d or %x

%% Use orig img for formatting output image
imgEdge = LoadImgFromTextFile(img, 'DogeImageOut.txt');
figure;
imshow(imgEdge);