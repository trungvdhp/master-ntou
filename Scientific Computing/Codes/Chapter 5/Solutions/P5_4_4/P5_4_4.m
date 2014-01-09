% Script 5_4_4
%
% Compare Strass and conventional matrix multiply

clc 
disp('  q     r   (Strass Flops)/(Conventional Flops)')
disp('-------------------------------------------------')
for q = 1:20
   n = 2^q;
   flop_min = StrassCount(n,1);
   rmin = 0;
   for r=1:q
      f = StrassCount(n,2^r);
      if f<flop_min
         flop_min = f;
         rmin = r;
      end
   end
   disp(sprintf(' %2.0f    %2.0f   %15.2f ',q,rmin,flop_min/(2^(3*q+1))))
end