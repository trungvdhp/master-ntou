  function Fvals = CSeval(F,T,tvals)
% F.a is a length m+1 column vector, F.b is a length m-1 column vector, 
% T is a positive scalar, and tvals is a column vector.
% If 
%   F(t)  = F.a(1) + F.a(2)*cos((2*pi/T)*t) +...+ F.a(m+1)*cos((2*m*pi/T)*t) + 
%                    F.b(1)*sin((2*pi/T)*t) +...+ F.b(m-1)*sin((2*m*pi/T)*t)
%
% then Fvals = F(tvals).    

Fvals = zeros(length(tvals),1);
tau = (2*pi/T)*tvals;
for j=0:length(F.a)-1, Fvals = Fvals + F.a(j+1)*cos(j*tau); end
for j=1:length(F.b),   Fvals = Fvals + F.b(j)*sin(j*tau); end