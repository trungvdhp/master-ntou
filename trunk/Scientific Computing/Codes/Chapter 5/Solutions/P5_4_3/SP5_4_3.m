% Script P5_4_3
%
% Compares compares general-n Strassen method flops with ordinary A*B flops

clc
A0 = rand(128,128);
B0 = rand(128,128);
disp('  n   Strass Flops   Ordinary Flops')
disp('-------------------------------------')
for n = [15:33 63 64 127 128]
   A = A0(1:n,1:n);
   B = B0(1:n,1:n);
   flops(0);
   C = MyStrass(A,B);
   f = flops;
   disp(sprintf('%3.0f   %10.0f   %10.0f', n,f,2*n^3))
end