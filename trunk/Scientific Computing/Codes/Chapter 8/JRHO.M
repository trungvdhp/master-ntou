  function J = Jrho(z,plist)
% J = Jrho(z,plist)  
% J is the Jacobian of the function rho at z.

A = z(1);
P = z(2);
c = plist(:,2);
denom = (P*(1-c) + A*(1+c)).^2;
J = -[ (2*P^2)*(1-c)./denom   (2*A^2)*(1+c)./denom];