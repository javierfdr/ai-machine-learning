% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [ClassNum] = categorieToNum(Categories,Class)
    unique_cat = unique(Categories);
    
    class_match = strcmp(unique_cat,Class);
    ClassNum = find(class_match);
end
