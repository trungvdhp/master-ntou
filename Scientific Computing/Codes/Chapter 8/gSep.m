  function g = gSep(t,planet1,planet2)
% g = gSep(t,planet1,planet2)
% The gradient of sep(t,planet1,planet2) with respect to 2-vector t.

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