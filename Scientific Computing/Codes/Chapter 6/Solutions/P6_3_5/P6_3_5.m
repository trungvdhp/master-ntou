% Problem P6_3_5
%
% Examines the solution to ABCx = f.

clc 
disp('f1 = ProdSolve flops')
disp('f2 = Multiply and Solve flops')
disp(' ')
disp(' ')
disp('   n      f2/f1  ')
disp('-----------------')
for n = [10 20 40 80 160]
   A = randn(n,n);
   B = randn(n,n);
   C = randn(n,n);
   f = randn(n,1);
   flops(0);
   x = ProdSolve(A,B,C,f);
   f1 = flops;
   flops(0)
   M = A*B*C;
   [LM,UM,pivM] = GEpiv(M);
   y = LTriSol(LM,f(pivM));
   xtilde = UTriSol(UM,y);
   f2 = flops;
   disp(sprintf('%4.0f   %8.3f',n,f2/f1))
end