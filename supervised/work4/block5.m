% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1) Repeat the process in block 4 changing the order of some of the steps.
% Follow exactly the following steps in your process:

% a) Clear your workspace: clear all, close all, clc
input('Cleaning up before entering block 5... press enter');
clear all
close all
clc
input('Block 5: Training linear threshold regressor with holding out (different order)... press enter');

% b) Split your data in two sets: the first 4/5-th is to be used for 
% training and the last 1/5-th will be used for testing purposes.
load('diabetes.mat');

splitpoint = round(size(x,2)*4/5);
xtrain = x(:,1:splitpoint);
xtest = x(:,splitpoint+1:size(x,2));

ytrain = y(1:splitpoint);
ytest = y(splitpoint+1:size(x,2));

% c) Preprocess the data replacing the NaN using the method for creating D2 .
% But this time use only the data corresponding to the training set.
D2train = nans2mean(xtrain,ytrain,true);

% d) Train your model on the training set.
ws2t = alinealreg(D2train,ytrain);
disp('Vector defining hyperplane for D2 holding out 1/5:');
dispvarray(ws2t);

% e) Replace the NaN values using the means computed on the training data %training or test???
meanattrspt = nanmean(xtrain(:,ytrain==1),2);    
meanattrsnt = nanmean(xtrain(:,ytrain==-1),2);

D2test = xtest;
D2test(isnan(xtest)) = 0;
D2test(:,ytest==1) = D2test(:,ytest==1) + repmat(meanattrspt,1,size(xtest(:,ytest==1),2)).*(isnan(xtest(:,ytest==1)));
D2test(:,ytest==-1) = D2test(:,ytest==-1) + repmat(meanattrsnt,1,size(xtest(:,ytest==-1),2)).*(isnan(xtest(:,ytest==-1)));

% f) Answer the following questions: Which is the error rate on your training
% data? Which is the error rate on your test data? Are they similar? Did you
% expect that behavior? Why?

[cost2t, err2t] = costnerr(D2train, ws2t, ytrain);

disp(['Results for D2 Training Set: Cost: ', num2str(cost2t), ' Error (False)%: ', num2str(err2t)]);

[cost2test, err2test] = costnerr(D2test, ws2t, ytest);

disp(['Results for D2 Test Set: Cost: ', num2str(cost2test), ' Error (False)%: ', num2str(err2test)]);

% g) Compare these results with the ones in block 4. Do we achieve better or
% worse results? Why?
