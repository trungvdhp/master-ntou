function pVal = HornerN(c,x,z)
n = length(c);
pVal = c(n)*ones(size(z));
for k=n-1:-1:1
    pVal = (z-x(k)).*pVal + c(k);
end