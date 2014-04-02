function r=GetInterestRate(V, F, T, C, Q)
% GetInterestRate(V, F, T, C, Q) returns a constant risk-free interest rate
% V is bond price
% F is bond face value
% T is maturity
% C is a column vector of coupon values
% Q is coupon frequency (in years, and will be a multiple of T)
    f=sprintf('-%f',V);
    syms x;
    for t=Q:Q:T-Q
        f = sprintf('%s+%f*exp(-%f*x)',f,C,t);
    end
    f = sprintf('%s+%f*exp(-%f*x)',f,C+F,T);
    r = fzero(f,1)*100;
end