  function F = SampleF(x,y)
% x is a column n-vector, y is a column m-vector and
% F  is an m-by-n matrix with F(i,j) = exp(-(x(j)^2 + 3y(i)^2)).

n = length(x);
m = length(y);
A = -((2*y.^2)*ones(1,n) + ones(m,1)*(x.^2)')/4;  
F = exp(A);