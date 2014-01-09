% Script File: ShowNCIdea
% Illustrates the idea behind the Newton-Cotes approach
% to quadrature.

close all

% Generate a function and its interpolant.
x = linspace(0,2);
y = exp(-x).*sin(2*pi*x);
x0 = linspace(0,2,8);
y0 = exp(-x0).*sin(2*pi*x0);
c = InterpN(x0,y0);
pvals = HornerN(c,x0,x);

% Plot the function.
subplot(2,2,1)
plot(x,y,x,zeros(1,100),'.')
title('f(x)');
axis([0 2 -.5 1])

% Plot the interpolant.
subplot(2,2,2)
plot(x,y,x,pvals,x0,y0,'*',x,zeros(1,100),'.')
title('The Interpolant');
axis([0 2 -.5 1])

% Display the integral of the function.
subplot(2,2,3)
plot(x,y)
fill(x,y,[.5 .5 .5])
title('Integral of f(x)');
axis([0 2 -.5 1])

% Display the integral of the interpolant
subplot(2,2,4)
plot(x,pvals)
fill(x,pvals,[.5 .5 .5])
title('Integral of Interpolant');
axis([0 2 -.5 1])