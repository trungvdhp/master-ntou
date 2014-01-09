function C = MyStrass(A,B,nmin)
% C = MyStrass(A,B)
%
% A,B are n-by-n matrices, n a power of 2.
% nmin is the regukar matrix multiply threshold, a positive integer.
% C is an n-by-n matrix equal to A*B. 
    
[n,n] = size(A);
if n <= nmin
   C = A*B;
else
   m  = floor(n/2); u = 1:m; v = m+1:2*m;     
   P1 = MyStrass(A(u,u)+A(v,v),B(u,u)+B(v,v),nmin);
   P2 = MyStrass(A(v,u)+A(v,v),B(u,u),nmin);
   P3 = MyStrass(A(u,u),B(u,v)-B(v,v),nmin);
   P4 = MyStrass(A(v,v),B(v,u)-B(u,u),nmin);
   P5 = MyStrass(A(u,u)+A(u,v),B(v,v),nmin);
   P6 = MyStrass(A(v,u)-A(u,u),B(u,u) + B(u,v),nmin);
   P7 = MyStrass(A(u,v)-A(v,v),B(v,u)+B(v,v),nmin);
   C = [ P1+P4-P5+P7   P3+P5; P2+P4 P1+P3-P2+P6];
   
   if 2*m < n
      % The odd n case.
      % Partition A = [A(1:n-1:n-1) u; v alfa] 
      % Partition B = [B(1:n-1:n-1) w; y alfa] 
      u = A(1:n-1,n); v = A(n,1:n-1); alfa = A(n,n);
      w = B(1:n-1,n); y = B(n,1:n-1); beta = B(n,n);
      % Perform the 2-by-2 block multiply using Strassen multiply in the 
      % (1,1) block.
      C = [C+u*y   A(1:2*m,1:2*m)*w+beta*u  ; v*B(1:2*m,1:2*m)+alfa*y  v*w+alfa*beta];
   end
end