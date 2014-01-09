  function [a,b] = pwL(x,y)
% [a,b] = pwL(x,y)
% 
% Generates the piecewise linear interpolant of the data specified by the
% column n-vectors x and y. It is assumed that x(1) < x(2) < ... < x(n).
%
% a and b are column (n-1)-vectors with the property that for i=1:n-1, the
% line L(z) = a(i) + b(i)z passes though the points (x(i),y(i)) and (x(i+1),y(i+1)).

n = length(x); 
a = y(1:n-1);
b = diff(y) ./ diff(x);