% Problem P4_1_2
%
% Computing the NC weights via a linear system solve

clc 
disp(' m    norm(NCweights(m)-MyNCweights(m)')
disp('-------------------------------------')
for m=2:11
   disp(sprintf('%2.0f   %20.16f',m,norm(NCweights(m)-MyNCweights(m))))
end