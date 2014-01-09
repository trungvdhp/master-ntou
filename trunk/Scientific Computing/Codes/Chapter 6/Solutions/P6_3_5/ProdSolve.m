function x = ProdSolve(A,B,C,f)
% x = ProdSolve(A,B,C,f)
%
% A,B,C are n-by-n nonsingular matrices
% f is a column n-vector
%
% x is a columnn-vector so ABCx = f
%
[LA,UA,pivA] = GEpiv(A);
yA = Ltrisol(LA,f(pivA));
xA = UtriSol(UA,yA);
[LB,UB,pivB] = GEpiv(B);
yB = Ltrisol(LA,xA(pivB));
xB = UtriSol(UA,yB);
[LC,UC,pivC] = GEpiv(C);
yC = Ltrisol(LA,xB(pivC));
x  = UtriSol(UC,yC);