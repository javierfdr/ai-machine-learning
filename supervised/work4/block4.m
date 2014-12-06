% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1) Repeat the learning process in block 3 using just D2 but holding-out
% the last fifth of the data set for testing purposes, i.e. use the first
% 4/5-th for training and the last 1/5-th for testing. Follow exactly the
% following steps in your process:

% a) Clear your workspace: clear all, close all, clc
input('Cleaning up before entering block 4... press enter');
clear all
close all
clc
input('Block 4: Training linear threshold regressor with holding out... press enter');

% b) Preprocess the data using the method for creating D2 .
load('diabetes.mat');
D2 = nans2mean(x,y,true);

% c) Split your data in two sets: the first 4/5-th is to be used for
% training and the last 1/5-th will be used for testing purposes.
splitpoint = round(size(D2,2)*4/5);
D2train = D2(:,1:splitpoint);
D2test = D2(:,splitpoint+1:size(D2,2));

ytrain = y(1:splitpoint);
ytest = y(splitpoint+1:size(D2,2));

%d) Train your model on the training set.
ws2t = alinealreg(D2train,ytrain);
disp('Vector defining hyperplane for D2 holding out 1/5:');
disp(ws2t);

% e) Answer the following questions: Which is the error rate on your
% training data? Which is the error rate on your test data? Are they
% similar? Did you expect that behavior? Why?
[cost2t, err2t] = costnerr(D2train, ws2t, ytrain);

disp(['Results for D2 Training Set: Cost: ', num2str(cost2t), ' Error (False)%: ', num2str(err2t)]);

[cost2test, err2test] = costnerr(D2test, ws2t, ytest);

disp(['Results for D2 Test Set: Cost: ', num2str(cost2test), ' Error (False)%: ', num2str(err2test)]);


