% Script File: ShowSplineTools
% Illustrates the Matlab functions spline, ppval, mkpp, unmkpp

close all

% Set Up Data:
n = 9;
x = linspace(-5,5,n);
y = atan(x);

%   Compute the spline interpolant and its derivative:
S  = spline(x,y);	
[x,rho,L,k] = unmkpp(S);
drho = [3*rho(:,1) 2*rho(:,2) rho(:,3)];
dS = mkpp(x,drho);
 
%   Evaluate S and dS:
z = linspace(-5,5);
Svals = ppval(S,z);
dSvals = ppval(dS,z);

%   Plot: 
atanvals = atan(z);	
figure
plot(z,atanvals,z,Svals,x,y,'*');
title(sprintf('n = %2.0f Spline Interpolant of atan(x)',n))
	
datanvals = ones(size(z))./(1 + z.*z);
figure
plot(z,datanvals,z,dSvals)
title(sprintf('Derivative of n = %2.0f Spline Interpolant of atan(x)',n))
