X = [ -5, 0; -3.34, 1.67; -3.34, 0; -3.34, -1.67; -1.67, 0; 1.67, 0; 3.34, 1.67; 3.34, 0; 3.34, -1.67; 5, 0; 0, 0; 0, 10];
[cv, cent, nits, err] = fcm(X,2,100,2,1e-6)
