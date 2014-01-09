function LVals = MypwLEval(a,b,x,zvals)
% x is a column n-vector with x(1) < ... < x(n).
% zvals is a column m-vector with each component in [x(1),x(n)].
% a,b are column (n-1)-vectors
%
% LVals is a column m-vector with the property that 
%        LVals(j) = L(zvals(j)) for j=1:m where
% L(z) = a(i) + b(i)(z-x(i)) for x(i)<=z<=x(i+1).

m = length(zvals); 
LVals = zeros(m,1); 
g = 1;
for j=1:m
   i = MyLocate(x,zvals(j),g);
   LVals(j) = a(i) + b(i)*(zvals(j)-x(i));
   g = i;
end