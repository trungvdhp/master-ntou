
% Script File: ShowQNC
% Examines the closed Newton-Cotes rules.

while input('Another exammple? (l=yes, 0=no). ')
   fname = input('Enter within quotes the name of the integrand function:');
   a = input('Enter left endpoint: ');
   b = input('Enter right endpoint: ');
   s = ['QNC(''' fname '''' sprintf(',%6.3f,%6.3f, m)',a, b)];
  %   clc
   disp(['  m     ' s])
   disp(' ')
   for m=2:11,
      numI = QNC(fname,a,b,m);
      disp(sprintf(' %2.0f     %20.16f', m, numI))
   end 
end