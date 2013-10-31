
% Script File: upDown3 = RunUpDown Sec.1.3  p.33
% Environment for studying the up/down sequence.
% Stores selected results in file UpDownOutput.

while(input('Another Example? (1 = Yes, 0 = No)'))
   diary UpDownOutput
   x = UpDown;
   diary off
   if (input('Keep Output? (1 = Yes, 0 = No)') ~= 1)
   delete UpDownOutput
   end
end