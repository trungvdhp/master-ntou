% matlabIntro1_2.m 
% Introduction to Matlab software 
% 1. How to create a matrix A
% 2. Operations in a matrix
% 3. Finding the roots of a function
% 4. The multiplication and division of polynomials

 % Create a matrix A
 >> A = [1 2 3 4; 4 5 6 7; 7 8 9 1]
 >> A(1,2), A(3,3), 
 A(1:3,2:4), 
 A([1,3],[2,4])
 >> B = A(1:3,1:3)
 >> diag(A), tril(A), triu(A)
 >> diag(A,0), tril(A,0), triu(A,0)
 >> diag(A,1), tril(A,1), triu(A,1)
 >> diag(A,-1), tril(A,-1), triu(A,-1)
 
  % Create a zero, identity, or magic matrix of mxn
  m = 5; n = 4; 
  A = zeros(m, n)
  A = ones(m, n)
  I = eye(n)
  A = magic(n)
  
% Concatenate (連接(鎖);把...連成一串(個)) matrices Horizontally and Vertically
  A=[1 2 3 4; 2 3 4 5]
  B=[1 3 5; 3 6 9]
  c=[A B]
  D=[1 -3 5 -7; -2 4 -6 8]
  E=[A; D]
% Replicate matrices
  A = [8 1 6; 3 5 7; 4 9 2]
  B = repmat(A, 2, 4)
% Create a block diagonal matrix 
A = magic(3);
B = [-5 -6 -9; -4 -4 -2];
C = eye(2) * 8;
D = blkdiag(A, B, C)
% Using the colon operator (:) to generate a numeric sequence
A = 10:15
A = -2.5:2.5
A = 1:6.3
A = 9:1
A = 10:5:50
A = 3:0.2:3.8
A = 9:-1:1

% Empty Matrices
A = [5.36; 7.01; []; 9.44]
A = rand(5) * 10;
A(4:5, :) = []

%  Two ways to find the roots of a function
  roots([Coefficients of a polynomial])     % for polynomials    
  % Note: Coefficients of a polynomial with descending degree
% Find a root near the point a (Newton's method)
  fzero('function', a)   %% for any function  
  
% Ex.1： find the roots of the equation x^4-12x^3+25x+116 = 0
>> roots([1 -12 0 25 116])
% Ex.2： find a root of the equation x^2-2*exp(x) = 0 near 2 (with x_0 = 2 or -1 ).
>> fzero('x^2-2*exp(x)',2)

% Exercises
% 1. find the roots of x^5-2*x^4+15*x^2-14*x+2 = 0
% 2. find a root of the equation x^2-x*sin(2x) = 0 with x_0 = 2 or -1.

% The multiplication and division of polynomials
% Comands:  conv (convolution 捲積) and deconv (de-convolution 反捲積--division) 
conv([a], [b]) 
[q,r] = deconv([a], [b]) 
Find the multiplication of (2x^3+5x^2+12x+7)(x^2-3x-6)
conv([2 5 12 7],[1 -3 -6])
Find the division (x^5-3x^4-5x^3-19x^2-43x+25)/(x^2-2x+1)
[q r]=deconv([1 -3 -5 -19 -43 25],[1 -2 1])

