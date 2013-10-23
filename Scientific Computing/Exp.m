function y= Exp(n)
% max n = 341
x1=1/2;
x2=8;
y1=1;
y2=1;
for k=1:n
    y1 = y1 + x1^k/factorial(k);
    y2 = y2 + x2^k/factorial(k);
end
fprintf('e^(1/2) = %.8f\ny1      = %.8f\n', exp(1/2), y1)
fprintf('e^8 = %.8f\ny2  = %.8f\n', exp(8), y2)
y = abs(exp(1/2)-y1) - abs(exp(8)-y2);
end