function C = Krylov(A,B,p)
% A is n-by-n, B is n-by-t, and p is a positive integer.
% C = [ B AB (A^2)B ... (A^p-1))B]

C = B; 
C1 = B;
for k=1:p-1
   C1 = A*C1;
   C = [ C C1];
end