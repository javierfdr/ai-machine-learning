% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [newStats,STDData, Categories, Goodness, newClass] = weightedACBRAlgorithm(Stats,STDData,Categories, Goodness, InitGoodness,  Instance, InstanceClass, K, ReuseStrategy, Weights, Features)

    Retention = true;
    Review = true;
    Weighted = true;
    [newStats, STDData, Categories, Goodness, newClass] = cbrCombinator(Stats, STDData,Categories, Goodness, InitGoodness,  Instance, InstanceClass, K, ReuseStrategy, Weighted, Weights, Features, Review, Retention);
end

