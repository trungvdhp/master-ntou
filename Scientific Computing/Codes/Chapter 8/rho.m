  function f = rho(z,plist)
% f = rho(z,plist)
% z is a 2-vector whose components are the orbit parameters A and P
% respectively. plist is a 2-column matrix. plist(i,1) is the i-th
% observed radius vector length and plist(i,2) is the cosine of the
% corresponding observed polar angle.

A = z(1);
P = z(2);
r = plist(:,1);
c = plist(:,2);
f = r - (2*A*P)./(P*(1-c) + A*(1+c));