function V=GetBondValue(F, T, C, Q, R)
% Get bond value
% F is bond face value
% T is maturity
% C is a column vector of coupon values
% Q is coupon frequency (in years, and will be a multiple of T)
% R is a row vector of constant risk-free interest rates
    nr = length(R);
    nc = length(C);
    V = zeros(nc,nr);
    r = R/100;
    for t=Q:Q:T-Q
        V = V + C*exp(-t*r);
    end
    V = V + (C+F)*exp(-T*r);
end