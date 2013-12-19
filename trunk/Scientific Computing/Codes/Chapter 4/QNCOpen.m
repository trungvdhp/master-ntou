function numI = QNCOpen(fname,a,b,m)
% numI = QNC(fname,a,b,m,tol)
%
% Integrates a function of the form f(x) named by the string fname from a to b. 
% f must be defined on [a,b] and it must return a column vector if x is a column vector.
% m is an integer that satisfies 1 <= m <= 9.
% numI is the m-point open Newton-Cotes approximation of the integral of f from a to b. 


w = NCOpenWeights(m);
h = (b-a)/(m+1);
x = linspace(a+h,b-h,m)';
f = feval(fname,x);
numI = (b-a)*(w'*f);
