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
for sigma=[0.5:0.1:1.5]
    for c=[0.5:0.5:5]
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
            [error,accuracy] = getTreeError(y,vlabels);
            errorLabelTest = [errorLabelTest;error];

            % testing tree agains training data (to understand overfitting)
            y = tree(tdata);
            [error,accuracy] = getTreeError(y,tlabels); 
            errorLabelTrain = [errorLabelTrain;error];

        end
        meanErrorTest = [meanErrorTest;mean(errorLabelTest)];
        meanErrorTrain = [meanErrorTrain;mean(errorLabelTrain)];
    end
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
        [error,accuracy] = getTreeError(y,vlabels);
        errorLabelTest = [errorLabelTest;error];
        
        % testing tree agains training data (to understand overfitting)
        y = tree(tdata);
        [error,accuracy] = getTreeError(y,tlabels); 
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




