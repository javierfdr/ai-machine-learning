% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Decides wether to retain or not the new instance. The new instance is
% added in case the decision is to retain.
function [STDData, Categories] = acbrRetentionPhase(STDData, KNN,D, Categories, Instance, InstanceClass, NewClass, RetentionStrategy,Threshold)
    if isequal(RetentionStrategy(1:2),'DD')
        
        NumCategories = categoriesToNum(Categories);
        majority_class = mode(NumCategories(KNN));
        
        cat_maj = NumCategories==majority_class;
        
        maj_cases = sum(cat_maj(KNN));
        rem_cases = abs(size(KNN,1)-maj_cases);
        num_classes = size(unique(NumCategories(KNN)),1);
        
        if (rem_cases==0)
            dd = 0;
        else
            dd = (rem_cases)/((num_classes-1)*maj_cases);
        end
 
        if (dd>= Threshold)
            STDData = [STDData;Instance];
            Categories = [Categories;numToCategory(majority_class,Categories)];
        end
        
        value = dd;
    elseif isequal(RetentionStrategy(1:2),'DE')
    
        if(!isequal(NewClass,InstanceClass))
        
            NumCategories = categoriesToNum(Categories);
            majority_class = mode(NumCategories(KNN));
            
            if(!isequal(NewClass, majority_class))
                STDData = [STDData;Instance];
                Categories = [Categories;numToCategory(InstanceClass,Categories)];
            end
            
        end
    
    end
    
    % Oblivion
    %if (size(RetentionStrategy)>2 && isequal(RetentionStrategy(3:4),'-O')
    %TODO
    %end
    
end
