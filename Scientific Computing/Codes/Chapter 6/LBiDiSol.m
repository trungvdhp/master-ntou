  function x = LBiDiSol(l,b)
% x = LBiDiSol(l,b)
%
% Solves the n-by-n unit lower bidiagonal system  Lx = b
% where l and b are n-by-1 and L = I + diag(l(2:n),-1).

n = length(b); 
x = zeros(n,1);
x(1) = b(1);
for i=2:n
   x(i) = b(i) - l(i)*x(i-1);
end