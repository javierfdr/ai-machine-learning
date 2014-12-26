% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [class] = zoo_acbr()
    [std,pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
    categories = pf.type.values()';
        
    k=3;
    instance = std(1,:);
    instance2 = std(3,:);
    
    % creating data manually by mixing instances
    instance(1,1) = instance2(1,1);
    instance(1,6) = instance2(1,6);
    instance(1,16) = instance2(1,16);
    
    instanceClass = categories(1);
    goodness = ones(size(std,1),1)*0.5;
    initGoodness = 0.5;
    [STDData, Categories, Goodness, newClass] = acbrAlgorithm(std,categories,goodness,initGoodness, instance,instanceClass,k,'MostSimilar');
    [weightedSTDData, weightedCategories, weightedGoodness, weightedClass] = weightedACBRAlgorithm(std,categories,goodness,initGoodness, instance,instanceClass,k,'WeightedVoting');
    
end
