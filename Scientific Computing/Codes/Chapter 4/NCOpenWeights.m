  function w = NCOpenWeights(m)
% w = NCOpenWeights(m)
%
% w is a column m-vector consisting of the weights for the m-point open
% Newton-Cotes rule. m is an integer that satisfies 1 <= m <= 7.

if      m==1,   w = [1];
elseif  m==2,   w = [1 1]'/2;
elseif  m==3,   w = [2 -1 2]'/3; 
elseif  m==4,   w = [11 1 1 11]'/24;
elseif  m==5,   w = [11 -14 26 -14 11]'/20;
elseif  m==6,   w = [611 -453 562 562 -453 611]'/1440;
else            w = [460 -954 2196 -2459 2196 -954 460]'/945;
end