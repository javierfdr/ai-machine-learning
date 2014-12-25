% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [class] = zoo_acbr()
    [std,pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
    categories = pf.type.values()';
        
    k=3;
    instance = std(1,:);
    instanceClass = categories(1);
    goodness = ones(size(std,1),1)*0.5;
    class = acbrAlgorithm(std,categories,goodness, instance,instanceClass,k,'MostSimilar');
    weighted_class = weightedACBRAlgorithm(std,categories,goodness, instance,instanceClass,k,'WeightedVoting');
    
end