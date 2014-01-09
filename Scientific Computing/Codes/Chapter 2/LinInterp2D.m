  function z = LinInterp2D(xc,yc,a,b,c,d,fA)
% z = LinInterp2D(xc,yc,a,b,n,c,d,m,fA) 
% Linear interpolation on a grid of f(x,y) evaluations.
% xc, yc, a, b, c, and d  are scalars that satisfy a<=xc<=b and c<=yc<=d.
% fA is an n-by-m matrix with the property that
%
%     A(i,j) = f(a+(i-1)(b-a)/(n-1),c+(j-1)(d-c)/(m-1)) , i=1:n, j=1:m
%
% z is a linearly interpolated value of f(xc,yc).

[n,m] = size(fA);
% xc  = a+(i-1+dx)*hx    0<=dx<=1
hx = (b-a)/(n-1); i  = max([1 ceil((xc-a)/hx)]); dx = (xc - (a+(i-1)*hx))/hx;
% yc  = c+(j-1+dy)*hy    0<=dy<=1
hy = (d-c)/(m-1); j  = max([1 ceil((yc-c)/hy)]); dy = (yc - (c+(j-1)*hy))/hy;
z = (1-dy)*((1-dx)*fA(i,j)+dx*fA(i+1,j)) + dy*((1-dx)*fA(i,j+1)+dx*fA(i+1,j+1));
