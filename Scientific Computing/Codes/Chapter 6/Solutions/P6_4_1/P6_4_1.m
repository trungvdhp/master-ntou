% Problem P6_4_1
%
% Explore relative error in computed x.

clc 

del = .0000002;
A = [ 981 726 ; 529 del+726*529/981]
disp(sprintf('cond(A) = %10.3e',cond(A)))
disp(' ')
xexact = [ 1.234567890123456; .0000123456789012];
b = A*xexact;
x = A\b;
disp(sprintf('xexact = %20.16f  %20.16f',xexact))
disp(sprintf('x      = %20.16f  %20.16f',x))
