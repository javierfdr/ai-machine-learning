
% Applies Relief-F method to input data and returns a reduced input data
% matrix where features with a relevance lower than threshold are removed
function [NewSTDData,Weights, Features] = reliefSelection(STDData, Categories, K, threshold)
    [ranked,weights] = relieff(STDData,Categories,K);
    Features = find(weights>threshold);
    NewSTDData = STDData(:,Features);
    
    Weights = weights(Features);
    
    % Projecting data
    weightsAsMatrix = repmat(Weights,size(NewSTDData,1),1);
    NewSTDData = NewSTDData.*weightsAsMatrix;
    
    
    disp(strcat('Features reduced from: ',num2str(size(STDData,2)),' To ',num2str(size(NewSTDData,2))));
    disp('Selected features');
    disp(Features);
end