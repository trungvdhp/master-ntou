% Script  P5_1_1
%
% Compare two ways of setting up the Pascal matrix

clc
disp('   n     PascalTri   PascalTri1')
disp('           Flops        Flops ')
disp('------------------------------------')
for n=[5 10 20 40 80]
   flops(0);
   P = PascalTri(n);
   f = flops;
   flops(0);
   P = PascalTri1(n);
   f1 = flops;
   disp(sprintf(' %3.0f      %6.0f      %6.0f',n, f,f1))
end