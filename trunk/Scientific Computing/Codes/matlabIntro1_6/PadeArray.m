
function P = PadeArray(m,n) 

% P = PadeArray(m,n) 
% m and n are nonnegative integers. 
% P is an (m+1)-by-(n+1) cell array. 
% 
% P{i,j} represents the (i-1,j-1)  Pade approximation N(x)/D(x)  to exp(x).

P = cell(m+1,n+1); 
for i=1:m+1
   for j=1:n+1
      P{i,j} = PadeCoef(i-1,j-1);
   end
end