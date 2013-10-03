I = imread('D:\Document\Master\Image Processing\lena.bmp');
X = reshape(double(I),size(I));
T = X;
[m,n,p]=size(I);
for k=1:m
    for d=1:n
        T(k,d,1)=0.213*X(k,d,1) + 0.715*X(k,d,2) + 0.072*X(k,d,3);
        T(k,d,2)=-0.117*X(k,d,1) - 0.394*X(k,d,2) + 0.511*X(k,d,3) + 128;
        T(k,d,3)=0.511*X(k,d,1) - 0.464*X(k,d,2) - 0.047*X(k,d,3) + 128;
    end
end
T = reshape(uint8(T),size(I));
imshow(T)
