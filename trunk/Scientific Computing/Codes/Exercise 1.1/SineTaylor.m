function y = SineTaylor(x, n)
% Date: 11/3/2013, Justin
tn=x;
y=tn;
a=x*x;
for k=1:n
    tn = -tn*a/(2*k*(2*k+1));
    y = y + tn;
end
end

