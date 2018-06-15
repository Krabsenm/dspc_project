clear, close all;

%% Read image and save as ascii hex file
img = imread('blood1.tif');
figure;
imshow(img);
SaveImgInTextFile(img, 'ImageIn.txt', '%d'); % Format %d or %x
