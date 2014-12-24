function [category] = numToCategory(CatNum,Categories)
    unique_cat = unique(Categories);
    category = unique_cat(CatNum);
end