% Problem P4_4_3
%
% Test generalized SplineQ

clc 
disp('Test on integral of x^3 - 3x^2 + 4x - 20 from a to b with spline')
disp('based on linspace(0,5,6).')
disp(' ')
disp(' ')
disp('  a     b     SplineQ1      Exact')
disp('-----------------------------------')
x = linspace(0,5,6)';
y = x.^3 - 3*x.^2 + 4*x - 20;
a = 0;
b = 5;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 1.5;
b = 5;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 1.5;
b = 3.5;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 2.3;
b = 2.6;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 5;
b = 5;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 3;
b = 4;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 0;
b = .3;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 0;
b = 0;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))
a = 2;
b = 2;
numI = SplineQ1(x,y,a,b);
exact = (b^4/4 - b^3 + 2*b^2 -20*b ) - (a^4/4 - a^3 + 2*a^2 -20*a );
disp(sprintf('%4.2f  %4.2f  %10.6f  %10.6f',a,b,numI,exact))