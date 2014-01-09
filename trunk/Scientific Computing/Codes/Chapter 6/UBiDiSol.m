  function x = UBiDiSol(u,f,b)
% x = UBiDiSol(u,f,b) 
%
% Solves the n-by-n nonsingular upper bidiagonal system  Ux = b
% where u, f, and b are n-by-1 and U = diag(u) + diag(f(1:n-1),1).

n = length(b); 
x = zeros(n,1);
x(n) = b(n)/u(n);
for i=n-1:-1:1
   x(i) = (b(i) - f(i)*x(i+1))/u(i);
end