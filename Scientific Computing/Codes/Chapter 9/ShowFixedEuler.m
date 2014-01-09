% Script File: ShowFixedEuler
% Plots the error in a fixed h euler solution to
% y' = -y, y(0) = 1,  on [0,5]

close all
tol=.01;
[tvals,yvals] = FixedEuler('f1',1,0,5,1,tol);
plot(tvals,exp(-tvals)-yvals)
title('Fixed h Euler Error for y''=-y, y(0) = 1')
xlabel(sprintf('tol = %5.3f,   n = %4.0f',tol,length(tvals)))