function y = Cosine(n)
m = (n-1)/4;
x = linspace(0,1,n);
a = x(1:m+1);
y = zeros(1, n);
y(1:m+1) = cos(2*pi*a);
y(2*m+1:-1:m+2) = -y(1:m);
y(n:-1:2*m+2) = y(1:2*m);
plot(x, y)
end