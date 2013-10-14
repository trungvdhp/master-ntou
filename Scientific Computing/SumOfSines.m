% Script File: SumOfSines
% Plot the graph of f (x) = 2sin(x) + 3sin(2x) + 7sin(3x) + 5sin(4x)
% across the interval [-10,10].
% NOTE: Four ways to compute the values of f(x).

close all

%1.  The scalar-level script 
% Notice that x and y are column vectors
n = 200; 
x = linspace(-10, 10, n)';
y = zeros(n, 1);
for k = 1:n
  y(k) = 2*sin(x(k)) + 3*sin(2*x(k)) + 7*sin(3*x(k)) + 5*sin(4*x(k));
end
figure
plot(x, y)
title('f(x) = 2sin(x) + 3sin(2x) + 7sin(3x)  + 5sin(4x)')

%%%%% 2.  The vector-level script %%%%%%%%%

x = linspace(-10, 10, n)';
y = 2*sin(x) + 3*sin(2*x) + 7*sin(3*x) + 5*sin(4*x);
figure
plot(x, y)
title('f(x) = 2sin(x) + 3sin(2x) + 7sin(3x)  + 5sin(4x)')

%%%%% 3.  Matrix-level script:  %%%%%%%%%
% A linear combination of vectors is equivalent to matrix-vector
% multiplication.
% 1. Typing all entries to creat matrix A
A = [3 5 8 1; 1 0 3 6; 4 3 3 8; 7 8 1 7; 2 4 1 0; 8 2 1 9]
y = A*[2; 3; 7; 5];


%%%%%  Using two for-loops to create a matrix. %%%%%
n = 200; m = 4;
x = linspace(-10, 10, n)';
A = zeros(n, m);
for j = 1:m
    for k = 1:n
        A(k, j) = sin(j*x(k));
    end
end
y = A*[2; 3; 7; 5];
figure
plot(x,y)
title('f(x) = 2sin(x) + 3sin(2x) + 7sin(3x)  + 5sin(4x)')

%%%%%  Aggregating its columns. %%%%%%%%%%%%%%%%%
x = linspace(-10, 10, n)';
A = [sin(x) sin(2*x) sin(3*x) sin(4*x)];
y = A*[2;3;7;5];
figure
plot(x, y)
title('f(x) = 2sin(x) + 3sin(2x) + 7sin(3x)  + 5sin(4x)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Initialize A using a single loop whereby each pass sets up a single column.
n = 200; m = 4;
x = linspace(-10, 10, n)';
A = zeros(n, m);
for j = 1:m
  A(:, j) = sin(j*x);
end
y = A*[2;3;7;5];
figure
plot(x, y)
title('f(x) = 2sin(x) + 3sin(2x) + 7sin(3x)  + 5sin(4x)')