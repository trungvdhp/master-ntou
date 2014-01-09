  function [tnew,ynew,fnew] = ABStep(fname,tc,yc,fvals,h,k) 
% [tnew,ynew,fnew] = ABStep(fname,tc,yc,fvals,h,k)  
% Single step of the kth order Adams-Bashforth method.
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
% k is the order of the AB method used, 1<=k<=5.
%
% tnew=tc+h.
% ynew is an approximate solution at t=tnew.
% fnew = f(tnew,ynew).

if k==1
   ynew = yc + h*fvals;
elseif k==2
   ynew = yc + (h/2)*(fvals*[3;-1]);
elseif k==3
   ynew = yc + (h/12)*(fvals*[23;-16;5]);
elseif k==4
   ynew = yc + (h/24)*(fvals*[55;-59;37;-9]);
elseif k==5
   ynew = yc + (h/720)*(fvals*[1901;-2774;2616;-1274;251]);
end
tnew = tc+h;
fnew = feval(fname,tnew,ynew);