% Problem P3_2_1
%
% Apply pwcStatic to exp(-2x)sin(10pi*x) on [0,1].

close all
alpha = 0;
beta = 1;
delta = .001;
z = linspace(0,1)';
fz = feval('MyF321',z);
for M4 = [100 1000 10000 100000 1000000]
   [a,b,c,d,x] = pwCStatic('MyF321','dMyF321',M4,alpha,beta,delta);
   Cvals = pwCEval(a,b,c,d,x,z);
   err = max(abs(Cvals-fz));
   figure
   plot(z,fz,z,Cvals,x,feval('MyF321',x),'o')
   title(sprintf('M4 = %3.0e     n = %2.0f    delta = %2.0e   error = %2.0e',M4,length(x),delta,err))
end