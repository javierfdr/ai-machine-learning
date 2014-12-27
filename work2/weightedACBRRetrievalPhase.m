% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Retrieves the most similar instance to the given instance value
% looking in TrainingMatrix through a KNN algorithm with 'k' neighbors.
% Train matrix consists of a set of n-dimensional examples. Categories is
% a vector where containing the label or class for each of TrainMatrix example.
function [knn,d,votingWeights,newInstance] = weightedACBRRetrievalPhase(TrainData, Instance, K, Weights, Features)
    %knn matlab method
    %[matlab_knn,matlab_d] = knnsearch(TrainData,Instance,'K',K);
    
    %knn using kdtrees
    %kdTree = kd_buildtree(TrainData,false);
    %[knn,d] = kd_knnsearch(kdTree,Instance,K)
 
        %knn matrix optimized
%        newInstance = Instance(:,Features);
        newInstance = Instance.*Weights;
        
        [knn,d] = matKnnSearch(TrainData,Instance,K);

        %checking results
        %if knn ~= matlab_knn
        %    matlab_knn
        %    knn
        %end

        % Weighting results with its euclidean distance
        %votingWeights = 1 ./ (((d)./(mean(d)+1)) + 1);
        votingWeights = ones(1,size(d,2));
end
