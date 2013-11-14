function pVal = HornerV(a,z)
n = length(a);
pVal = a(n)*ones(size(z));
for k=n-1:-1:1
    pVal = z.*pVal + a(k);
end