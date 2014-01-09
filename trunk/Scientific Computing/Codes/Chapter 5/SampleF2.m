  function F = SampleF2(x,y)
% A function of 2 variables with strong local maxima at (.3,.4) and (.7,.3).

F = zeros(length(y),length(x));
for j=1:length(x)
   F(:,j) =  1./( ((x(j)-.3).^2 + .1)*((y-.4).^2 + .1)) + 1./( ((x(j)-.7).^2 + .2)*((y-.3).^2 + .2)) - 6;
end