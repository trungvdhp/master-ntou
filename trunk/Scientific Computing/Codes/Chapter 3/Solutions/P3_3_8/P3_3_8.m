% Problem P3_3_8
%
% Different representations for piecewise cubics.

x = [0 .1 .3 .5 .6 1]';
y = sin(2*pi*x);



% Generate not-a-knot spline 2 ways:
[a,b,c,d] = CubicSpline(x,y);
S1 = Spline(x,y);
[x1,rho1,L1,k1] = unmkpp(S1);

% Convertthe book spline tothe pp representation and compare
% with S1.
S2 = ConvertS(a,b,c,d,x);  
[x2,rho2,L2,k2] = unmkpp(S2);

x_error = x1-x2
rho_error = rho1-rho2
L_error = L1-L2
k_error = k1-k2