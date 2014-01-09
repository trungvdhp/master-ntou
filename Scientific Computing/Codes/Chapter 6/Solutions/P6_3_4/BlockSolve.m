function [y,z] = BlockSolve(A,B,C,g,h)
% [y,z] = BlockSolve(A,B,C,g,h)
%
% A,B,C are n-by-n matrices with A and C nonsingular
% g,h are column n-vectors
%
% y,z are column n-vectors so Ay+Bz = g and Cz = h.

z = C\h;
y = A\(g-B*z);