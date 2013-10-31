% sinCompt.m   
% To compute the values of sin(x) on [0, 2*pi] by three ways.

% 1. The basic way is to use for-loop
n = 21;
x = linspace(0,1,n);
y1=zeros(1,n);
for k=1:n, y1(k) =sin(2*pi*x(k)); end

% 2. The vector form: create a vector to replace a loop
n = 21;
x = linspace(0,1,n);
y2 = sin(2*pi*x);

% 3. Reduce the number of function evaluations using symmetry.
m = 5; n = 4*m+1; 
x = linspace(0,1,n); 
a = x(1:m+1);
y3 = zeros(1,n);
y3(1:m+1) = sin(2*pi*a);
y3(2*m+1:-1:m+2) = y3(1:m);   % or use y3(m+2:2*m+1) = y3(m:-1:1);
y3(2*m+2:n) = -y3(2:2*m+1);




