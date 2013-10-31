
function y = MyExp4(x) 

% y = MyExp4(x)
% x is an n-vector and y is an n-vector with the same shape and the
% property that y(i) is a Taylor approximation to exp(x(i)) for i=1:n. 
% compute the k_th term up to abs(term) < eps.

y = zeros(size(x)); 
term = ones(size(x)); 
k = 0; 
while any(abs(term) > eps*abs(y))
   y = y + term;
   k = k + 1;
   term = x.*term/k; 
end