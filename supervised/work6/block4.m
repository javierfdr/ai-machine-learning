% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 1
clear all; close all; clc;
load example_dataset_1.mat;

input('Press enter to calculate and show the best configuration for RBF SVM');

dataT = data';
K = 5;
[TrainingFolds, ValidationFolds] = buildFoldValidationSets(dataT, K);

% Testing Decision Trees with cross validation
% testing for minparent from 1 to 10 (size/10).
errorLabelTest = [];
meanErrorTest = [];
errorLabelTrain = [];
meanErrorTrain = [];

bestSigma = -1;
bestLambda = -1;
bestError = realmax;
bestCount = 0;

count = 0;

for sigma=0.5:-0.1:0.1
    for c=1:1:20
        count = count+1;
        disp(strcat('Iter:',num2str(count),' Lambda: ',num2str(c),' Sigma: ',num2str(sigma)));
        for f=1:K        
            vf = ValidationFolds(f,:);
            tf = TrainingFolds(f,:);

            tdata = dataT(tf',:);
            tlabels = labels(tf');

            %tree = classregtree(tdata,tlabels,'minparent',p);
            [afunc,sv,v,error] = train_soft_margin_dual_rbf(tdata,tlabels',c,sigma);
            
            vdata = dataT(vf',:);

            % testing tree against test data
            y = sign(afunc(vdata'));
            vlabels = labels(vf');
            
            [error,accuracy] = getClassificationError(y,vlabels);
            errorLabelTest = [errorLabelTest;error];
            
            y = sign(afunc(tdata'));
            [error,accuracy] = getClassificationError(y,tlabels);
            errorLabelTrain = [errorLabelTrain;error];

        end
        
        currentMeanError = mean(errorLabelTest);
        if currentMeanError < bestError
            bestError = currentMeanError;
            bestSigma = sigma;
            bestLambda = c;
            bestCount = count;
        end
        
        meanErrorTest = [meanErrorTest;mean(errorLabelTest)];
        meanErrorTrain = [meanErrorTrain;mean(errorLabelTrain)];
    end
end
disp('Mean Error Test');
disp(meanErrorTest);
disp('Best Error');
disp(bestError);
disp('Best Sigma');
disp(bestSigma);
disp('Best Lambda');
disp(bestLambda);

% plotting error surface
% h = figure('name','Mean error for different minparent values on Decision Tree');
% plot([1:count],meanErrorTest','rx'); hold on;
% plot([1:count],meanErrorTest','r-'); hold on;

% plotting error surface
h = figure('name','Train vs Test Mean error for different minparent values on SVM RBF');
plot([1:count],meanErrorTest','rx'); hold on;
plot([1:count],meanErrorTest','r-'); hold on;
plot([1:count],meanErrorTrain','bo'); hold on;
plot([1:count],meanErrorTrain','b-'); hold on;
plot([1:count],abs(meanErrorTest'-meanErrorTrain'),'g'); hold on;

input('Press enter to calculate and show the best configuration for Decision Trees');

% Testing Decision Trees with cross validation
% testing for minparent from 1 to 10 (size/10).
errorLabelTest = [];
meanErrorTest = [];
errorLabelTrain = [];
meanErrorTrain = [];
for p=1:15
    for f=1:K        
        vf = ValidationFolds(f,:);
        tf = TrainingFolds(f,:);
        
        tdata = dataT(tf',:);
        tlabels = labels(tf');

        
        tree = classregtree(tdata,tlabels,'minparent',p);
        vdata = dataT(vf',:);
        
        % testing tree against test data
        y = tree(vdata);
        vlabels = labels(vf');
        [error,accuracy] = getClassificationError(y,vlabels);
        errorLabelTest = [errorLabelTest;error];
        
        % testing tree agains training data (to understand overfitting)
        y = tree(tdata);
        [error,accuracy] = getClassificationError(y,tlabels); 
        errorLabelTrain = [errorLabelTrain;error];
        
    end
    meanErrorTest = [meanErrorTest;mean(errorLabelTest)];
    meanErrorTrain = [meanErrorTrain;mean(errorLabelTrain)];
end
disp(meanErrorTest);

% plotting error surface
h = figure('name','Mean error for different minparent values on Decision Tree');
plot([1:15],meanErrorTest','rx'); hold on;
plot([1:15],meanErrorTest','r-'); hold on;

% plotting error surface
h = figure('name','Train vs Test Mean error for different minparent values on Decision Tree');
plot([1:15],meanErrorTest','rx'); hold on;
plot([1:15],meanErrorTest','r-'); hold on;
plot([1:15],meanErrorTrain','bo'); hold on;
plot([1:15],meanErrorTrain','b-'); hold on;
