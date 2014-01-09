% Script 5_2_5
%
% Illustrate (Lower Triangular)*(Upper Triangular) products

A = tril(rand(6,6))
B = triu(rand(6,6))
C = MatMatDot1(A,B)
Error = C - A*B