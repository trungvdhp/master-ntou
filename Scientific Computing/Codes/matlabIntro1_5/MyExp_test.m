% MyExpTest

x = linspace(-2,2,50);
exact = exp(x);
 y = MyExp1(x);
% y = MyExp2(x); 
RelErr = abs(exact - y)./ exact;
for k=1:length(x),
   disp(sprintf('%7.4f   %8.6f   %8.4e ', x(k), y(k)', RelErr(k)'))
end