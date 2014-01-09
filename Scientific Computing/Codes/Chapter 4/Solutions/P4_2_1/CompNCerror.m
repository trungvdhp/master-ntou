function error = CompNCerror(a,b,m,DerBound,n)
% a,b are real scalars
% m are positive integer with 2<=m<=11 
% DerBound is a positive real
% n is apositive integer
%
% error is an upper bound for the error when the composite
% NC(m) rule is applied to integral of f(x) from a to b. 
% Assumes that the d+1st derivative of f is bounded by DerBound 
% where d = m-1 if m is even and d = m if m is odd.

if 2*floor(m/2)==m
   d = m-1;
else
   d = m;
end

error = NCerror(a,b,m,DerBound)/n^(d+1);