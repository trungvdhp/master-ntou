n = 5
A = magic(n)
b = [2 3 4 5 6]'
[L, U] = GE(A);
y = LTriSol(L,b);
x = UTriSol(U,y);
