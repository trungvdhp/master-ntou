I = imread('F:\Documents\Master\Image Processing\lena.bmp');
%imshow(I); title('Original Image');
subplot(2,4,1), subimage(I), title('Original Image')
X = reshape(double(I),size(I));
T = X;
[m,n,p]=size(I);
T(:,:,1)=0.299*X(:,:,1) + 0.587*X(:,:,2) + 0.114*X(:,:,3);
T(:,:,2)=0.564*(X(:,:,3) - T(:,:,1)) + 128;
T(:,:,3)=0.713*(X(:,:,1) - T(:,:,1)) + 128;

T = reshape(uint8(T),size(I));
%figure(2), imshow(T); title('YCbCr Image');
subplot(2,4,2), subimage(T), title('YCbCr Image')
Y = T(:,:,1);
%figure(3), imshow(Y); title('Y part of Image');
subplot(2,4,3), subimage(Y), title('Y part of Image')
CB = T(:,:,2);
%figure(4), imshow(CB); title('Cb part of Image');
subplot(2,4,5), subimage(CB), title('Cb part of Image')
CR = T(:,:,3);
%figure(5), imshow(CR); title('Cr part of Image');
subplot(2,4,7), subimage(CR), title('Cr part of Image')
CB1 = T;
CB1(:,:,3) = CB1(:,:,2);
CB1(:,:,[1 2]) = 0;
subplot(2,4,6), subimage(CB1), title('Cb part of Image')
CR1 = T;
CR1(:,:,1) = CR1(:,:,3);
CR1(:,:,[2 3]) = 0;
subplot(2,4,8), subimage(CR1), title('Cr part of Image')