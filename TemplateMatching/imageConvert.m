%% KBE, 26/2-2013
clear, close all;

%% Read image and save as ascii hex file

%img = imread('rice.tif');
%img = imread('test_img2.jpg');
%img = rgb2gray(img);
img = [I; I]; 

figure;
imshow(img, []);

SaveImgInTextFile(img, 'templateTestFull.txt', '%d'); % Format %d or %x

%% Use orig img for formatting output image
imgEdge = LoadImgFromTextFile(img, 'ImageOut.txt');
figure;
imshow(imgEdge);