% Script File: Clouds
% 2-dimensional pictures of the uniform and normal distributions.

close all
Points = rand(1000,2);
subplot(1,2,1)
plot(Points(:,1),Points(:,2),'.')     
title('Uniform Distribution.')
axis([0 1 0 1])
axis square
Points = randn(1000,2);
subplot(1,2,2)
plot(Points(:,1),Points(:,2),'.')    
title('Normal Distribution.')
axis([-3 3 -3 3])
axis square