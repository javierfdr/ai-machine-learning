
% Applies Fisher Score method to input data and returns a reduced input data
% matrix where features with a relevance lower than threshold are removed
function [NewSTDData,Weights, Features] = fisherSelection(STDData, Categories)
    categoriesNum = categoriesToNum(Categories);

    out = fsFisher(STDData,categoriesNum);
    ranked = out.fList;
    weights = out.W;
    
    for i=1:size(weights,2)
        if isnan(weights(1,i))
            weights(1,i)=0;
        end
    end
    
    threshold = nanmean(weights);
    
    % With dimensionality reduction
    Features = find(weights>threshold);
    
    % No dimensionality reduction
    %Features = [1:size(STDData,2)];
    NewSTDData = STDData(:,Features);
    
    Weights = weights(Features);
    
    % Projecting data
    weightsAsMatrix = repmat(Weights,size(NewSTDData,1),1);
    NewSTDData = NewSTDData.*weightsAsMatrix;
    
    
    %disp(strcat('Features reduced from: ',num2str(size(STDData,2)),' To ',num2str(size(NewSTDData,2))));
    %disp('Selected features');
    %disp(Features);
end