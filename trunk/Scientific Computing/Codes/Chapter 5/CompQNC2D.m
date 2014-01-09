  function numI2D = CompQNC2D(fname,a,b,c,d,mx,nx,my,ny)
% numI2D = CompQNC2D(fname,a,b,c,d,mx,nx,my,ny)
% 
% fname is a string that names a function of the form f(x,y).
% If x and y are vectors, then it should return a matrix F with the 
% property that F(i,j) = f(x(i),y(j)), i=1:length(x), j=1:length(y).
%
% a,b,c,d are real scalars.
% mx and my are integers that satisfy 2<=mx<=11, 2<=my<=11.
% nx and ny are positive integers
%
% numI2D  approximation to the integral of f(x,y) over the rectangle [a,b]x[c,d]. 
% The compQNC(mx,nx) rule is used in the x-direction and the compQNC(my,ny)
% rule is used in the y-direction.

[omega,x] = wCompNC(a,b,mx,nx);
[mu,y]    = wCompNC(c,d,my,ny); 
F = feval(fname,x,y);
numI2D = (b-a)*(d-c)*(omega'*F*mu);