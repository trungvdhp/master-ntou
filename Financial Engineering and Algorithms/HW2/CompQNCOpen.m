function numI = CompQNCOpen(fname,a,b,d,m,n) 
% numI = CompQNCOpen(fname,a,b,d,m,n) 
%
% Integrates a function of the form f (x) named by the string fname from a to b 
% m is an integer that satisfies 2 <= m <= 7. 
% numI is the composite m-point Newton-Cotes Open Rules approximation of the integral of f
% from a to b with n equal length subintervals.

Delta = (b-a)/n;
h = Delta/(m+1);
w = NCOpenWeights(m)';
numI = 0;
first = a;
last = a + Delta;
for i=1:n
   % Add in the inner product for the i-th subintegral with Open Rules.
   x = linspace(first+h,last-h,m)';
   f = feval(fname,x,d);
   numI = numI + w*f;
   first = last;
   last = last+Delta; 
end 
numI = Delta*numI;