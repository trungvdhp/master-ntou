function B = MatPower(A,k)
% A is an n-by-n matrix and k is a positive integer.
% B = A^k
s = '';
x = k;
while x>=1
   if rem(x,2)==0
      s = ['0' s];
      x = x/2;
   else
      s = ['1' s];
      x = (x-1)/2;
   end
end
C = A;
First = 0;
for j=length(s):-1:1
   if s(j)=='1'
      if First==0
         B = C;
         First =1;
      else
         B = B*C;
      end
   end
   C = C*C;
end