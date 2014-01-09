function GE2(A)
% GE2(A)
% 
% Displays the results of 2-by-2 Gaussian elimination when it is applied to
% the linear system Ax = [A(1,1)-A(1,2);A(2,1)-A(2,2)] using 3-digit arithmetic.

clc
condA = cond(A);
a11 = represent(A(1,1));
a12 = represent(A(1,2));
a21 = represent(A(2,1));
a22 = represent(A(2,2));
b1 = float(a11,a12,'-');
b2 = float(a21,a22,'-');
disp(['Stored A =   ' pretty(a11)  '   ' pretty(a12) ])
disp(['             ' pretty(a21)  '   ' pretty(a22) ])
L11 = represent(1);
L12 = represent(0);
L21 = float(a21,a11,'/');
L22 = represent(1);
disp(' ');  
disp(['Computed L = ' pretty(L11)  '   ' pretty(L12)])
disp(['             ' pretty(L21)  '   ' pretty(L22)])
U11 = a11;
U12 = a12;
U21 = represent(0);
U22 = float(a22,float(L21,a12,'*'),'-');
disp(' '); 
disp(['Computed U = ' pretty(U11)  '   ' pretty(U12)])
disp(['             ' pretty(U21)  '   ' pretty(U22)])
y1 = b1;
y2 = float(b2,float(L21,y1,'*'),'-');
x2 = float(y2,U22,'/');
x1 = float(float(y1,float(U12,x2,'*'),'-'),U11,'/');
xe1 = represent(1);
xe2 = represent(-1);
disp(' ');
disp(['Exact b           =  '  pretty(b1) ])
disp(['                     '   pretty(b2)  ])
disp(' '); 
disp(['Exact Solution    =  '  pretty(xe1) ])
disp(['                    '   pretty(xe2)  ])
disp(' '); 
disp(['Computed Solution =  ' pretty(x1)])
disp(['                    '  pretty(x2)])
disp(sprintf('\ncond(A) = %5.3e',condA))
xtilde = [convert(x1);convert(x2)];
x = [1;-1];
b = A*x;
r = A*xtilde-b;
E = -r*xtilde'/(xtilde'*xtilde);
disp(' ');
disp('Computed solution solves (A+E)*x = b where')
disp(sprintf('\n                   E =  %12.6f %12.6f',E(1,1),E(1,2)));
disp(sprintf('                        %12.6f %12.6f',E(2,1),E(2,2)));
disp(' ')