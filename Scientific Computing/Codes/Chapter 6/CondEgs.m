% Script File: CondEgs
% Examines errors for a family of linear equation problems.

for n = [4 8 12 16]
   clc
   A = pascal(n);
   disp(sprintf('cond(pascal(%2.0f)) = %8.4e',n,cond(A)));
   disp('True solution is vector of ones. Computed solution =')
   xTrue = ones(n,1);
   b = A*xTrue;
   format long
   [L,U,piv] = GEpiv(A);
   y = LTriSol(L,b(piv));
   x = UTriSol(U,y)
   format short
   relerr = norm(x - xTrue)/norm(xTrue);
   disp(sprintf('Relative error = %8.4e',relerr))
   bound = eps*cond(A);
   disp(sprintf('Predicted value = EPS*cond(A) = %8.4e',bound))
   input('Strike Any Key to Continue.');
end