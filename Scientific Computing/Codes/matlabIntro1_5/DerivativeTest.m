
% DerivativeTest
% Compute the derivative of sine function at x=a by Dh formula.

a = input('Enter a:  ');
h = logspace(-1, -16, 16);
Dh = (sin(a+h) - sin(a)) ./ h;
err = abs(Dh - cos(a));
disp('    h         Absolute Error   ')
disp('-------------------------------')
for k = 1:length(h),
    disp(sprintf(' %5.2e    %18.10e  ', h(k), err(k)))
end
% Compute the derivative by call the function "derivative.m"

[d,hopt,err] = Derivative(@sin, a); absErr = abs(d - cos(a))
disp('   Derivative         hopt      Estimate Error   Absolute Error')
disp(sprintf(' %15.10f   %10.4e   %12.4e    %14.4e ', d, hopt, err, absErr))