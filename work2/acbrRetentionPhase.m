% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Decides wether to retain or not the new instance. The new instance is
% added in case the decision is to retain.
function [STDData, Categories,Goodness] = acbrRetentionPhase(STDData, KNN,D, Categories, Instance, InstanceClass, NewClass, Goodness, InitGoodness,  RetentionStrategy, Threshold)
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
            Goodness = [Goodness;InitGoodness];
        end
        
        value = dd;
    elseif isequal(RetentionStrategy(1:2),'DE')
    
        numInstanceClass = categorieToNum(Categories,InstanceClass);
                 
        if(~isequal(NewClass,numInstanceClass))
        
            NumCategories = categoriesToNum(Categories);
            majority_class = mode(NumCategories(KNN));
            
            if(~isequal(NewClass, majority_class))
                STDData = [STDData;Instance];
                Categories = [Categories;InstanceClass];
                Goodness = [Goodness;InitGoodness];
            end
            
        end
        
    elseif isequal(RetentionStrategy(1:2),'AR')
            STDData = [STDData;Instance];
            Categories = [Categories;InstanceClass];
            Goodness = [Goodness;InitGoodness]; 
    end
    
    % if NR is passed do nothing
    
    % Oblivion
    if ((size(RetentionStrategy,2)>2) && (isequal(RetentionStrategy(3:4),'-O')))
        %oblived = Goodness < InitGoodness;
        %oblivedIndex = find(oblived);
        
        %Forgeting Instances
        STDData = STDData(Goodness >= InitGoodness,:);
        %Forgeting Classes
        Categories = Categories(Goodness >= InitGoodness,:);
        %Forgeting Goodness
        Goodness = Goodness(Goodness >= InitGoodness,:);
        
        %newKNN = [];
        %newD = [];
        
        %oblivedIndex = oblivedIndex(ismember(oblivedIndex,KNN)==1);
        
        %for nk=1:size(KNN)
        %    oblive = false;
        %    for o=1:size(oblivedIndex)
        %        if oblivedIndex(o)==KNN(nk)
        %            oblive = true;
        %        end
        %    end
        %    if ~oblive
        %        newKNN = [newKNN,KNN(nk)];
        %        newD = [newD,D(nk)];
        %    end
        %end
    end    
    
end
