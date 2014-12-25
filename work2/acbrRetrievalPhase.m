% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Retrieves the most similar instance to the given instance value
% looking in TrainingMatrix through a KNN algorithm with 'k' neighbors.
% Train matrix consists of a set of n-dimensional examples. Categories is
% a vector where containing the label or class for each of TrainMatrix example.
function [knn,d] = acbrRetrievalPhase(TrainData, Instance, K)
    
    % temporarly using KNNClassifier from matlab
    %model = ClassificationKNN.fit(TrainData,Categories,'NumNeighbors',k);
    %class = model.predict(instance);
    
    %[knn,d] = knnsearch(TrainData,Instance,'K',K);
    kdTree = kd_buildtree(TrainData,false);
        
    [knn,d] = kd_knnsearch(kdTree,Instance,K);
    
end
