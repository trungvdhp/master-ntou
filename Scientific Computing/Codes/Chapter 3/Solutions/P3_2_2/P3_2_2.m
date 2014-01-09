% Problem P3_2_2
%
% Compare pwLAdapt and pwCAdapt on f(x) = sqrt(x) on [.001,9]

hmin = .001;
L =  .001; fL = sqrt(L); sL = .5/sqrt(L);
R = 9.000; fR = sqrt(R); sR = .5/sqrt(R);
clc 
disp('               pwL            pwC')
disp(' delta       length(x)     length(x)')
disp('--------------------------------------')
for delta = [.1 .01 .001 .0001 .00001]
   
   [x,y] = pwLAdapt('sqrt',L,fL,R,fR,delta,hmin);
   nL = length(x);
   [x,y,s] = pwCAdapt('sqrt','dMyF322',L,fL,sL,R,fR,sR,delta,hmin);
   nC = length(x);
   disp(sprintf(' %7.5f      %3.0f            %3.0f',delta,nL,nC))
end
