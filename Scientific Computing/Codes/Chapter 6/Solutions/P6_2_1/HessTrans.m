function x = HessTrans(A,b)
% x = HessTrans(A,b)
%
% A is an n-by-n upper Hessenberg matrix.
% b iS an n-by-1 vector.
% 
% x   solves A'*x = b. 

n = length(b); 
[v,U] = HessLU(A);
% (U'L')x = b
y = LTriSol(U',b);
x = UBidiSol(ones(n,1),v(2:n),y);