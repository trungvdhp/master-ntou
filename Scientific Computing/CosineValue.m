function y = CosineValue(n)
% Plot y = cos(x) for x = [0, 2pi] by applying vectorization and symmetry.
% Display the results in a table.
% NOTE: (n-1) must be a multiple of 4.
m = n/4;
x = linspace(0,1,n+1);
a = x(1:m+1);
y = zeros(1, n+1);
y(1:m+1) = cos(2*pi*a);
y(2*m+1:-1:m+2) = -y(1:m);
y(n+1:-1:2*m+2) = y(1:2*m);
end