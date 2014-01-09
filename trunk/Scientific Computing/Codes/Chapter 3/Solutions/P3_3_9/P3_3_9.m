% Problem P3_3_9
%
% Illustrate a 1-knot natural spline.

y = [-1 ; 3 ; -2];
[a,b,c,d] = SmallSpline(y);

zL = linspace(-1,0)';
CL = ((d(1)*zL + c(1)).*zL+b(1)).*zL+a(1); 
zR = linspace(0,1)';
CR = ((d(2)*zR + c(2)).*zR+b(2)).*zR+a(2); 
plot([zL;zR],[CL;CR],[-1;0;1],y,'o')