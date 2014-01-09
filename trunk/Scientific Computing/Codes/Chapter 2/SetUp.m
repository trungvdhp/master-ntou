  function fA = SetUp(fname,a,b,n,c,d,m)
% fA = SetUp(fname,a,b,n,c,d,m)
% Sets up a matrix of f(x,y) evaluations.
% fname is a string that names a function of the form f(x,y).
% a, b, c, and d  are scalars that satisfy a<=b and c<=d.
% n and m are integers >=2.
% fA is an n-by-m matrix with the property that
%
%     A(i,j) = f(a+(i-1)(b-a)/(n-1),c+(j-1)(d-c)/(m-1)) , i=1:n, j=1:m

x = linspace(a,b,n);
y = linspace(c,d,m);
fA = zeros(n,m);
for i=1:n
   for j=1:m
      fA(i,j) = feval(fname,x(i),y(j));
   end
end