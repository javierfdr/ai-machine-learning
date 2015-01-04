function [error, FP, FN, TP, TN] = fold_validation(features, labels, subjects, NFolds)
% FOLD VALIDATION: compute the classification rates of validation after
%classification.
% Inputs:
% features: each columns is a sample and each row is a variable or feature:
% Variables x Samples
% labels: 1xS it contains all the labels (1 patients, 0 controls)
% subjects
% F: F fold validation will be used
% Outputs: vectors containing the rates of validation after classification.

%% Estimate the number of subjects for every fold
id_subjects = unique(subjects);
% We assume that all the subjects have the same number of images samples:
NOcc = sum(subjects==id_subjects(1));
Nsubjects = length(id_subjects);
Ntest = floor(Nsubjects/NFolds);

%% Randomly sort the data set before validation
p=randperm(Nsubjects);
id_subjects=id_subjects(p);

%% Loop of NFolds 
best_error_mean = 1;
best_error = [];
best_k = 1;
best_fp = []; 
best_fn = [];
best_tp = []; 
best_tn = [];
k_errors = [];
for k=1:2:21
    for i = 1:NFolds

        if i==NFolds
            n = id_subjects((i-1)*Ntest+1:i*Ntest);    
        else
            n = id_subjects((i-1)*Ntest+1:i*Ntest);    
        end

        index=ismember(subjects,n);

        % 9. To complete:
        % Answer this question: 
        % c. What is contained in 'n' and in 'index'?
        % n contains the fold, this is the group of samples that are going 
        % to be used for training and then test against the test samples. The
        % fold contain samples from different users.
        % index contains a vector that indicates for every sample if the sample
        % belongs to the one of the users selected or not.

        % Load Training Set     
        TrainSet = features(:,find(index ~= 1)');
        TrainLabels=labels(:,find(index ~= 1)');

        % Load Test Set
        TestSet  = features(:,find(index == 1)');
        TestLabel = labels(:,find(index == 1)');
        NTest = length(TestLabel);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Normalization    
        T_TrainSet=TrainSet';
        T_TestSet=TestSet';

        % Compute mean and variance:
        m=mean(T_TrainSet);
        v=std(T_TrainSet);

        % Normalize Training Set:
        mMatrix = ones (size(T_TrainSet,1), 1) * m;
        vMatrix = ones (size(T_TrainSet,1), 1) * v;
        T_TrainSet=(T_TrainSet-mMatrix)./vMatrix;

        % Normalize Test Set:
        mMatrix = ones (size(T_TestSet,1), 1) * m;
        vMatrix = ones (size(T_TestSet,1), 1) * v;    
        T_TestSet=(T_TestSet-mMatrix)./vMatrix;      

        % Transpose the data:
        TrainSet=T_TrainSet';
        TestSet=T_TestSet';

        % Train a k-nn classifier and test the test samples using knnclassify.m
        % 10. To complete:

        % This code is using ClassificationKNN from matlab 2012b. For a newest
        % version fitcknn must be used instead.

        % testing the best k possible
        best_class = realmax;   
        model = ClassificationKNN.fit(TrainSet',TrainLabels','NumNeighbors',k);
        Result_labels = model.predict(TestSet');

        % Compute the classification rates
        thrs=0;
        FP(i) = sum(Result_labels(TestLabel==0)==1); 
        FN(i) = sum(Result_labels(TestLabel==1)==0);
        TP(i) = sum(Result_labels(TestLabel==1)==1); 
        TN(i) = sum(Result_labels(TestLabel==0)==0);
        error(i)=(FP(i)+FN(i))/NTest;
    end
    e= mean(error);
    k_errors = [k_errors e];
    if (e<=best_error_mean) %choose highest k
        best_error_mean = e;
        best_error = error;
        best_fp = FP;
        best_fn = FN;
        best_tp = TP;
        best_tn = TN;
        best_k = k;
    end
    FP = best_fp;
    FN = best_fn;
    TP = best_tp;
    TN = best_tn;
    error = best_error;
end
disp('Best k');
disp(best_k);


end





