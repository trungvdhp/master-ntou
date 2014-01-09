function P = PascalTri1(n)
% n is a positive integer
% T is nxn lower triangular matrix with T(i,j) =
%       the binomial coefficient (i-1)-choose-(j-1)

P = tril(ones(n,n));
for i=3:n
    for j=2:i-1
        P(i,j) = P(i-1,j-1) + P(i-1,j);
    end
end