function A=H4(v0,s0,v1,s1,vtau,tau)
% A=H4(v0,s0,v1,s1,vtau,tau)
% 
% Assume that the six inputs are length-n column vectors.
% A is an n-by-5 matrix with the property that if qi(t) is the quartic polynomial
%
%         qi(t) = A(i,1) + A(i,2)t + A(i,3)t^2 + A(i,4)t^2(t-1) + A(i,5)t^2(t-1)^2
%
% then qi(0)=v0, qi'(0)=s0, qi(1)=v1, qi'(1)=s1 and qi(tau(i))=vtau(i) for i=1:n.

%
n=length(v0);
A=zeros(n,5);

A(:,1)=v0;
A(:,2)=s0;
A(:,3)=v1-A(:,1)-A(:,2);
A(:,4)=s1-A(:,2)-2*A(:,3);
A(:,5)=(1./(tau.^2.*(tau-1).^2)).*(vtau-A(:,1)-A(:,2).*tau-A(:,3).*tau.*tau-A(:,4).*tau.*tau.*(tau-1));
