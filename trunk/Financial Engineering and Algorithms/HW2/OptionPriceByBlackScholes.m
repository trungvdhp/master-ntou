function [callPrice, putPrice] = OptionPriceByBlackScholes(S, X, T, sigma, r)
% Function [putPrice, callPrice] = OptionPriceByBlackScholes(S, X, T, sigma, r, n)
% computes European-style call option and put option using Black-Scholes
% equation
% S is stock price
% X is the strike price
% T is the expiration day
% sigma is the standard deviation of stock returns
% r is the risk-free interest
r = r / 100;
a = X*exp(-r * T);
b = sigma * sqrt(T);
d1 = (log(S/X) + (r + (sigma^2)/2)*T)/b
d2 = d1 - b

% Compute N(d1), N(d2), N(-d1), N(-d2) using Gauss-Legendre rules
Nd1 = QGL('f', 0, 1, d1, 6)
Nd2 = QGL('f', 0, 1, d2, 6)
Nd11 = QGL('f', 0, 1, -d1, 6)
Nd21 = QGL('f', 0, 1, -d2, 6)

callPrice = S*Nd1 - a*Nd2
putPrice = a*Nd21 - S*Nd11
end