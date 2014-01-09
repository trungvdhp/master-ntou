% Script P5_2_11
%
% Structured Matrix-vector multiplication

clc
close all

n = 20;
k = 30;
P = SetUp(n-1);
v0 = rand(n,1);
v0 = (v0 + v0(n:-1:1))/2;
V = Forward(P,v0,k);
for j=1:k
   plot(V(:,j))
   title(sprintf('j = %1d',j))
   pause(1)
end
hold off