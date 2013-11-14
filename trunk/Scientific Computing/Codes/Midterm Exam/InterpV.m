function a = InterpV(x,y)
n = length(x);
V = ones(n,n);
for j=2:n
    V(:,j) = x.*V(:,j-1);
end
a = V\y;