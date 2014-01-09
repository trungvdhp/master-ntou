  function error = NCOpenError(a,b,m,M)
% error = NCOpenError(a,b,m,M)
%
% The error bound for the m-point Newton Cotes rule when applied to
% the integral from a to b of a function f(x). It is assumed that
% a<=b and 1<=m<=7. M is an upper bound for the (d+1)-st derivative of the 
% function f(x) on [a,b] where d = m if m is odd, and m-1 if m is even. 

if     m==1,   d=1;  c = 1/3; 
elseif m==2,   d=1;  c = 1/4; 
elseif m==3,   d=3;  c = 28/90; 
elseif m==4,   d=3;  c = 95/144; 
elseif m==5,   d=5;  c = 41/140; 
elseif m==6,   d=5;  c = 5257/8640; 
else           d=7;  c = 3956/14175; 
end
h = (b-a)/(m+1);
error = c*M*h^(d+2);
