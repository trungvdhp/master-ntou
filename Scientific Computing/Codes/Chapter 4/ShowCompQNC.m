
% Script File: ShowCompQNC
% Illustrates composite Newton-Cotes rules on three different
% integrands.
% Show QNC(m,n) errors for integral of sin from 0 to pi/2.

close all
figure
for m = [3 5 7]
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16 32]
      % n = number of subintervals.
      err = [err  abs(CompQNC('sin',0,pi/2,m,n) -1)+eps];
   end
   semilogy([1 2 4 8 16 32], err) % plot the errors for each n 
   axis([0 40 10^(-17) 10^0])
   text(33,err(6),sprintf('m = %1.0f',m))
   hold on
end
title('Example 1.   QNC(m,n) error for integral of sin from 0 to pi/2')
xlabel('n = number of subintervals.')
ylabel('Error in QNC(m,n)')

% Show QNC(m,n) errors for integral of sqrt from 0 to 1.
figure
for m = [3 5 7]
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16 32]
      % n = number of subintervals.
      err = [err abs(CompQNC('sqrt',0,1,m,n) - (2/3))+eps];
   end
   semilogy([1 2 4 8 16 32],err)
   axis([0 40 10^(-5) 10^(-1)])
   text(33,err(6),sprintf('m = %1.0f',m))
   hold on
end
title('Example 2.   QNC(m,n) error for integral of sqrt from 0 to 1')
xlabel('n = number of subintervals.')
ylabel('Error in QNC(m,n)')

% Show QNC(m,n) errors for integral of 1/(1+25x^2) from 0 to 1.
figure
for m = [3 5 7]
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16 32]
      % n = number of subintervals.
      err = [err  abs(CompQNC('Runge',0,1,m,n) - (atan(5)/5))+eps;];
   end
   semilogy([1 2 4 8 16 32],err)
   axis([0 40 10^(-17) 10^0])
   text(33,err(6),sprintf('m = %1.0f',m))
   hold on
end
title('Example 3. QNC(m,n) error for integral of 1/(1+25x^2) from 0 to 1')
xlabel('n = number of subintervals.')
ylabel('Error in QNC(m,n)')

