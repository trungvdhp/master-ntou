function x = TriCorner(d,e,f,alpha,beta,b)

% W is a tridiagonal matrix with d encoding the main diagonal, 
%     f encoding the super diagonal, and e encoding the subdiagonal.
%
% T = tridiagonal + corners.
% T = W+alpha*e_n*e_1'+beta*e_1*e_n', 
%     where e_1, e_n = first, last cols. of identity matrix.
%
% Goal:  Find x such that Tx = b.  Do this efficiently.
% Note:  x = z-Y*[1+Y(1,1) Y(1,2); Y(n,1) 1+Y(n,2)]^(-1)*[z1; zn]
%     where z = W^(-1)*b, Y = W^(-1)*[alpha*e_n beta*e_1].
%
%
% Solution:

% Initialization:
n = length(b);
e_1 = zeros(n,1); e_1(1) = 1;
e_n = zeros(n,1); e_n(n) = 1;

% Compute LU factorization of W:
[l,u] = TriDiLU(d,e,f);    % See p. 217 for TriDiLU.m.

% Solve Wz = b by noting LUz = b. 
% First step is to solve Ly=b.  Second step is to solve Uz=y.
% Note L = lower bidiagonal, U = upper bidiagonal, since W = tridiagonal.
y = LBiDiSol(l,b);   % See p.217 for LBiDiSol.m.
z = UBiDiSol(u,f,y);   % See p.218 for UBiDiSol.m.

% Solve for y1, y2 (columns of Y).  First we're solving Wy1 = alpha*e_n.
% Second we're solving Wy2 = beta*e_1.

% Use the same approach as above.  Repeat linear system solves twice.
t = LBiDiSol(l,alpha*e_n);
y1 = UBiDiSol(u,f,t);

t = LBiDiSol(l,beta*e_1);
y2 = UBiDiSol(u,f,t);

% Assemble Y.
Y = [y1 y2];

% Let V = [1+Y(1,1) Y(1,2); Y(n,1) 1+Y(n,2)]^(-1).
% Compute V efficiently.
% Compute determinant.
delta = 1/((1+Y(1,1))*(1+Y(n,2))-(Y(1,2))*(Y(n,1)));
V(1,1) = 1+Y(n,2);
V(1,2) = -Y(1,2);
V(2,1) = -Y(n,1);
V(2,2) = 1+Y(1,1);
V = delta*V;

% Let s = [z(1); z(n)].
s=[z(1); z(n)];

% Final computations.
x=z-Y*V*s;

% Check!
W = diag(e(2:n),-1) + diag(d) + diag(f(1:n-1),1);
T = W+alpha*e_n*e_1'+beta*e_1*e_n';
difference = norm(T*x-b);
disp(['The norm of the difference is ' num2str(difference) '.']);