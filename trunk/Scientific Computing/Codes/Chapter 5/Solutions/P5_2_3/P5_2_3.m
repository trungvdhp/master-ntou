% Script P5_2_3
%
% Saxpy matrix multiply with one factor triangular.

clc 
disp('Example where B has more columns than rows:')
A = rand(4,4)
B = triu(rand(4,6))
C = MatMatSax1(A,B)
Cexact = A*B

disp(' ')
disp('Example where B has more rows than columns:')
A = rand(6,6)
B = triu(rand(6,4))
C = MatMatSax1(A,B)
Cexact = A*B