function y = f(x, d)
y = exp(-(d - (1 - x)./x).^2 / 2)./(sqrt(2*pi)*x.^2);