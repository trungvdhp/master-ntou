display('This program do a plot of interest rate r verses the value of the bond');
n=input('Input number of points n = ');
F = 100;
T = 2;
Q = 0.25;
C = 0:2;
R=linspace(0.5,5,n);
V = GetBondValue(F,T,C',Q,R);
plot(R,V(1,:),'r',R,V(2,:),'b',R,V(3,:),'m');
legend('Coupon C = 0','Coupon C = 1','Coupon C = 2');
% The interest rates and bond prices have what's called an "inverse relationship"
% - meaning when one goes up, the other goes down
% The coupon values and bond prices have what's called an "direct relationship" or "positive relationship"
% - meaning both increase or decrease together