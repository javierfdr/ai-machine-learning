function [ClassNum] = categorieToNum(Categories,Class)
    unique_cat = unique(Categories);
    
    class_match = strcmp(unique_cat,Class);
    ClassNum = find(class_match);
end