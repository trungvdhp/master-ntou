function numI = SplineQ1(x,y,a,b)
% x,y are n-vectors with x(1) < ... < x(n)
% a,b are such that  x(1) <= a <= b <= x(n)
%
% numI is the integral from x(1) to x(n) of the not-a-knot spline 
%     interpolant of (x(i),y(i)), i=1:n

S = spline(x,y);
[x,rho,L,k] = unmkpp(S);
if a==x(L+1)
   numI = 0;
   return
end
ia = locate(x,a);   %x(ia) <= a <= x(ia+1)
ib = locate(x,b);   %x(ib) <= b <= x(ib+1)
if ia==ib
   % same interval
   hb = (b-x(ia));
   fb = hb*(((rho(ia,1)*hb/4 + rho(ia,2)/3)*hb + rho(ia,3)/2)*hb + rho(ia,4));
   ha = (a-x(ia));
   fa = ha*(((rho(ia,1)*ha/4 + rho(ia,2)/3)*ha + rho(ia,3)/2)*ha + rho(ia,4));
   numI = fb-fa;
   return
end
% Start in the subinterval that houses a:
h1 = (x(ia+1)-x(ia));
f1 = h1*(((rho(ia,1)*h1/4 + rho(ia,2)/3)*h1 + rho(ia,3)/2)*h1 + rho(ia,4));
ha = (a-x(ia));
fa = ha*(((rho(ia,1)*ha/4 + rho(ia,2)/3)*ha + rho(ia,3)/2)*ha + rho(ia,4));
sum = f1-fa;
% Add in the contributions of the intervals in between a and b but not
% including either of those intervals.
for i=(ia+1):(ib-1)
   % Add in the integral from x(i) to x(i+1).
   h = x(i+1)-x(i);
   subI = h*(((rho(i,1)*h/4 + rho(i,2)/3)*h + rho(i,3)/2)*h + rho(i,4));
   sum = sum + subI;
end
% Add in the contribution of the rightmost interval that houses b.
hb = b-x(ib);
subI = hb*(((rho(ib,1)*hb/4 + rho(ib,2)/3)*hb + rho(ib,3)/2)*hb + rho(ib,4));
numI = sum + subI;