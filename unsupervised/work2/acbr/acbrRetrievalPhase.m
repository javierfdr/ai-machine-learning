% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Retrieves the most similar instance to the given instance value
% looking in TrainingMatrix through a KNN algorithm with 'k' neighbors.
% Train matrix consists of a set of n-dimensional examples. Categories is
% a vector where containing the label or class for each of TrainMatrix example.
function [knn,d, weights] = acbrRetrievalPhase(TrainData, Instance, K)
    
    oneWeights = ones(1,size(TrainData,2));
    Features = [1:size(TrainData,2)];
    [knn, d, weights] = weightedACBRRetrievalPhase(TrainData, Instance, K,oneWeights,Features);

end
