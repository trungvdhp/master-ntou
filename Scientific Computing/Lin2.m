function y=Lin2(n)
y1=0;
y2=0;
y = log(2);
for k=1:n
    y1 = y1 - ((-1)^k)/k;
    y2 = y2 + 1/(3^(2*k-1)*(2*k-1));  
end
y2 = y2*2;
fprintf('y%8c y1%8c y2\n', ' ', ' ')
fprintf('%.6f %.6f %.6f\n', y, y1, y2)
y = abs(y-y1) - abs(y-y2);
end