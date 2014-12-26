% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [STDData, Categories, Goodness, newClass] = cbrCombinator(STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy, Weighted, Weights, Features, Review, Retention)

    if Weighted        
        
        [knn,d,votingWeights,newInstance] = weightedACBRRetrievalPhase(STDData,Instance,K,Weights,Features);
        Instance = newInstance;
    else
        [knn,d,votingWeights] = acbrRetrievalPhase(STDData,Instance,K);
        % this mimics the weights allowing for normal voting
    end
    
    % Reuse must be always called, at least with the MostSimilar strategy
    [instance,newClass] = acbrReusePhase(STDData, Categories, [knn',d'], votingWeights, ReuseStrategy);
    
    if Review
        [Goodness] = acbrReviewPhase(STDData, Categories, knn',d', Goodness, InitGoodness, 'DD', newClass,0.2);
    end
    
    if Retention
        [STDData,Categories] = acbrRetentionPhase(STDData, knn',d', Categories,Instance, InstanceClass, newClass, Goodness, InitGoodness, 'DD',0);
    end
    
end

