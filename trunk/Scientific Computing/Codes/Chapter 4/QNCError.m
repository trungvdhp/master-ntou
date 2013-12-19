
function error = QNCError(a,b,m,M) 

% error = QNCError(a,b,m,M)
% The error bound for the m-point Newton-Cotes rule when applied to 
% the integral from a to b of a function f(x). It is assumed that 
% a<=b and 2<=m<=11. M is an upper bound for the (d+1)-st derivative of the 
% function f (x) on [a,b] where d = m if m is odd, and m-1 if m is even.

if     m==2,  d=1;  c = -1/12;
elseif m==3,  d=3;  c = -1/90;
elseif m==4,  d=3;  c = -3/80;
elseif m==5,  d=5;  c = -8/945;
elseif m==6,  d=5;  c = -275/12096;
elseif m==7,  d=7;  c = -9/1400;
elseif m==8,  d=7;  c = -8183/518400;
elseif m==9,  d=9;  c = -2368/467775;
elseif m==10, d=9;  c = -173/14620;
else          d=11; c = -1346350/326918592;
end
error = abs( c*M*((b-a)/(m-1))^(d+2));