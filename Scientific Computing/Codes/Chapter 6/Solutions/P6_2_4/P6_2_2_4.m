% Clear command window to start.
clc;

% Create W.
d=[1 2 3 4 5 6];
e=[3 5 0 5 0 5];
f=[2 7 2 7 2 8];

% Create b.
b=[7 7 7 7 7 7]';

% Create alpha, beta.
alpha = 2;
beta = 3;

% Solve Tx=b, where T = W+alpha*e_n*e_1'+beta*e_1*e_n';
x = TriCorner(d,e,f,alpha,beta,b);