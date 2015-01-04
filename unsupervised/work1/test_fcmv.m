input('testing fcm with X10... press enter to continue');
X10 = [ -5, 0; -3.34, 1.67; -3.34, 0; -3.34, -1.67; -1.67, 0; 1.67, 0; 3.34, 1.67; 3.34, 0; 3.34, -1.67; 5, 0];
tic
[cv, fcv, cent, nits, err] = fcmv(X10,2,100,2,1e-6, true)
toc
input('testing fcm with X12... press enter to continue');
X12 = [ -5, 0; -3.34, 1.67; -3.34, 0; -3.34, -1.67; -1.67, 0; 1.67, 0; 3.34, 1.67; 3.34, 0; 3.34, -1.67; 5, 0; 0, 0; 0, 10];
tic
[cv, fcv, cent, nits, err] = fcmv(X12,2,100,2,1e-6, true)
toc
