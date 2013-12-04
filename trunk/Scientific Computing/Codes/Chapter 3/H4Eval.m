function Y=H4Eval(A,tval)
% Y=H4Eval(A,tval)
% 
% Assume that A is an n-by-5 matrix and that tval is a length-m row vector.
% For i=1:n, let qi(t) be the quartic polynomial
%
%         qi(t) = A(i,1) + A(i,2)t + A(i,3)t^2 + A(i,4)t^2(t-1) + A(i,5)t^2(t-1)^2.
%
% Y is an n-by-m matrix with the property that Y(i,j)=qi(tval(j)) for i=1:n, j=1:m.

%
n=length(A(:,1));
m=length(tval);
Y=zeros(n,m);
T=ones(n,1)*tval;

Y=A(:,1)*ones(1,m) + (A(:,2)*ones(1,m)).*T + (A(:,3)*ones(1,m)).*(T.*T) + ...
    (A(:,4)*ones(1,m)).*(T.*T).*(T-1) + (A(:,5)*ones(1,m)).*(T.*T).*((T-1).*(T-1));

