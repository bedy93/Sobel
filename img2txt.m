img = imread('Lena32_32.bmp'); 
%gray = (rgb2gray(img));
gray_2 = dec2hex(rgb2gray(img));
dlmwrite('test2.txt',gray_2,'delimiter','');
%dlmwrite('test.txt',gray,'delimiter',' '); %teszt

file_ID = fopen ( 'kimenet.txt', 'r'); %visszaolvas
formatspec = '%x';
size_A= [32 32];
M = fscanf(file_ID, formatspec,size_A);
figure
imshow(M/255);
fclose(file_ID);