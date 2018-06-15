clear, close all;

%% Read image and save as ascii hex file
img = imread('template_img.tif');
figure;
imshow(img);
SaveImgInTextFile(img, 'template_img.txt', '%d'); % Format %d or %x
