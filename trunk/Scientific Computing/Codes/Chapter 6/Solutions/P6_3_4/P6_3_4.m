% Problem  P6_3_4
%
% Block back substitution, the 2-by-2 case.

clc 
n = 6;
A = randn(n,n);
B = randn(n,n);
C = randn(n,n);
g = randn(n,1);
h = randn(n,1);
[y,z] = BlockSolve(A,B,C,g,h);
xtilde = [y;z];
x = [A B; zeros(n,n) C]\[g;h];
disp('           BlockSolve            Standard Solve')
disp('---------------------------------------------------')
for k=1:2*n
   disp(sprintf(' %23.15f  %23.15f',xtilde(k),x(k)))
end