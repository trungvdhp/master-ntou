% Script File: ErrChol
% Error when solving a Hilbert Matrix System.

clc
disp('  n     cond(A)       relerr ')
disp('----------------------------------')
for n = 2:12
   A = hilb(n);
   b = randn(n,1);
   G = CholScalar(A);
   y = LTriSol(G,b);
   x = UTriSol(G',y);
   condA = cond(A);
   xTrue = invhilb(n)*b;
   relerr = norm(x-xTrue)/norm(xTrue);
   disp(sprintf(' %2.0f   %10.3e    %10.3e  ',n,condA,relerr))
end