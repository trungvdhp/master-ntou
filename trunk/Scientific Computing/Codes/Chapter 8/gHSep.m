  function [g,H] = gHSep(t,planet1,planet2)
% [g,H] = gHSep(t,planet1,planet2)
%
% t is a 2-vector and planet1 and planet2 are orbits.
% g is the gradient of Sep(t,planet1,planet2) and H is the Hessian.


A1 = planet1.A; P1 = planet1.P; phi1 = planet1.phi; 
A2 = planet2.A; P2 = planet2.P; phi2 = planet2.phi; 

alfa1  = (P1-A1)/2; beta1  = (P1+A1)/2; gamma1 = sqrt(P1*A1);
alfa2  = (P2-A2)/2; beta2  = (P2+A2)/2; gamma2 = sqrt(P2*A2);
s1     = sin(t(1)); c1     = cos(t(1));
s2     = sin(t(2)); c2     = cos(t(2));
cphi1  = cos(phi1); sphi1  = sin(phi1);
cphi2  = cos(phi2); sphi2  = sin(phi2);
Rot1   = [cphi1 sphi1; -sphi1 cphi1];
Rot2   = [cphi2 sphi2; -sphi2 cphi2];
P1     = Rot1*[alfa1+beta1*c1;gamma1*s1];
P2     = Rot2*[alfa2+beta2*c2;gamma2*s2];
dP1    = Rot1*[-beta1*s1;gamma1*c1];
dP2    = Rot2*[-beta2*s2;gamma2*c2];
g = [-dP1';dP2']*(P2-P1);
ddP1   = Rot1*[-beta1*c1;-gamma1*s1];
ddP2   = Rot2*[-beta2*c2;-gamma2*s2];
H = zeros(2,2);
H(1,1) = (P1(1)-P2(1))*ddP1(1) + (P1(2)-P2(2))*ddP1(2) + ...
   dP1(1)^2 + dP1(2)^2;
H(2,2) = (P2(1)-P1(1))*ddP2(1) + (P2(2)-P1(2))*ddP2(2) + ...
   dP2(1)^2 + dP2(2)^2;									    
H(1,2) = -dP1(1)*dP2(1) - dP1(2)*dP2(2);
H(2,1) = H(1,2);