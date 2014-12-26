% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [STDData, Categories, Goodness, newClass] = acbrAlgorithm(STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy)
    [knn,d] = acbrRetrievalPhase(STDData,Instance,K);
    [instance,newClass] = acbrReusePhase(STDData, Categories, [knn',d'], ReuseStrategy);
    [Goodness] = acbrReviewPhase(STDData, Categories, knn',d', Goodness, newClass,0.3);
    [STDData,Categories] = acbrRetentionPhase(STDData, knn',d', Categories,Instance, InstanceClass, newClass, Goodness, InitGoodness, 'DD',0);
end

