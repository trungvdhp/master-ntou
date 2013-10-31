function y = CosineTable(n)
% Plot y = cos(x) for x = [0, 2pi] by applying vectorization and symmetry.
% Display the results in a table.
% NOTE: (n-1) must be a multiple of 4.
m = (n-1)/4;
x = linspace(0,1,n);
a = x(1:m+1);
y = zeros(1, n);
y(1:m+1) = cos(2*pi*a);
y(2*m+1:-1:m+2) = -y(1:m);
y(n:-1:2*m+2) = y(1:2*m);
plot(x, y)
disp('-------------------------------')
disp(' k       x(k)        cos(x(k))')
disp('-------------------------------')
for k=1:n
   fprintf(' %-5.0d  %8.5f    %8.5f\n' ,k, x(k), y(k))
end
disp('-------------------------------')
disp('x(k) is given in degrees.')
fprintf ('One Degree = %5.4e Radians\n',pi/180)
disp('-------------------------------')
end