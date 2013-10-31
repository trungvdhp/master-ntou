function y = Sine(n, p)
% Plot the function y = sin(x) for x = [-pi, pi] by using symmetry and Taylor polynomials.
% Display the results in a table.
% NOTE: (n-1) must be a multiple of 4 and (2*p+1) value is degree of Taylor polynomial.
m = (n-1)/4;
x = linspace(-1,1,n);
a = x(1:m+1)*pi;
y = zeros(1, n);
% Use Taylor polynomial to evaluate sin(x)
for k=0:p 
    y(1:m+1) = y(1:m+1) + ((-1)^k)*a.^(2*k+1)/factorial(2*k+1);
end
y(2*m+1:-1:m+2) = y(1:m);
y(n:-1:2*m+2) = -y(1:2*m);
plot(x, y)
disp('-------------------------------')
disp(' k       x(k)        sin(x(k))')
disp('-------------------------------')
for k=1:n
   fprintf(' %-5.0d  %8.5f    %8.5f\n' ,k, x(k), y(k))
end
disp('-------------------------------')
disp('x(k) is given in degrees.')
fprintf ('One Degree = %5.4e Radians\n',pi/180)
disp('-------------------------------')
end