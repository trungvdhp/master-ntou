% Script P5_1_3
%
% Embeddig a Toeplitz matrix into a circulant matrix.

clc
row = [10 20 30 40 50];
col = [10; 200; 300; 400; 500];
T = toeplitz(col,row)
C = EmbedToep(col,row)