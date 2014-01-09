% Script File: ShowBVP
% Illustrates the numerical solution to 
%
%        -D^2 u + u(x) = 2xsin(x) - 2cos(x)    u(0) = u(pi) = 0.
% 
% Exact solution = u(x) = x*sin(x).

close all
n =  100;
x =  linspace(0,pi,n)';
hx = pi/(n-1);
d =  2*ones(n-2,1) + hx^2;
e = -ones(n-2,1);
[g,h] = CholTrid(d,e);
b = hx^2*( 2*x(2:n-1).*sin(x(2:n-1)) - 2*cos(x(2:n-1)));
umid  = CholTridSol(g,h,b);
u = [0;umid;0];
plot(x,u,x,x.*sin(x))
err = norm(u - x.*sin(x),'inf');
title('Solution to   -D^2 u + u = 2xsin(x) - 2cos(x), u(0)=u(pi)=0')
xlabel(sprintf(' n = %3.0f    norm(u - xsin(x),''inf'') = %10.6f',n,err))