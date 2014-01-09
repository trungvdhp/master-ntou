function ShowNonZeros(A)
% Displays the sparsity structure of an n-by-n matrix A.
% It is best that n<=30.

close all
[n,n] = size(A);
s = 1/n;
m = round(200/n);
figure
axis([0 1 0 1])
axis ij equal off
HA = 'HorizontalAlignment';
VA = 'VerticalAlignment';
for i=1:n
   for j=1:n
      if A(i,j)==0
         text(i*s,(j-.3)*s,'.',HA,'center');
      else
         text(i*s,j*s,'X','FontWeight','bold','FontSize',m,HA,'center');
      end
   end
end