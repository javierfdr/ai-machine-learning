% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

input('Cleaning up before entering block 6... press enter');
clear all
close all
clc
input('Block 6: Calculating VCDims... press enter');
load('diabetes.mat');

% 1) Repeat the process in block 5 changing the percentage of the data for
% training and testing. Plot a graph with the training and test error rates
% for each splitting percentage point. Comment the results.

splitpercs = [ 0.25, 0.50, 0.65, 0.75, 0.85, 0.90, 0.95 ];
costs = [];

disp('');
for sp = splitpercs
    disp(['Dataset Split: %train :', num2str(sp*100),' %test :', num2str((1-sp)*100)]);
    splitpoint = round(size(x,2)*sp);
    xtrain = x(:,1:splitpoint);
    xtest = x(:,splitpoint+1:size(x,2));

    ytrain = y(1:splitpoint);
    ytest = y(splitpoint+1:size(x,2));

    D2train = nans2mean(xtrain,ytrain,true);

    ws2t = alinealreg(D2train,ytrain);

    meanattrspt = nanmean(xtrain(:,ytrain==1),2);    
    meanattrsnt = nanmean(xtrain(:,ytrain==-1),2);

    D2test = xtest;
    D2test(isnan(xtest)) = 0;
    D2test(:,ytest==1) = D2test(:,ytest==1) + repmat(meanattrspt,1,size(xtest(:,ytest==1),2)).*(isnan(xtest(:,ytest==1)));
    D2test(:,ytest==-1) = D2test(:,ytest==-1) + repmat(meanattrsnt,1,size(xtest(:,ytest==-1),2)).*(isnan(xtest(:,ytest==-1)));

    [cost2t, err2t] = costnerr(D2train, ws2t, ytrain);

    disp(['Results for D2 Training Set: Cost: ', num2str(cost2t), ' Error (False)%: ', num2str(err2t)]);

    [cost2test, err2test] = costnerr(D2test, ws2t, ytest);

    disp(['Results for D2 Test Set: Cost: ', num2str(cost2test), ' Error (False)%: ', num2str(err2test)]);

% 2) Add to the plot the upper bound on the generalization error using the
% equation of the slides for VC dimension equal to d + 1. Discuss the result.

    upbound = vcdimlinbound(D2train,cost2t,0.95);
    disp(['Upperbound for D2 Test Set: Cost: ', num2str(cost2test)]);
    
    costs = [costs,[cost2t;cost2test;upbound]];
    disp('- - -');
    
end
disp('');

figure('name','Errors and VCdim');
plot(splitpercs,costs(1,:),'-b.',splitpercs,costs(2,:),'-g.',splitpercs,costs(3,:),'-r.');
legend('Training set cost','Test set cost', 'VC dim upper bound');
xlabel('training set percentage');
ylabel('cost');

% 3) How many samples does the bound predict in order to have 1% error
% deviation with a confidence of 95%? And with confidence 50%? What about 5%
% and 10% error deviation with 95% confidence? Comment the behavior according
% to your observations.
    disp('Number of samples required for the bound with: ');
    confdevs = [ 0.95, 0.01 ; 0.50, 0.01 ; 0.95, 0.05 ; 0.95, 0.10 ];
    for i = 1:size(confdevs,1)
        conf = confdevs(i,1);
        dev = confdevs(i,2);
        boundsamples = nsamplesvcdim(size(D2train,1), conf, dev);
        disp(['confidence: ', num2str(conf), ' deviation: ', num2str(dev),' n.samples: ', num2str(boundsamples)]);
    end

