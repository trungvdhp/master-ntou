function Kmat = Kernel(a,b,m,n,sigma)
%
%  Kmat(i,j) =
[omega,x] = wCompNC(a,b,m,n);
N = length(omega);
v = exp(-((x(1)-x).^2)/sigma);
Kmat = Toeplitz(v);
omega = (b-a)*omega;
for j=1:N
   Kmat(:,j) = Kmat(:,j)*omega(j);
end