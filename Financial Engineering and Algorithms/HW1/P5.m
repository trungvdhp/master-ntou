display('A program computes the implied interest rate r');
cont = 1;
while cont ~= 0
    display('---------------------Let''s run-------------------');
    F=input('Input bond face value F = ');%100
    T=input('Input maturity T = ');%2
    Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    while int32(T/Q) ~= (T/Q)
        Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    end
    R=input('Input constant risk-free interest rate r = ');%1.025;
    C=GetCouponRate(F,T,Q,1.3,1.45);
    fprintf('Constant coupon rate C = %.4f\n', C);
    display('-------------------------------------------------');
    cont=input('Input anything to try again or intput 0 to exit:');
end