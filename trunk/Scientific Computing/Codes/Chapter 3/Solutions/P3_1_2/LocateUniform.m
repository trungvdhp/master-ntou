function i = LocateUniform(alpha,beta,n,z)
% alpha<=z<=beta and n a positive integer >=2
% x(i)<=z<=x(i+1) where x = linspace(alpha,beta,n)
h = (beta-alpha)/(n-1);
i = max(ceil((z-alpha)/h),1);
