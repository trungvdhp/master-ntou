% Problem P4_4_2
% 
% Illustrates composite Gauss-Legendre rules on three different
% integrands.
%
% Show QNC(m,n) errors for integral of sin from 0 to pi/2.

close all
figure
for m = 2:6
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16]
      % n = number of subintervals.
      err = [err  abs(compQGL('sin',0,pi/2,m,n) -1)+eps];
   end
   semilogy([1 2 4 8 16],err)
   axis([0 20 10^(-17) 10^0])
   text(16,err(5),sprintf('m = %1.0f',m))
   hold on
end
title('Example 1.   QGL(m,n) error for integral of sin from 0 to pi/2')
xlabel('n = number of subintervals.')
ylabel('Error in QGL(m,n)')
% Show QGL(m,n) errors for integral of sqrt from 0 to 1.
figure
for m = 2:6
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16 ]
      % n = number of subintervals.
      err = [err abs(compQGL('sqrt',0,1,m,n) - (2/3))+eps];
   end
    semilogy([1 2 4 8 16],err)
   axis([0 20 10^(-6) 10^(-2)])
   text(16,err(5),sprintf('m = %1.0f',m))
   hold on
end
title('Example 2.   QNC(m,n) error for integral of sqrt from 0 to 1')
xlabel('n = number of subintervals.')
ylabel('Error in QGL(m,n)')
% Show QGL(m,n) errors for integral of 1/(1+25x^2) from 0 to 1.
figure
for m=2:6
   % m-point rule used.
   err = [];
   for n = [1 2 4 8 16]
      % n = number of subintervals.
      err = [err  abs(compQGL('Runge',0,1,m,n) - (atan(5)/5))+eps;];
   end
   semilogy([1 2 4 8 16],err)
   axis([0 20 10^(-17) 10^0])
   text(16,err(5),sprintf('m = %1.0f',m))
   hold on
end
title('Example 3. QGL(m,n) error for integral of 1/(1+25x^2) from 0 to 1')
xlabel('n = number of subintervals.')
ylabel('Error in QGL(m,n)')