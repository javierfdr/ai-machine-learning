%% standarizer
%
% @authors: Maria Salam� Llorente
% @subject: Introduction to Machine Learning
% @studies: Master in Artificial Intelligence

%% function standarizer

function [ matrixZ ] = standarizer( matrix )
%STANDARIZERS Returns a standarized version of the data with the missing
%values substituted with the mean of the attribute

    %Compute the mean of each column (NaNs no compute)
    meanC = nanmean(matrix);
    
    %Logical matrix with ones in the place of NaNs and 0 the rest
    matrixNaNs = isnan(matrix);
    
    %Inter. matrix, with the mean in the place of NaNs
    matrixIntermediate = matrixNaNs * diag(meanC);
    
    %Join inter. matrix with original matrix. Substitude missing
    %values(NaNs) for the mean of the attribute
    matrix(matrixNaNs) = matrixIntermediate(matrixNaNs);
   
    %Get a standarized matrix
    matrixZ = zscore(matrix);

end

