% Script P5_5_2
%
% Explores when it pays to do a 2-processor matrix-vector
% multiply.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time for single processor execution:
% T_seq = (2*n^2)/R;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Let n = 2m and set top = 1:m and bot = (m+1):n.
% Proc(1) sends A(bot,:) to Proc(2)
% T_send_mat = alpha + (n^2/2)*beta;
% Proc(1) computes y(top) = A(top,:)*x and Proc(2) computes
% y(bot) = A(bot,:)*x. 
% T_work = (n^2)/R;
% Proc(2) sends y(bot) to Proc(1)
% T_send_vec = alpha + (n/2)*beta;
% Total execution time:
% T_par = 2*alpha + beta*n*(n+1)/2 + (n^2)/R;
% Comparison quotient T_par/T_seq:
% T_ratio = .5*(1+beta*R/2) + (alpha*R/n^2) + (beta*R)/(4*n);
% Thus, if beta*R&lt2 then for sufficiently large n, it pays
% to distribute the computation.

clc
disp('R = 1/beta     alpha    Minimum n')
disp('-----------------------------------')  
for R = [10^5  10^6  10^7  10^8  10^9]
   beta = 1/R; %safe by a factor of two
   for alpha = [10^(-3) 10^(-4) 10^(-5) 10^(-6)]
      %compute the smallest n so that it pays to distribute.
      n = ceil((1 + sqrt(1+16*alpha*R))/2);
      
      disp(sprintf('  %6.1e    %6.1e  %8.0f',R,alpha,n))
   end
   disp(' ')
end