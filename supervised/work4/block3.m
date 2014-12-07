% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

input('Block 3: Training linear threshold regressor... press enter');
% 1) In this model you have to learn the threshold value. It is 0.

% 2) Report the normal vector of the separating hyperplane for each data set

ws1 = alinealreg(D1,y);
disp('Vector defining hyperplane for D1 (Analitically Derived):');
dispvarray(ws1);
disp('Normalized:');
dispvarray(ws1/norm(ws1));

ws2 = alinealreg(D2,y);
disp('Vector defining hyperplane for D2 (Analitically Derived):');
dispvarray(ws2);
disp('Normalized:');
dispvarray(ws2/norm(ws2));

ws3 = alinealreg(D3,y);
disp('Vector defining hyperplane for D3 (Analitically Derived):');
dispvarray(ws3);
disp('Normalized:');
dispvarray(ws3/norm(ws3));

[wsgd , conv_m] = gdescent(D2,y,1e-5,1e-6,10000,false);
disp('Vector defining hyperplane for D1 (Gradient Descent):');
dispvarray(wsgd);
disp('Normalized:');
dispvarray(wsgd/norm(wsgd));


% 3) Compute the error rates achieved on the training data
input('Computing error rates for classifiers based on D1, D2, D3... press enter');

[cost1, err1] = costnerr(D1, ws1, y);

disp(['Results for D1 (Analitical): Cost: ', num2str(cost1), ' Error (False)%: ', num2str(err1)]);

[cost2, err2] = costnerr(D2, ws2, y);

disp(['Results for D2 (Analitical): Cost: ', num2str(cost2), ' Error (False)%: ', num2str(err2)]);

[cost3, err3] = costnerr(D3, ws3, y);

disp(['Results for D3 (Analitical): Cost: ', num2str(cost3), ' Error (False)%: ', num2str(err3)]);

[costgd, errgd] = costnerr(D2, wsgd, y);

disp(['Results for D1 (Gradient Descent): Cost: ', num2str(costgd), ' Error (False)%: ', num2str(errgd)]);

