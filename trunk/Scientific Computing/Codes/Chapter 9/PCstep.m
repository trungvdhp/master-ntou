  function [tnew,yPred,fPred,yCorr,fCorr] = PCStep(fname,tc,yc,fvals,h,k)  
% [tnew,yPred,fPred,yCorr,fCorr] = PCStep(fname,tc,yc,fvals,h,k)
% Single step using the kth-order Adams predictor-corrector framework.
%
% fname is a string that names a function of the form f(t,y)
% where t is a scalar and y is a column d-vector.
%
% yc is an approximate solution to y'(t) = f(t,y(t)) at t=tc.
%
% fvals is an d-by-k matrix where fvals(:,i) is an approximation
% to f(t,y) at t = tc +(1-i)h, i=1:k
%
% h is the time step. 
%
% k is the order of the Adams methods used, 1<=k<=5.
%
% tnew=tc+h, 
% yPred is the predicted solution at t=tnew
% fPred = f(tnew,yPred)
% yCorr is the corrected solution at t=tnew
% fCorr = f(tnew,yCorr).

[tnew,yPred,fPred] = ABstep(fname,tc,yc,fvals,h,k);  
[tnew,yCorr,fCorr] = AMstep(fname,tc,yc,[fPred fvals(:,1:k-1)],h,k);