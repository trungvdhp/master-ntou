function [R,fR] = stretch(L,fL,tol);
% L,fL are scalars that satisfy fL = exp(-L) 
% tol is a positive real.
%
% R,fR are scalars that satisfy fR = exp(-R) with the
%     property that if  q(z) is the cubic hermite interpolant
%     of exp(-z) at z=L and z=R, then |q(z) - exp(-z)| <= tol on [L,R].

h = sqrt(sqrt((384*tol/fL)));
R = L + h;
fR = exp(-R);