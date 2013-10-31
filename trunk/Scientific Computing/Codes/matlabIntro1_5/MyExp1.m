
function y = MyExp1(x)

% y = MyExpl(x)
% x is a column vector and y is a column vector with the property that
% y(i) is a Taylor approximation to exp(x(i)) for i=1:n. 

n = 17; 
p = length(x);
y = ones(p,1);
for i=1:p
   y(i) = MyExpF(x(i), n);
end
y = y';