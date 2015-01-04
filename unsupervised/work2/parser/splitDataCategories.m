function [DataMatrix,Categories] = splitDataCategories(data)
    DataMatrix = data(:,1:size(data,2)-1);
    Categories = data(:,size(data,2)-1);
end