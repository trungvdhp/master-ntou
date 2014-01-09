% Script File: InterpEff
% Compares the Vandermonde and Newton Approaches

clc
disp('Flop Counts:')
disp(' ')
disp('  n   InterpV   InterpN     InterpNRecur')
disp('--------------------------------------')
for n = [4 8 16]
   x = linspace(0,1,n)'; y = sin(2*pi*x);
   flops(0); a = InterpV(x,y);      f1 = flops;
   flops(0); c = InterpN(x,y);      f2 = flops;
   flops(0); c = InterpNRecur(x,y); f3 = flops;
   disp(sprintf('%3.0f %7.0f    %7.0f     %7.0f',n,f1,f2,f3));
end  