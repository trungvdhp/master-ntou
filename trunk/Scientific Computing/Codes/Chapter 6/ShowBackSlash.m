% Script: ShowBackSlash
%

clc
b = randn(n,1);

disp(' n            Full          Lower          Lower       Upper          Upper      Tridiagonal')
disp('                          Triangular     Bidiagonal  Triangular     Hessenberg              ')
disp('--------------------------------------------------------------------------------------------')

for n=[20 40 80 160]
   I = eye(n,n);
   b = rand(n,1);
   A = rand(n,n)+I;                   flops(0); x = A\b; f0 = flops;
   L = tril(rand(n,n))+I;             flops(0); x = L\b; f1 = flops;
   L = triu(tril(rand(n,n)),-1)+I;    flops(0); x = L\b; f2 = flops;
   U = triu(rand(n,n))+I;             flops(0); x = U\b; f3 = flops;
   H = triu(rand(n,n),-1)+I;          flops(0); x = H\b; f4 = flops;
   T = triu(tril(rand(n,n),1),-1)+I;  flops(0); x = T\b; f5 = flops;
   disp(sprintf('%4d     %10d    %10d    %10d    %10d    %10d    %10d',n,f0,f1,f2,f3,f4,f5))
end 






U = triu(randn(n,n));
