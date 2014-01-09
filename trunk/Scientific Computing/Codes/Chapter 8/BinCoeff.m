function b = BinCoeff(m,k)
% b = BinCoeff(m,k)
%
% The binomial coefficient m-choose-k, i.e., m!/(k!(m-k)!)
% It is assumed that 0 <= k <= m where k and m are integers.

b = 1;
k = min([k m-k]);
for j=1:k
   b = (b*(m-j+1))/j;
end