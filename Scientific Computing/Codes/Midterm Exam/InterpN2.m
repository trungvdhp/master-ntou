function c = InterpN2(x,y)
n = length(x);
for k=1:n-1
    y(k+1:n) = (y(k+1:n) - y(k:n-1)) ./ (x(k+1:n) - x(1:n-k));
end
c=y;