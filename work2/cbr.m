
% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [class] = cbr(STDData,Categories, Instance, K, ReuseStrategy)
    [knn,d] = acbrRetrievalPhase(STDData,Instance,K);

    [instance,class] = acbrReusePhase(STDData, Categories, [knn,d], ReuseStrategy);
    [STDData,Categories] = acbrRetentionPhase(STDData, knn',d', Categories,Instance,'DD',0);
end