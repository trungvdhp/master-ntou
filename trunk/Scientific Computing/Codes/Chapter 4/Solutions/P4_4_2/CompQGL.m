function numI = CompQGL(fname,a,b,m,n)
% numI = CompQGL(fname,a,b,m,n)
%
% fname is a string that names an available function of the
%      form f(x) that is defined on [a,b]. f should
%      return a column vector if x is a column vector.
% a,b are real scalars 
% m is an integer that satisfies 2 <= m <=6
% n is a positive integer
%
% numI is the composite m-point Gauss-Legendre approximation of the 
%      integral of f(x) from a to b. The rule is applied on
%      each of n equal subintervals of [a,b].


z = linspace(a,b,n+1);

% The easy approach which involves n calls to f

numI=0;
for i=1:n
   numI = numI + QGL(fname,z(i),z(i+1),m);
end

% An approach that involves a single call to f. Uses the fact that
%
% w'*f1 + ... + w'*f2 = [w;...;w]'*[f1;f2;...;fn] where w and the fi are m-vectors.

[w,x] = GLweights(m);
wtilde = []; xtilde = [];
mdpt = (z(1:n)+z(2:n+1))/2;  % The midpoints of the intervals.
h_half = .5*(b-a)/n;         % Half the subinterval length.
for i=1:n
   wtilde = [wtilde;w];
   xtilde = [xtilde;mdpt(i)+h_half*x];
end
numI = h_half*(wtilde'*feval(fname,xtilde));