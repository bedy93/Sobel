clc;
clear all;
close all;

% img = imread('A.jpg'); 
% gray = (rgb2gray(img));
% imshow(gray);
% gray = dec2hex(gray');
% dlmwrite('cica.txt',gray,'delimiter','');


file_ID = fopen ( 'out.txt', 'r'); %visszaolvas
formatspec = '%x';
size_A= [800 521];
M = fscanf(file_ID, formatspec,size_A).'; %kell a transzpon�lt, k�l�nben elforog
fclose(file_ID);
figure();
imshow(M/255);

M = (M > 200); % ez megcsin�lja az �sszehasonl�t�st :)

figure();
imshow(M)
