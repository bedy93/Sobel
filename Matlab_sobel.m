clear all;
close all;
 
img = imread('sample.jpg');  % Kép beolvasása
gray = double(rgb2gray(img)); % Átalkakítás lebegõpontos változóvá, illetve normálás 0-1re



[m,n] = size(gray);

out1 = zeros(m,n);
out2 = zeros(m,n);

Kernel1 = [-1 0 1; -2 0 2; -1 0 1];
Kernel2 = [-1 -2 -1; 0 0 0; 1 2 1];

for i=1:1:m-3
    for k=1:1:n-3
        temp = gray(i:i+2,k:k+2).*Kernel1;
        out1(i+1,k+1) = sum(sum(temp));
    end
end

out1 = abs(out1)/255;
figure
imshow(out1);

for i=1:1:m
    for k=1:1:n
        if(out1(i,k)>0.5)
            out1(i,k) = 1;
        else
            out1(i,k) = 0;
        end
    end
end

figure
imshow(out1);

for i=1:1:m-3
    for k=1:1:n-3
        temp = gray(i:i+2,k:k+2).*Kernel2;
        out2(i+1,k+1) = sum(sum(temp));
    end
end

out2 = abs(out2)/255;
figure
imshow(out2);

for i=1:1:m
    for k=1:1:n
        if(out2(i,k)>0.5)
            out2(i,k) = 1;
        else
            out2(i,k) = 0;
        end
    end
end

figure
imshow(out2);

figure
out3= out1+out2;
imshow(out3);

        