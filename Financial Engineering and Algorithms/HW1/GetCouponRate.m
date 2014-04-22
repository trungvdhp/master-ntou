function C=GetCouponRate(F, T, Q, R1, R2)
% GetInterestRate(V, F, T, C, Q) returns a constant risk-free interest rate
% V is bond price
% F is bond face value
% T is maturity
% R is interest rate
% Q is coupon frequency (in years, and will be a multiple of T)
    f=sprintf('-%f',F);
    syms x;
    for t=Q:Q:5
        f = sprintf('%s+x*exp(-%f*%f)',f,R1,t);
    end
    for t=5+Q:Q:T-Q
        f = sprintf('%s+x*exp(-%f*%f)',f,R2,t);
    end
    f = sprintf('%s+(%f+x)*exp(-%f*%f)',f,F,R2,T);
    C = fzero(f,2);
end