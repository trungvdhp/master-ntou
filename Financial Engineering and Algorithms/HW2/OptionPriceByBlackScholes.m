function [callPrice, putPrice] = OptionPriceByBlackScholes(S, X, T, sigma, r)
% Function [putPrice, callPrice] = OptionPriceByBlackScholes(S, X, T, sigma, r)
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
d1 = (log(S/X) + (r + (sigma^2)/2)*T)/b;
d2 = d1 - b;

% Compute N(d1), N(d2), N(-d1), N(-d2) using the 
% composite m-point Newton-Cotes Open Rules
n = 990;
Nd1 = CompQNCOpen('f', 0, 1, d1, 7, n);
Nd2 = CompQNCOpen('f', 0, 1, d2, 7, n);
Nd11 = CompQNCOpen('f', 0, 1, -d1, 7, n);
Nd21 = CompQNCOpen('f', 0, 1, -d2, 7, n);

% using Error Function
display(erf2(d1/sqrt(2), 3000) - erf(d1/sqrt(2)));
display(erf2(-d1/sqrt(2), 3000) - erf(-d1/sqrt(2)));
display(erf2(d2/sqrt(2), 3000) - erf(d2/sqrt(2)));
display(erf2(-d2/sqrt(2), 3000) - erf(-d2/sqrt(2)));

display(erf1(d1/sqrt(2)) - erf(d1/sqrt(2)));
display(erf1(-d1/sqrt(2)) - erf(-d1/sqrt(2)));
display(erf1(d2/sqrt(2)) - erf(d2/sqrt(2)));
display(erf1(-d2/sqrt(2)) - erf(-d2/sqrt(2)));


Nd1e = (erf2(d1/sqrt(2), 3000) + 1)/2;
Nd2e = (erf2(d2/sqrt(2), 3000) + 1)/2;
Nd11e = (erf2(-d1/sqrt(2), 3000) + 1)/2;
Nd21e = (erf2(-d2/sqrt(2), 3000) + 1)/2;

callPrice = S*Nd1e - a*Nd2e;
putPrice = a*Nd21e - S*Nd11e;
end