  function [d,err] = Derivative(fname,a,delta,M2)
% d = Derivative(fname,a,delta,M2);
% fname  a string that names a function f(x) whose derivative
% at x = a is sought. delta is the absolute error associated with
% an f-evaluation and M2 is an estimate of the second derivative
% magnitude near a. d is an approximation to f'(a) and err is an estimate 
% of its absolute error.
%
% Usage:
%     [d,err] =  Derivative(fname,a)   
%     [d,err] =  Derivative(fname,a,delta) 
%     [d,err] =  Derivative(fname,a,delta,M2)

if nargin <= 3
   % No derivative bound supplied, so assume the
   % second derivative bound is 1.
   M2 = 1;
end
if nargin == 2
   % No function evaluation error supplied, so
   % set delta to eps.
   delta = eps;
end
% Compute optimum h and divided difference
hopt = 2*sqrt(delta/M2);
d   = (feval(fname,a+hopt) - feval(fname,a))/hopt;
err = 2*sqrt(delta*M2);
