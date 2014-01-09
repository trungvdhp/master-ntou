% Script File: UpDown
% Generates a column vector x(1:n) of positive integers 
% where x(1) is solicited and
% 
%          x(k+1) = x(k)/2    if x(k) is even.
%          x(k+1) = 3x(k)+1   if x(k) is odd.
%
% The value of n is either 500 or the first index with the
% property that x(n) = 1, whichever comes first.

x = zeros(500,1);
x(1) = input('Enter initial positive integer:');
k = 1;
while ((x(k) ~= 1) & (k < 500))
   if rem(x(k),2) == 0
      x(k+1) = x(k)/2;
   else
      x(k+1) = 3*x(k)+1;
   end
   k = k+1;
end
n = k;
x = x(1:n);

clc
disp(sprintf('x(1:%1.0f) = \n',n))
disp(sprintf('%-8.0f',x))
[xmax,imax] = max(x);
disp(sprintf('\n x(%1.0f) = %1.0f is the max.',imax,xmax))
density = sum(x<=x(1))/x(1);
disp(sprintf(' The density is %5.3f.',density))

close all
figure
plot(x)
title(sprintf('x(1) = %1.0f, n = %1.0f',x(1),n));
figure
plot(-sort(-x))
title('Sequence values sorted.')
I = find(rem(x(1:n-1),2)==1);
if length(I)>1
   figure
   plot((1:n),zeros(1,n),I+1,x(I+1),I+1,x(I+1),'*')
   title('Local Maxima')
end   