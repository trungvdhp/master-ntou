  function [tnew,Fnew,Jnew] = NStep(tc,Fc,Jc,planet1,planet2)
% [tnew,Fnew,Jnew] = NStep(tc,Fc,Jc,planet1,planet2)
% Newton Step
%
% tc is a column 2-vector, Fc is the value of SepV(t,planet1,planet2) at t=tc
% and Jc is the value of JSepV(t,planet1,planet2) at t=tc. Does one Newton step
% applied to SepV rendering a new approximate root tnew. Fnew and Jnew are the 
% values of SepV(tnew,planet1,planet2) and jSepV(tnew,planet1,planet2) respectively.

sc = -(Jc\Fc);
tnew = tc + sc;
Fnew = SepV(tnew,planet1,planet2);   
Jnew = JSepV(tnew,planet1,planet2);