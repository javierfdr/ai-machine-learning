% Builds K folds of training and validation set
% Returns two matrixes where each row contains the index for values
% in the training set and validation set respectively for each fold.
% data is assumed to come row wise
function [TrainingFolds, ValidationFolds] = buildFoldValidationSets(Data, NFolds)
    p=randperm(size(Data,1));

    NValidation = floor(size(Data,1)/NFolds);
    
    TrainingFolds = [];
    ValidationFolds = [];

    for i = 1:NFolds
        % preparing folds
        fold = p([(i-1)*NValidation+1:i*NValidation]);
        ValidationData = fold;
        ValidationFolds = [ValidationFolds;ValidationData];

        rangeData = [1:size(Data,1)];
        rangeTest = p(fold);

        inverse = find(~ismember(rangeData,[(i-1)*NValidation+1:i*NValidation]));
        TrainData = p(:,inverse);
        
        TrainingFolds = [TrainingFolds;TrainData];
    end
    
end


