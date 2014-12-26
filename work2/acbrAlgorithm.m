% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Performs a CBR to the given standarized data performing KNN on k
% neighbors and using the provided ReuseStrategy for reuse of instances.
function [STDData, Categories, Goodness, newClass] = acbrAlgorithm(STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy)
    
    Retention = true;
    Review = true;
    Weighted = false;
    Weights = [];
    Features = [];

    [STDData, Categories, Goodness, newClass] = cbrCombinator(STDData,Categories, Goodness, InitGoodness,  Instance, InstanceClass, K, ReuseStrategy, Weighted, Weights,Features, Review, Retention);
end

