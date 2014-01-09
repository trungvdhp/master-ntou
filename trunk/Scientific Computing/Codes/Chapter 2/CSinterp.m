  function F = CSInterp(f)
% F = CSInterp(f)
% f is a column n vector and n = 2m.
% F.a is a column m+1 vector and F.b is a column m-1 vector so that if 
% tau = (0:n-1)'*pi/m, then
%
%         f = F.a(1)*cos(0*tau) +...+ F.a(m+1)*cos(m*tau) + 
%             F.b(1)*sin(tau)   +...+ F.b(m-1)*sin((m-1)*tau)

n = length(f); 
m = n/2;
tau = (pi/m)*(0:n-1)';
P = [];
for j=0:m,   P = [P cos(j*tau)]; end
for j=1:m-1, P = [P sin(j*tau)]; end
y = P\f;
F = struct('a',y(1:m+1),'b',y(m+2:n));


   