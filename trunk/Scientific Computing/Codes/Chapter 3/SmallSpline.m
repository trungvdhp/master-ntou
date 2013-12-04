 function [a,b,c,d] = SmallSpline(z,y)
% z is a scalar and y is 3-vector
% a,b,c,d are column 2-vectors with the property that if
%
%     S(x) = a(1) + b(1)(x-z) + c(1)(x-z)^2 + d(1)(x-z)^3  on [z-1,z] 
% and
%     S(x) = a(2) + b(2)(x-z) + c(2)(x-z)^2 + d(2)(x-z)^3  on [z,z+] 
% then 
%     (a) S(z-1) = y(1), S(z) = y(2), S(z+1) = y(3), 
%         S(z-1) = a(1) - b(1) + c(1) - d(1)
%         S(z)   = a(1) + 0    + 0    + 0
%         S(z+1) = a(2) + b(2) + c(2) + d(2)
%     (b) S''(z-1) = S''(z+1) = 0
%         S'(x)   = 0 + b(1) + 2c(1)(x-z) + 3d(1)(x-z)^2
%         S''(x)   = 0 + 0 + 2c(1) + 6d(1)(x-z)
%         S''(z-1) = 0 + 0 + 2c(1) - 6d(1)
%         S''(z+1) = 0 + 0 + 2c(2) + 6d(2)
%     (c) S, S', and S'' are continuous on [z-1,z+1] 
%         => must be continuous on x = z

S = zeros(8,1);
% S(z-1) = y(1)
T = [ 1 -1 1 -1 0 0 0 0 ];
S(1) = y(1);

% S(z) = y(2)
T = [T ; 1 0 0 0 0 0 0 0];
S(2) = y(2);

% S(z+1) = y(3)
T = [T; 0 0 0 0 1 1 1 1];
S(3) = y(3);

% S''(z-1) = 0
T = [T; 0 0 2 -6 0 0 0 0];
S(4) = 0;

% S''(z+1) = 0
T = [T; 0 0 0 0 0 0 2 6];
S(5) = 0;

% S continuous at x = z, S1(z) = S2(z) => a(1) = a(2) or a(1) - a(2) = 0
T = [T; 1 0 0 0  -1 0 0 0 ];
S(6) = 0;

% S' continuous at x = z, S1'(z) = S2'(z) => b(1) = b(2) or b(1) - b(2) = 0
T = [T; 0 1 0 0  0  -1  0 0 ];
S(7) = 0;

% S'' continuous at x = z, S1''(z) = S2''(z) => c(1) = c(2) or c(1) - c(2) = 0
T = [T; 0 0 1 0  0  0  -1 0 ];
S(8) = 0;

% u = [a(1) b(1) c(1) d(1) a(2) b(2) c(2) d(2)]
u = T\S;
a = u([1 5]);
b = u([2 6]);
c = u([3 7]);
d = u([4 8]);