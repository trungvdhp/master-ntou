  function J = JSepV(t,planet1,planet2) 
% J = JSepV(t,planet1,planet2)
% J is the Jacobian of sepV(t,planet1,planet2).

A1 = planet1.A; P1 = planet1.P; phi1 = planet1.phi; 
A2 = planet2.A; P2 = planet2.P; phi2 = planet2.phi; 

s1 = sin(t(1)); c1 = cos(t(1));
s2 = sin(t(2)); c2 = cos(t(2));
beta1 = (P1+A1)/2; gamma1 = sqrt(P1*A1);
beta2 = (P2+A2)/2; gamma2 = sqrt(P2*A2);
cphi1 = cos(phi1); sphi1  = sin(phi1);
cphi2 = cos(phi2); sphi2  = sin(phi2);
Rot1  = [cphi1 sphi1; - sphi1 cphi1];
Rot2  = [cphi2 sphi2; - sphi2 cphi2];

J = [ Rot1*[beta1*s1;-gamma1*c1] Rot2*[-beta2*s2;gamma2*c2]];