% Problem P4_1_3
%
% NCweights(m) is exact for polynomials of degree m.

clc 
disp(' m   Error in NCweights(m) applied to x^m on [0,1]')
disp('----------------------------------------------')
for m=3:2:11
   x = (linspace(0,1,m)').^m;
   I = 1/(m+1);
   numI = NCweights(m)'*x;
   disp(sprintf('%2.0f            %20.16f',m,abs(I-numI)))
end