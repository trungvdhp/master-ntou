% Script TestStrass.m
V=2:9
A=vander(V')
C=1:2:15
R=[1 2:2:14]
B=toeplitz(C',R')
nmin=8
C=Strass(A,B,nmin)

