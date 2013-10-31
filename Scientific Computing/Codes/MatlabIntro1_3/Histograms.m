% Script File: Histograms
% It presents statistical data.
% Histograms of rand(lOOO, l) and randn(1000, 1) .

close all
subplot(2,1,1)
x = rand(1000,1);
hist(x,30)
axis([-1 2 0 60])
title('Distribution of Values in rand(1000, 1)')
xlabel(sprintf('Mean = %5.3f. Median = %5.3f .' ,mean(x), median(x)))
subplot(2,1,2)
x = randn(1000, 1);
hist(x, linspace(-2.9,2.9,100)) % the bin locations can be specified by passing hist a vector.
title('Distribution of Values in randn(1000, 1)')
xlabel(sprintf('Mean = %5.3f. Standard Deviation = %5.3f ', mean(x), std(x)))