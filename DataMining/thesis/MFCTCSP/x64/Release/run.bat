rem MFCTCSP with termination criteria
rem D
mfctcsp ss1K.dat 0.005 5 16 3 T1K.out
mfctcsp ss2K.dat 0.005 5 16 3 T1K.out
mfctcsp ss3K.dat 0.005 5 16 3 T1K.out
mfctcsp ss4K.dat 0.005 5 16 3 T1K.out
mfctcsp ss5K.dat 0.005 5 16 3 T1K.out
rem minimum sup
mfctcsp ss1K.dat 0.002 5 16 3 T1K.out
mfctcsp ss1K.dat 0.003 5 16 3 T1K.out
mfctcsp ss1K.dat 0.004 5 16 3 T1K.out
mfctcsp ss1K.dat 0.005 5 16 3 T1K.out
mfctcsp ss1K.dat 0.01 5 16 3 T1K.out
mfctcsp ss1K.dat 0.02 5 16 3 T1K.out
rem minimum gap
mfctcsp ss1K.dat 0.005 1 16 3 T1K.out
mfctcsp ss1K.dat 0.005 2 16 3 T1K.out
mfctcsp ss1K.dat 0.005 4 16 3 T1K.out
mfctcsp ss1K.dat 0.005 6 16 3 T1K.out
mfctcsp ss1K.dat 0.005 8 16 3 T1K.out
mfctcsp ss1K.dat 0.005 10 16 3 T1K.out
mfctcsp ss1K.dat 0.005 12 16 3 T1K.out
rem maximum gap
mfctcsp ss1K.dat 0.005 5 6 3 T1K.out
mfctcsp ss1K.dat 0.005 5 8 3 T1K.out
mfctcsp ss1K.dat 0.005 5 10 3 T1K.out
mfctcsp ss1K.dat 0.005 5 12 3 T1K.out
mfctcsp ss1K.dat 0.005 5 14 3 T1K.out
rem sliding
mfctcsp ss1K.dat 0.005 5 16 1 T1K.out
mfctcsp ss1K.dat 0.005 5 16 2 T1K.out
mfctcsp ss1K.dat 0.005 5 16 4 T1K.out