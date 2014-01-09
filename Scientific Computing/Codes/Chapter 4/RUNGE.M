function y = runge(x)
y = ones(size(x))./(ones(size(x)) + 25*(x.*x));