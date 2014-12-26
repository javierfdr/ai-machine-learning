% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [STDData, Categories, Goodness, newClass] = cbrCombinator(STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy, Weighted, Review, Retention)

    if Weighted        
        [knn,d,weights] = weightedACBRRetrievalPhase(STDData,Instance,K);
    else
        [knn,d] = acbrRetrievalPhase(STDData,Instance,K);
        % this mimics the weights allowing for normal voting
        weights = ones(1,size(knn,2));
    end
    
    % Reuse must be always called, at least with the MostSimilar strategy
    [instance,newClass] = acbrReusePhase(STDData, Categories, [knn',d',weights'], ReuseStrategy);
    
    if Review
        [Goodness] = acbrReviewPhase(STDData, Categories, knn',d', Goodness, newClass,0.3);
    end
    
    if Retention
        [STDData,Categories] = acbrRetentionPhase(STDData, knn',d', Categories,Instance, InstanceClass, newClass, Goodness, InitGoodness, 'DD',0);
    end
    
end

