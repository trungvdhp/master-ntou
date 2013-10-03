I = imread('D:\Document\Master\Image Processing\lena.bmp');
X = reshape(double(I),size(I));
T = X;
[m,n,p]=size(I);
for k=1:m
    for d=1:n
        T(k,d,1)=0.257*X(k,d,1) + 0.504*X(k,d,2) + 0.098*X(k,d,3) +16;
        T(k,d,2)=-0.148*X(k,d,1) - 0.291*X(k,d,2) + 0.439*X(k,d,3) + 128;
        T(k,d,3)=0.439*X(k,d,1) - 0.368*X(k,d,2) - 0.071*X(k,d,3) + 128;
    end
end
T = reshape(uint8(T),size(I));
imshow(T)
