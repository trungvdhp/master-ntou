function y = CombinatorialMethodForEuOpts(S, X, T, sigma, r, n, putCall)
% Function y = CombinatorialMethodForEuOpts(S, X, T, sigma, r, n, style, putCall)
% compute European-style call option and put option using CombinatorialMethod
% S is stock price
% X is the strike price
% T is the expiration day
% sigma is the standard deviation of stock returns
% r is the risk-free interest
% n is the steps
% putCall is 'C' for call option and 'P' for put option
r = r / 100;
deltaT = T/n;
u = exp(sigma*sqrt(deltaT));
d = 1/u;
a = exp(r * deltaT);
b = exp(-r * T);
% Calculate the risk-neutral probabilities
p = (a - d)/(u - d);
q = 1 - p;

% Generate the combinations of i from n, where i = 0..n
C = 0:n;
C(1) = 1;
C(n+1) = 1;
k = n/2 + 1;
m = n;

for i = 1:k
    C(i+1) = (C(i)*m)/i;
    C(n-i+1) = C(i+1);
    m = m - 1;
end

switch putCall
    case 'C'
        z = 1;
    case 'P'
        z = -1;
    otherwise
        error('Check option type!');
end

% Compute European-style call option and put option using CombinatorialMethod
y = 0;
for i = 0:n
    y = y + C(i+1)*p^(n-i)*q^i*max(z*(S*u^(n-i)*d^i-X),0);
end
y = b*y;
end