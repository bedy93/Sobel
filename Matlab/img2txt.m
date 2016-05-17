clc;
clear all;
close all;

img = imread('virag_128_96.jpg'); 
gray = (rgb2gray(img));
imshow(gray);
gray = dec2hex(gray');
dlmwrite('virag_128_96.txt',gray,'delimiter','');


% file_ID = fopen ( 'vik_128_96.txt', 'r'); %visszaolvas
% formatspec = '%x';
% size_A= [128 96];
% M = fscanf(file_ID, formatspec,size_A).'; %kell a transzponált, különben elforog
% fclose(file_ID);
% figure();
% imshow(M/255);
% 
% M = (M > 128); % ez megcsinálja az összehasonlítást :)
% 
% figure();
% imshow(M)
