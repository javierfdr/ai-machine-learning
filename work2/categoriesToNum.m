% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [CatArray] = categoriesToNum(Categories)
    unique_cat = unique(Categories);
    num_cat= size(unique(Categories));

    CatArray = zeros(size(Categories,1),1);
    for i=1:num_cat

        cc = strcmp(Categories,unique_cat(i,:));
        cc = cc*i;
        CatArray = CatArray+cc;
    end     
end
