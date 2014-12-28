% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [class] = zoo_acbr()
    [STDData,pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
    Categories = pf.type.values()';
        
    K=3;
    instance = STDData(1,:);
    instance2 = STDData(3,:);
    
    % creating data manually by mixing instances
    instance(1,1) = instance2(1,1);
    instance(1,6) = instance2(1,6);
    instance(1,16) = instance2(1,16);
    
    instanceClass = Categories(1);
    goodness = ones(size(STDData,1),1)*0.5;
    initGoodness = 0.5;
    %[STDData, Categories, Goodness, newClass] = acbrAlgorithm(std,categories,goodness,initGoodness, instance,instanceClass,k,'MostSimilar');
    
    FeatureSelection = 'RELIEF';
    FSThreshold = 0.25;
    
    % Stats array containing [accuracy,number_of_instances,data_size_variation]
    Stats = zeros(1,3);
    
    [NewSTDData, Weights, Features] = preprocessData(STDData, Categories, K,FeatureSelection ,FSThreshold);
    [newStats, weightedSTDData, weightedCategories, weightedGoodness, weightedClass] = weightedACBRAlgorithm(Stats,NewSTDData,Categories,goodness,initGoodness, instance,instanceClass,K,'WeightedVoting',Weights, Features);
end
