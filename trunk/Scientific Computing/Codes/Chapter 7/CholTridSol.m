  function x = CholTridSol(g,h,b)
% x = CholTridSol(g,h,b)
% Solves the linear system G*G'x = b where b is a column n-vector and 
% G is a nonsingular lower bidiagonal matrix. g and h are column n-vectors
% with G = diag(g) + diag(h(2:n),-1).

n = length(g);
y = zeros(n,1);

% Solve Gy = b
y(1) = b(1)/g(1);
for k=2:n
   y(k) = (b(k) - h(k)*y(k-1))/g(k);
end

% Solve G'x = y
x = zeros(n,1);
x(n) = y(n)/g(n);
for k=n-1:-1:1
   x(k) = (y(k) - h(k+1)*x(k+1))/g(k);
end