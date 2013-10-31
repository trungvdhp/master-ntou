% CellTest.m
% Create a cell 
% C = cell(m,n) structure, it is similar to submatrices
% Every entry can be considered as a drawer or a cell, which can store
% all data of different types.

C = cell(2,2);
C{1,1} = [1 2; 3 4];
C{1,2} = [ 5; 6];
C{2,1} = [7 8];
C{2,2} = 9;
C
M = [C{1,1} C{1,2};C{2,1} C{2,2}]

% Cell indexing
A = cell(2,3);
A(1,1) = {'The city name is New York'};
A(1,2) = {'latitude and longitude'};
A(1,3) = {[16 23 47; 74 2 32]};
A(2,1) = {'The city name is Ithaca'};
A(2,2) = {'latitude and longitude'};
A(2,3) = {[42 25 26; 77 29 41]};
A
N = A(1,1) 
L = A(1,2) 
A(1,3)
celldisp(A)
celldisp(A(2,3))

% Content indexing
B = cell(2,3);
B{1,1} = {'The city name is New York'};
B{1,2} = {'latitude and longitude'};
B{1,3} = {[16 23 47; 74 2 32]};
B{2,1} = {'The city name is Ithaca'};
B{2,2} = {'latitude and longitude'};
B{2,3} = {[42 25 26; 77 29 41]};
B
celldisp(B)
N = B{1,1} 
L = B{1,2} 
N1= B(1,3)
N2 = B{1,3}
celldisp(A)
cellplot(A)
