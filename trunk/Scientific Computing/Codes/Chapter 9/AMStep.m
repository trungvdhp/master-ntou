  function [tnew,ynew,fnew] = AMstep(fname,tc,yc,fvals,h,k) 
% [tnew,ynew,fnew] = AMstep(fname,tc,yc,fvals,h,k)
% Single step of the kth order Adams-Moulton method.
%
% fname is a string that names a function of the form f(t,y)
% where t is a scalar and y is a column d-vector.
%
% yc is an approximate solution to y'(t) = f(t,y(t)) at t=tc.
%
% fvals is an d-by-k matrix where fvals(:,i) is an approximation
% to f(t,y) at t = tc +(2-i)h, i=1:k
%
% h is the time step. 
%
% k is the order of the AM method used, 1<=k<=5.
%
% tnew=tc+h
% ynew is an approximate solution at t=tnew
% fnew = f(tnew,ynew).


if k==1
   ynew = yc + h*fvals;
elseif k==2
   ynew = yc + (h/2)*(fvals*[1;1]);
elseif k==3
   ynew = yc + (h/12)*(fvals*[5;8;-1]);
elseif k==4
   ynew = yc + (h/24)*(fvals*[9;19;-5;1]);
elseif k==5
   ynew = yc + (h/720)*(fvals*[251;646;-264;106;-19]);
end
tnew = tc+h;
fnew = feval(fname,tnew,ynew);