I = imread('D:\Document\Master\Image Processing\lena.bmp');
X = reshape(double(I),size(I));
T = X;
[m,n,p]=size(I);
for k=1:m
    for d=1:n
        T(k,d,1)=0.299*X(k,d,1) + 0.587*X(k,d,2) + 0.114*X(k,d,3);
        T(k,d,2)=-0.172*X(k,d,1) - 0.339*X(k,d,2) + 0.511*X(k,d,3) + 128;
        T(k,d,3)=0.511*X(k,d,1) - 0.428*X(k,d,2) - 0.083*X(k,d,3) + 128;
    end
end
T = reshape(uint8(T),size(I));
imshow(T)
