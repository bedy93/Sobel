clc;
clear all;
close all;

img = imread('zebra_120_90.jpg'); 
gray = (rgb2gray(img));
imshow(gray);
gray = dec2hex(gray');
dlmwrite('zebra.txt',gray,'delimiter','');


file_ID = fopen ( 'zebra.txt', 'r'); %visszaolvas
formatspec = '%x';
size_A= [120 90];
M = fscanf(file_ID, formatspec,size_A).'; %kell a transzponált, különben elforog
fclose(file_ID);
figure();
imshow(M/255);

M = (M > 200); % ez megcsinálja az összehasonlítást :)

figure();
imshow(M)
