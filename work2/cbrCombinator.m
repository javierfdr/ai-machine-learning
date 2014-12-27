% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [newStats, newSTDData, newCategories, newGoodness, newClass] = cbrCombinator(Stats,STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy, Weighted, Weights, Features, Review, Retention,RetentionStrategy,RetentionThreshold, alpha)

    if Weighted               
        [knn,d,votingWeights,newInstance] = weightedACBRRetrievalPhase(STDData,Instance,K,Weights,Features);
        Instance = newInstance;
    else
        [knn,d,votingWeights] = acbrRetrievalPhase(STDData,Instance,K);
    end
    
    % Reuse must be always called, at least with the MostSimilar strategy
    [instance,newClass] = acbrReusePhase(STDData, Categories, [knn',d'], votingWeights, ReuseStrategy);
    
    % revision phase
    %[newStats] = revisionPhase(Stats,newClass,InstanceClass);
    newStats = Stats;
    
    if Review
        [newSTDData, newCategories, newGoodness] = acbrReviewPhase(STDData, Categories, knn',d', Goodness, InitGoodness, RetentionStrategy, newClass,alpha);
    end
    
    if Retention
        [newSTDData, newCategories,newGoodness]  = acbrRetentionPhase(newSTDData, knn',d', newCategories,Instance, InstanceClass, newClass, newGoodness, InitGoodness, RetentionStrategy,RetentionThreshold);
    end
    
end

