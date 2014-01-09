function w = MyNCweights(m);
% m  a positive integer >= 2.
% w a column m-vector of weights associated with the
%       m-point closed Newton-Cotes rule.

A = ones(m,m);
A(2,:) = linspace(0,1,m);
for i=3:m
   A(i,:) = A(i-1,:).*A(2,:);
end
rhs = 1./(1:m)';
w = A\rhs;