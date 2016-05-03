clc;
clear all;

% img = imread('A.jpg'); 
% gray = (rgb2gray(img));
% imshow(gray);
% gray = dec2hex(gray');
% dlmwrite('cica.txt',gray,'delimiter','');


file_ID = fopen ( 'out.txt', 'r'); %visszaolvas
formatspec = '%x';
size_A= [640 480];
M = fscanf(file_ID, formatspec,size_A);
fclose(file_ID);



for i=1:640
    for k=1:480
        if(M(i,k) > 200)
            M(i,k) = 1;
        else M(i,k) = 0;    
        end
    end
end
figure();
imshow(M)
