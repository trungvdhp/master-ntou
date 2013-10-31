% Script File: SumOfSines2
% Plots the functions
%       f(x) = 2sin(x) + 3sin(2x) + 7sin(3x) + 5sin(4x)
%       g(x) = 8sin(x) + 2sin(2x) + 6sin(3x) + 9sin(4x)
% across the interval [-10,10].
close all
n = 200;
x = linspace(-10,10,n)';
A = [sin(x) sin(2*x) sin(3*x) sin(4*x)];
y = A*[2 8;3 2;7 6;5 9];
plot(x, y(:,1), x, y(:,2))
% plot(x, y)

%%%%%%%% Solving the 4-by-4 linear system. 

X=[1 2 3 4;2 4 6 8;3 6 9 12;4 8 12 16];
Z = sin(X);
f = [-2; 0; 1; 5];
alpha = Z\f