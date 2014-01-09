% Script: ShowMatlabLU
% Illustrates the Matlab LU, cond, and condest functions.

A = Pascal(5);
[L,U,P] = lu(A)
A0 = P'*L*U  
[L,U] = lu(A)
A0 = L*U

A = Pascal(10);
condA = cond(A)
condEstA = condeSt(A)
