function t = Intersect1(P,Q,R,S)
% t = Intersect(P,Q,R,S)
%
% P, Q, R, and S are column 3-vectors. 
% t is a scalar so that P + t*Q is a linear combination
% or R and S.

% This means P + t*Q = x(1)*R + x(2)*S for some pair of scalars
% x(1) and x(2). In other words,
%
%          P = [R S -Q]*[x(1);x(2);t]

A = [R S -Q]
x = A\P;
t = x(3);