  function [tnew,Fnew] = FDNStep(tc,Fc,planet1,planet2)
% [tnew,Fnew] = FDNStep(tc,Fc,planet1,planet2)
% Finite difference Newton step.
% 
% tc is a column 2-vector, Fc is the value of SepV(t,planet1,planet2) at t=tc
% Does one finite difference Newton step applied to SepV rendering a new 
% approximate root tnew. Fnew is the values of SepV(tnew,planet1,planet2).

% Set up the FD Jacobian.
Jc = zeros(2,2);
delta = sqrt(eps);
for k=1:2
   tk = tc;
   tk(k) = tc(k) + delta;
   Jc(:,k) = (SepV(tk,planet1,planet2) - Fc)/delta;
end

% The Finite Difference Newton Step.
sc = -(Jc\Fc);
tnew = tc + sc;
Fnew = SepV(tnew,planet1,planet2);  