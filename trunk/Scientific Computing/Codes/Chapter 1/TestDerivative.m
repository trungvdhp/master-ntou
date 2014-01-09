% Script File: TestDerivative
% Numerical differentiation of f(x) = sin(10x)

close all
a = 10;
M2=100; 

% Look at errors across [0,1]. 
% err1 = error with no derivative information.
% err2 = error with 2nd derivative information.
m = 100;
x=linspace(0,1,m);
for i=1:m
   exactDer = a*cos(a*x(i));
   err1(i) = abs(exactDer - Derivative('sin10',x(i)));
   err2(i) = abs(exactDer - Derivative('sin10',x(i),eps,M2));     
end

% Plot err1(1:m)
figure
plot(x,err1);
title('Derivative(''sin10'',a)')
xlabel('a')
ylabel('Der Error')
    
% Plot err2(1:m)
figure
plot(x,err2);
title('Derivative(''sin10'',a,eps,100)')
xlabel('a')
ylabel('Der Error')
