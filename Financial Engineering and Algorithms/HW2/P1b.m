% This script will plot a graph, where 
% the x-axis represents the number of partitions n and 
% the y-axis represent the option price
% Review: 
S = 90;
X = 95;
T = 0.5;
sigma = 0.3;
r = 2;
style = 'E';
% putCall = 'C';
m = 3;
n = 1000;
steps = 1;
x = m:steps:n;
k = length(x);
% y = nan(1, k);
y1 = nan(1, k);
y2 = nan(1, k);

for i = 1:k
%     y(i) = OptionPriceByCRR(S, X, T, sigma, r, x(i) - 1, style, putCall);
    y1(i) = OptionPriceByCRR(S, X, T, sigma, r, x(i) - 1, style, 'C');
    y2(i) = OptionPriceByCRR(S, X, T, sigma, r, x(i) - 1, style, 'P');
end

plot(x, y1, x, y2);
xlabel('Number of Partitions');
ylabel('Option Price');
% switch putCall
%     case 'C'
%         putCall = 'call option';
%     case 'P'
%         putCall = 'put option';
%     otherwise
%         error('Check option type!');
% end

switch style
    % European option
    case 'E'
        style = 'European-style';
    % American option   
    case 'A'
        style = 'American-style';
    otherwise
        error('Check option style!');
end
% title(sprintf('Convergence of CRR at the %s %s\n(S = %.2f, X = %.2f , T = %.2f, sigma = %.2f%%, and r = %.2f%%)',style, putCall, S, X, T, sigma*100, r));
title(sprintf('Convergence of CRR at the %s\n(S = %.2f, X = %.2f , T = %.2f, sigma = %.2f%%, and r = %.2f%%)',style, S, X, T, sigma*100, r));

legend('Call Option','Put Option');