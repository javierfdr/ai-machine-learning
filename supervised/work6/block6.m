% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 6
clear all; close all; clc;
load example_dataset_1.mat;

input('Press enter to calculate and show the best configuration for RBF SVM');

dataT = data';
K = 5;
[TrainingFolds, ValidationFolds] = buildFoldValidationSets(dataT, K);

% Testing RBF SVM with cross validation
errorLabelTest = [];
meanErrorTest = [];
errorLabelTrain = [];
meanErrorTrain = [];

bestSigmaEver = realmax;
bestLambdaEver = realmax;
bestErrorEver = realmax;
bestCount = 0;
listErrors = [];

count = 0;

for f=1:K 
    bestSigma = -1;
    bestLambda = -1;
    bestError = realmax;
    for sigma=0.5:-0.1:0.1
        errorLabelTest = [];
        meanErrorTest = [];
        errorLabelTrain = [];
        meanErrorTrain = [];        
        for c=1:1:20
            count = count+1;
            disp(strcat('Iter:',num2str(count),' Lambda: ',num2str(c),' Sigma: ',num2str(sigma)));

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
    
    disp(strcat('For K=',num2str(f),' best lambda is: ',num2str(bestLambda),' best sigma: ',num2str(bestSigma),' best error: ',num2str(bestError)));
    listErrors = [listErrors;bestError];
    
    if (bestError < bestErrorEver)
        bestErrorEver = bestError;
        bestSigmaEver = bestSigma;
        bestLambdaEver = bestLambda;        
    end  
    
end

disp('Best Error');
disp(bestErrorEver);
disp('Best Sigma');
disp(bestSigmaEver);
disp('Best Lambda');
disp(bestLambdaEver);
disp('Mean Error');
disp(mean(listErrors));


input('Press enter to calculate and show the best configuration for Decision Trees');

% Testing Decision Trees with nested cross validation
% testing for minparent from 1 to 15
errorLabelTest = [];
meanErrorTest = [];
errorLabelTrain = [];
meanErrorTrain = [];

listErrors = [];

bestMinParentEver = realmax;
bestErrorEver = realmax;

numMinParent = 15;
for f=1:K 
    errorLabelTest = [];
    meanErrorTest = [];
    errorLabelTrain = [];
    meanErrorTrain = [];

    bestMinParent = -1;
    bestError = realmax;    
    for p=1:numMinParent

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

        currentMinError = mean(errorLabelTest);
        if currentMinError < bestError
            bestError = currentMinError;
            bestMinParent = p;
        end    

        meanErrorTest = [meanErrorTest;mean(errorLabelTest)];
        meanErrorTrain = [meanErrorTrain;mean(errorLabelTrain)];
    end
    disp(strcat('For K=',num2str(f),' best minparent is: ',num2str(bestMinParent),' and best error: ',num2str(bestError)));
    listErrors = [listErrors;bestError];
    
    if (bestError < bestErrorEver)
        bestMinParentEver = bestMinParent;
        bestErrorEver = bestError;
    end
end

disp('Best Error');
disp(bestErrorEver);
disp('Best minparent');
disp(bestMinParentEver);

disp('Mean Error');
disp(mean(listErrors));

