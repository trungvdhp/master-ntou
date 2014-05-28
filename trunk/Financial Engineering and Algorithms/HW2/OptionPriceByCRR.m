function y = OptionPriceByCRR(S, X, T, sigma, r, n, style, putCall)
% Function y = OptionPriceByCRR(S, X, T, sigma, r, n, style, putCall)
% computes European-style call option and put option
% S is stock price
% X is the strike price
% T is the expiration day
% sigma is the standard deviation of stock returns
% r is the risk-free interest
% n is the steps
% style is 'E' for European Style and 'A' for American Style
% putCall is 'C' for call option and 'P' for put option
r = r / 100;
deltaT = T/n;
u = exp(sigma*sqrt(deltaT));
d = 1/u;
a = exp(r * deltaT);
b = 1/a;
% Calculate the risk-neutral probabilities
p = (a - d)/(u - d);
q = 1 - p;

% Build CRR Binomial Tree Model
V = zeros(n+1,n);
V(1,1) = S;

for i = 2:n+1
    for j = 1:i-1
        V(i, j) = V(i-1, j) * u;
    end
    V(i, j+1) = V(i-1, j) * d;
end

switch putCall
    case 'C'
        z = 1;
    case 'P'
        z = -1;
    otherwise
        error('Check option type!');
end

% Find the option price by working back through the tree.
% Insert terminal values
V(n+1, :) = max(z*(V(n+1,:) - X), 0.00);
switch style
    % European option
    case 'E'
        for i = n:-1:1
            for j = 1:i
                V(i, j) = b * (p * V(i+1, j) + q * V(i+1, j+1));
            end
        end
    % American option   
    case 'A'
        for i = n:-1:1
            for j = 1:i
                V(i, j) = max(z*(V(i, j) - X), b * (p * V(i+1, j) + q * V(i+1, j+1)));
            end
        end
    otherwise
        error('Check option style!');
end
y = V(1,1);
end