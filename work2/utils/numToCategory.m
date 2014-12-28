% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [category] = numToCategory(CatNum,Categories)
    if isnumeric(Categories)
        category = CatNum;
        return;
    end
    
    unique_cat = unique(Categories);
    category = unique_cat(CatNum);
end
