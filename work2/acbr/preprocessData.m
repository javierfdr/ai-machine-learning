function [NewSTDData, Weights, Features] = preprocessData(STDData, Categories, K,FeatureSelection)
    
    if isequal(FeatureSelection(1:6),'RELIEF')
        [NewSTDData,Weights, Features] = reliefSelection(STDData, Categories, K);
    
    elseif isequal(FeatureSelection(1:6),'FISHER')
        [NewSTDData,Weights, Features] = fisherSelection(STDData, Categories);
    
    else
        NewSTDData = STDData;
        Weights = ones(1,size(STDData,2));
        Features = [1:size(newSTDData,2)];
    end

end