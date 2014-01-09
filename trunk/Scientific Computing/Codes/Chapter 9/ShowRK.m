% Script File: ShowRK
% Plots absolute error for fixed step size Runge-Kutta
% solution to y' = y, y(0) = 1 across [0,5].

close all
E = zeros(5,5);
for i=1:5
   n = 16*2^i;
   Exact = exp(-linspace(0,5,n+1)');
   for k=1:5  
      [tvals,yvals] = FixedRK('f1',0,1,5/n,k,n);
      E(i,k) = max(abs(yvals-Exact));
   end
end
semilogy([32 64 128 256 512]',E)
title('Runge-Kutta on y''(t) = -y(t), y(0) = 1, 0<=t<=5, h = 5/n')
xlabel('n (Number of Steps)')
ylabel('Maximum absolute error')
text(530,E(5,1)+.003,'k=1')
text(530,E(5,2),'k=2')
text(530,E(5,3),'k=3')
text(530,E(5,4),'k=4')
text(530,E(5,5),'k=5')