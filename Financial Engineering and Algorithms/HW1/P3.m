display('A program computes the implied interest rate r');
cont = 1;
while cont ~= 0
    display('---------------------Let''s run-------------------');
    V=input('Input bond price V = ');%107.843724
    F=input('Input bond face value F = ');%100
    T=input('Input maturity T = ');%2
    C=input('Input coupon value C = ');%2.5;
    Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    while int32(T/Q) ~= (T/Q)
        Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    end
    r=GetInterestRate(V,F,T,C,Q);
    fprintf('Constant risk-free interest rate r = %.4f\n', r);
    display('-------------------------------------------------');
    cont=input('Input anything to try again or intput 0 to exit:');
end