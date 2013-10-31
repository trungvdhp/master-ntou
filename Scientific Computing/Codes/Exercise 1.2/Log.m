function y = Log(x, n)
% Date: 3/12/2001, Fusen F. Lin
% Modified: 10/31/2013, Justin
% This function computes log(a) by the series,
% log(1+x)= x-xˆ2/2+xˆ3/3-xˆ4/4+xˆ5/5-..., for n terms.
% Input : real x and integer n (x=1-a for log(a)).
% Output: the desired value log(1+x).
tn = x; % The first term.
sn = tn; % The n-th partial sum.
for k = 2:1:n, % To sum the series.
    tn = -tn*x*(k-1)/k; % compute it recursively.
    sn = sn + tn;
end
y = sn; % Output the final sum.