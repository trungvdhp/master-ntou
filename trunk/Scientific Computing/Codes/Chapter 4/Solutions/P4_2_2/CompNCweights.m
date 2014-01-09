function w = CompNCweights(m,n)
% m and n are positive integers with 2<=m<=11.
% The weight vector associated with composite NC(m)
% rule with n equal length subintervals.

w = zeros(n*(m-1)+1,1);
for k=1:n
   i=(1+(k-1)*(m-1)):(1+k*(m-1));
   w(i) = w(i) + NCweights(m);
end
w = w/n;