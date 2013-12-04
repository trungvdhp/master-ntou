  function d3 = MaxJump(S);
% S is the pp representation of a cubic spline.
% d3 is the absolute value of the largest 3rd derivative
%      jump at any knot.

[x,rho,L,k] = unmkpp(S);

% 3rd derivative of the i-th local cubic is 6*rho(i,1)

if L==1
   d3 = 0;  % One interval only
else
   d3 = 6*max(abs(rho(2:L,1)-rho(1:L-1,1)));
end
