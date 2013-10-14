
function y = SineValue(n)

% Evaluate sin(x) by using symmetry.
% NOTE: n must be a multiple of 4.
m = n/4; n = n+1;
x = linspace(0,1,n); 
a = x(1:m+1);
y = zeros(1,n);
y(1:m+1) = sin(2*pi*a);
y(2*m+1:-1:m+2) = y(1:m);   % or use y3(m+2:2*m+1) = y3(m:-1:1);
y(2*m+2:n) = -y(2:2*m+1);
