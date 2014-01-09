function [a,b,c,d] = SmallSpline(y)

% y is 3-vector.
%

% a,b,c,d are column 2-vectors with the property that if
%
%     S(x) = a(1) + b(1)x + c(1)x^2 + d(1)x^3  on [-1,0] 
% and
%     S(x) = a(2) + b(2)x + c(2)x^2 + d(2)x^3  on [0,1] 
% then 
%     (a) S(-1) = y(1), S(0) = y(2), S(1) = y(3), 
%     (b) S''(-1) = S''(1) = 0
%     (c) S, S', and S'' are continuous on [-1,1]
%  

rhs = zeros(8,1);

% S(-1) = y(1)
M = [ 1 -1 1 -1 0 0 0 0 ];
rhs(1) = y(1);
% S(0) = y(2)
M = [M ; 1 0 0 0 0 0 0 0];
rhs(2) = y(2);
% S(1) = y(3)
M = [M; 0 0 0 0 1 1 1 1];
rhs(3) = y(3);
% S''(-1) = 0
M = [M; 0 0 2 -6 0 0 0 0];
rhs(4) = 0;

% S''(1) = 0
M = [M; 0 0 0 0 0 0 2 6];
rhs(5) = 0;

% S continuous at x = 0
M = [M; 1 0 0 0  -1 0 0 0 ];
rhs(6) = 0;

% S' continuous at x = 0
M = [M; 0 1 0 0  0  -1  0 0 ];
rhs(7) = 0;

% S'' continuous at x = 0
M = [M; 0 0 1 0  0  0  -1 0 ];
rhs(8) = 0;
u = M\rhs;
a = u([1 5]);
b = u([2 6]);
c = u([3 7]);
d = u([4 8]);