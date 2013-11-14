function c = InterpN(x,y)
n = length(x);
for k=1:n-1
    y(k+1:n) = (y(k+1:n) - y(k)) ./ (x(k+1:n) - x(k));
end
c=y;