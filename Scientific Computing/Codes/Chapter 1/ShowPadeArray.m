% Script File: ShowPadeArray
% Illustrates the function PadeArray that creates a cell array.

  clc
  P = PadeArray(5,5);
  for i=1:5
     for j=1:5
        disp(sprintf('\n (%1d,%1d) Pade Coefficients:\n',i-1,j-1))
        disp(['    ' sprintf('%7.4f  ',P{i,j}.num)])
        disp(['    ' sprintf('%7.4f  ',P{i,j}.den)])
     end
  end
