
% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [STDData, Categories, Goodness, class] = cbr(STDData,Categories, Goodness, Instance, K, ReuseStrategy)
    [knn,d] = acbrRetrievalPhase(STDData,Instance,K);
    [instance,class] = acbrReusePhase(STDData, Categories, [knn,d], ReuseStrategy);
    [Goodness] = acbrReviewPhase(STDData, Categories, knn',d', Goodness, class,0.3);
    [STDData,Categories] = acbrRetentionPhase(STDData, knn',d', Categories,Instance,'DD',0);
    
end