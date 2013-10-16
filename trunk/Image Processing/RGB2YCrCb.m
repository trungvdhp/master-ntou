I = imread('D:\Document\Master\Image Processing\lena.bmp');
figure(1);
imshow(I);
X = reshape(double(I),size(I));
T = X;
[m,n,p]=size(I);
for k=1:m
    for d=1:n
        T(k,d,1)=0.299*X(k,d,1) + 0.587*X(k,d,2) + 0.114*X(k,d,3);
        T(k,d,2)=0.564*(X(k,d,3) - T(k,d,1)) + 128;
        T(k,d,3)=0.713*(X(k,d,1) - T(k,d,1)) + 128;
    end
end
T = reshape(uint8(T),size(I));
figure(2);
imshow(T);
