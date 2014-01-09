function e = Energy(S)
% S is the pp representation of a spline
% e is the integral from x(1) to x(n) of the
%       square of  the second derivative of the spline
 
[x,rho,L,k] = unmkpp(S);

% The second derivative of the ith cubic is 2*rho(i,2) + 6*rho(i,1)(x-x(i)).
% The integral from x(i) to x(i+1) of [2*rho(i,2) + 6*rho(i,1)(x-x(i))]^2
% is 
%      4* rho(i,2)^2 * del + 12*rho(i,2)*rho(i,1)*del^2 + 12*rho(i,1)^2*del^3

del = (x(2:L+1)-x(1:L))';
r1 =  4*rho(:,2).^2;
r2 = 12*rho(:,2).*rho(:,1);
r3 = 12*rho(:,1).^2;
e = sum(((del.*r3 + r2).*del + r1).*del);