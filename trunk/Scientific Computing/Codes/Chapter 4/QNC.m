function numI = QNC(fname,a,b,m)
% numI = QNC(fname,a,b,m)
%
% Integrates a function of the form f(x) named by the string fname from a to b. 
% f must be defined on [a,b] and it must return a column vector if x is a column vector.
% m is an integer that satisfies 2 <= m <= 11.
% numI is the m-point Newton-Cotes approximation of the integral of f from a to b. 

w = NCWeights(m);
x = linspace(a,b,m)';
f = feval(fname,x);
numI = (b-a)*(w'*f);