function LVals = pwLEval(a,b,x,zVals)
m = length(zVals);
LVals = zeros(m,1);
g = 1;
for j=1:m
    i = Locate(x,zVals(j),g);
    LVals(j) = a(i) + b(i)*(zVals(j) - x(i));
    g = i;
end