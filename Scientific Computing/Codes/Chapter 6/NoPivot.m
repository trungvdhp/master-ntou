% Script File: NoPivot
% Examines solution to
%
%        [ delta 1 ; 1 1][x1;x2] = [1+delta;2]
%
% for a sequence of diminishing delta values.

clc
disp(' Delta            x(1)                   x(2)  ' )
disp('-----------------------------------------------------')
for delta = logspace(-2,-18,9)
   A = [delta 1; 1 1];
   b = [1+delta; 2];
   L = [ 1 0; A(2,1)/A(1,1) 1];
   U = [ A(1,1) A(1,2) ; 0 A(2,2)-L(2,1)*A(1,2)];
   y(1) = b(1);
   y(2) = b(2) - L(2,1)*y(1);
   x(2) = y(2)/U(2,2);
   x(1) = (y(1) - U(1,2)*x(2))/U(1,1);
   disp(sprintf(' %5.0e   %20.15f  %20.15f',delta,x(1),x(2)))
end