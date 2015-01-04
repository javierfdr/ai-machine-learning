% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 5
clear all; close all; clc;
load example_dataset_1.mat;

dataT = data';

sizeData = size(dataT,1);

% splitting data to divide training and test set
p=randperm(size(dataT,1));
fifth = sizeData/5;

% since p is random positions then taking the first fifth does not 
% affect
TestData = dataT(p(1:fifth),:);
TestLabels = labels(p(1:fifth),:);
dataT = dataT(p(fifth+1:size(dataT,1)),:);
labels = labels(p(fifth+1:sizeData),:);

K = 5;
[TrainingFolds, ValidationFolds] = buildFoldValidationSets(dataT, K);
input('Press enter to calculate and show the best configuration for Decision Trees');


%Testing RBF with cross validation


% Testing Decision Trees with cross validation
% testing for minparent from 1 to 10 (size/10).
errorLabelTest = [];
meanErrorTest = [];
errorLabelTrain = [];
meanErrorTrain = [];

bestMinParent = -1;
bestError = realmax;

numMinParent = 15;

for p=1:numMinParent
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
    
    currentMinError = mean(errorLabelTest);
    if currentMinError < bestError
        bestError = currentMinError;
        bestMinParent = p;
    end    
    
    meanErrorTest = [meanErrorTest;mean(errorLabelTest)];
    meanErrorTrain = [meanErrorTrain;mean(errorLabelTrain)];
end

disp('Mean Error Test');
disp(meanErrorTest);
disp('Best Error');
disp(bestError);
disp('Best minparent');
disp(bestMinParent);

% calculating with best min parent against test set
tree = classregtree(dataT,labels,'minparent',bestMinParent);

% testing tree against test data
y = tree(TestData);
[error,accuracy] = getClassificationError(y,TestLabels);
disp(strcat('Error with minParent',num2str(bestMinParent)));
disp(error);




