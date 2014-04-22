function V=GetBondValue1(F, T, C, Q, R1, R2)
% GetBondValue(F, T, C, Q, R) returns a two-dimensional array of bond
% values V with each row corresponds to a specified coupon and
% each column corresponds to an interest rate
% F is bond face value
% T is maturity
% C is a column vector of coupon values
% Q is coupon frequency (in years, and will be a multiple of T)
% R is a row vector of constant risk-free interest rates
    r1 = R1/100;
    r2 = R2/100;
    V = 0;
    for t=Q:Q:5
        V = V + C*exp(-t*r1);
    end
    for t=5+Q:Q:T-Q
        V = V + C*exp(-t*r2);
    end
    V = V + (C+F)*exp(-T*r2);
end