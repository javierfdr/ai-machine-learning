input('testing pfcm with X10... press enter to continue');
X10 = [ -5, 0; -3.34, 1.67; -3.34, 0; -3.34, -1.67; -1.67, 0; 1.67, 0; 3.34, 1.67; 3.34, 0; 3.34, -1.67; 5, 0];
tic
[cv, fcv, pcv, cent, nits, err] = pfcm(X10,2,100,2,2,1,1,1e-6, true)
toc
input('testing pfcm with X12... press enter to continue');
X12 = [ -5, 0; -3.34, 1.67; -3.34, 0; -3.34, -1.67; -1.67, 0; 1.67, 0; 3.34, 1.67; 3.34, 0; 3.34, -1.67; 5, 0; 0, 0; 0, 10];
tic
[cv, fcv, pcv, cent, nits, err] = pfcm(X12,2,100,2,2,1,1,1e-6, true)
toc