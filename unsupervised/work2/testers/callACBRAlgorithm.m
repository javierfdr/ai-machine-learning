function [newStats, newSTDData, newCategories, newGoodness, newClass,Retained, numOblived] = callACBRAlgorithm(weighted, combination,Stats,STDData,Categories,Goodness,InitGoodness, Instance,InstanceClass,K,Weights, Features)
    %combinations = ['DD-O','DD','DE-O','DE','NR-O','NR','AR-O','AR'];
    
    Stats = [];
    ReuseStrategy = 'WeightedVoting';
    RetentionThreshold = 0.3;
    RetentionStrategy = combination;
    alpha = 0.3;
    
    if weighted
        %RetentionStrategy = strcat('W',RetentionStrategy(:));
        [newStats, newSTDData, newCategories, newGoodness, newClass,Retained, numOblived] = weightedACBRAlgorithm(Stats, STDData,Categories,Goodness,InitGoodness, Instance,InstanceClass,K,ReuseStrategy,Weights, Features, RetentionStrategy,RetentionThreshold, alpha);
    else
        [newStats, newSTDData, newCategories, newGoodness, newClass,Retained, numOblived] = acbrAlgorithm(Stats, STDData,Categories, Goodness, InitGoodness, Instance, InstanceClass, K, ReuseStrategy, RetentionStrategy,RetentionThreshold, alpha);
    end    
end
       