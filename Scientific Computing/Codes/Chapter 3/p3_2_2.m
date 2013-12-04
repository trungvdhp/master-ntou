% P3.2.2
%
% Compare pwLAdapt and pwCAdapt on f(x) = sqrt(x) on [.001,9]

hmin = .001;
L =  .001; fL = sqrt(L); sL = .5/sqrt(L);
R = 9.000; fR = sqrt(R); sR = .5/sqrt(R);

disp('               pwL            pwC')
disp(' delta       length(x)     length(x)')
disp('--------------------------------------')
for delta = [.1 .01 .001 .0001 .00001]
  
   [xl,yl] = pwLAdapt('f',L,fL,R,fR,delta,hmin);
   nL = length(xl);
   [xc,yc,sc] = pwCAdapt('f','dfdx',L,fL,sL,R,fR,sR,delta,hmin);
   nC = length(xc);
   disp(sprintf(' %7.5f      %3.0f            %3.0f',delta,nL,nC))

   plot(xl,yl,'o',xc,yc,'*')
   legend('Lin.','Cub.',2)
   pause
end
