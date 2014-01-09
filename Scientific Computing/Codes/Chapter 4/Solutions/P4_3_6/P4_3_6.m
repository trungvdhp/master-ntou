% Script P4_3_6
% (a) Solution:
% 
% 1.  I = Q_n+Ch^2;  (by assumption)
% 
% 2.  So, I = Q_2n+Ch^2/4, which can be seen as follows.
%     
%  Error composite rule = error simple rule/(r^(d+1)), where
%    r = ratio of points adding in, i.e., r=(2*n)/n=2,
%    d = m-1 (if m is even), m (if m is odd),
%    m = 2 for the trapezoid rule, so d=1.
%  So, r^(d+1)=2^(1+1)=4.
% 
% 3.  Subtracting 2 from 1 yields: abs(Q_n-Q_2n) = 3/4*Ch^2.
% 
% 4.  Solving 3 for Ch^2 yields Ch^2 = 4/3*abs(Q_n-Q_2n).
% 
% 5.  Therefore, abs(I-Q_2n) = Ch^2/4 (from 2)
%                            = 4/3*abs(Q_n-Q_2n)*1/4   (from 4)
%                            = 1/3*abs(Q_n-Q_2n) (simplifying).                                                
% This script computes Q_2^(k+1) efficiently, where k is the
% smallest positive integer so that abs(I-Q_(2^(k+1))) < = tol.

% Establish some values for testing purposes.

a = 0;          % left endpoint.
b = 2*pi;       % right endpoint.
f = 'sin';      % function name.
tol = 10^(-3);  % tolerance. 

n=1;  % number of points.

% Note:  This script assumes the existence of a trapezoid function that 
% can integrate a function f from a to b using the composite trapezoid
% rule.

% Compute Q_n and Q_2n initially.
Q_n = trapezoid(f,a,b,n);
Q_2n = trapezoid(f,a,b,2*n);

n=2;
while(1/2*abs(Q_n-Q_2n) > tol)  % while abs(I-Q_2n) > tol
   n = 2*n;
   Q_n = Q_2n;  % Take advantage of powers of 2 to avoid an extra trapezoid call.
   Q_2n = trapezoid(f,a,b,n);  
end; 