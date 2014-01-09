% Script File: RunUpDown
% Environment for studying the up/down sequence.
% Stores selected results in file UpDownOutput.

while(input('Another Example? (1=yes, 0=no)'))
   diary UpDownOutput
   UpDown
   diary off
   disp(' ')
   if (input('Keep Output? (1=yes, 0=no)')~=1)
      delete UpDownOutput
   end
end