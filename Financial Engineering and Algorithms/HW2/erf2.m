function y = erf2(x, n)
x2 = x*x;
k = -x*x2/3;
y = x + k;

for i=1:n
    k = -k * x2 * (2*i + 1)/ (2*i + 3);
    y = y + k;
end
y = 2*y / sqrt(pi);

end