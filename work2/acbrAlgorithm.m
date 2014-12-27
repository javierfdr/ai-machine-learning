% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [newStats, newSTDData, newCategories, newGoodness, newClass] = acbrAlgorithm(Stats, STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy, RetentionStrategy,RetentionThreshold, alpha)
    
    Retention = true;
    Review = true;
    Weighted = false;
    Weights = [];
    Features = [];

    [newStats, newSTDData, newCategories, newGoodness, newClass] = cbrCombinator(Stats,STDData,Categories, Goodness, InitGoodness,  Instance, InstanceClass, K, ReuseStrategy, Weighted, Weights,Features, Review, Retention, RetentionStrategy,RetentionThreshold, alpha);
end

