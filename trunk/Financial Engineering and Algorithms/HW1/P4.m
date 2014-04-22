display('A program tabulates and prints the bond value V');
cont = 1;
while cont ~= 0
    display('---------------------Let''s run-------------------');
    F=input('Input bond face value F = ');%100
    T=input('Input maturity T = ');%2
    C=input('Input coupon value C = ');%2.5;
    Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    while int32(T/Q) ~= (T/Q)
        Q=input('Input coupon frequency Q (in years, and will be a multiple of T) = ');%0.5;
    end
    r=input('Input constant risk-free interest rate r = ');%1.025;
    V=GetBondValue1(F,T,C,Q,1.3,1.45);
    fprintf('Bond value V = %.6f\n', V);
    display('-------------------------------------------------');
    cont=input('Input anything to try again or intput 0 to exit:');
end
