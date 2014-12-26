% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [Goodness] = acbrReviewPhase(STDData, Categories, KNN, D, Goodness,  InitGoodness,  RetentionStrategy, Class, alpha)
    
    % Finding the knn that got the right class
    NumCategories = categoriesToNum(Categories);
    knnClasses = NumCategories(KNN);
    classNum = categorieToNum(Categories,Class);
    knnCorrectClasses = knnClasses==classNum;
    knnCorrectIndex = KNN(knnCorrectClasses);
    knnCorrect = STDData(knnCorrectIndex);
    
    % Finding the knn that got the incorrect class
    knnIncorrectClasses = knnClasses~=classNum;
    knnIncorrectIndex = KNN(knnIncorrectClasses);
    knnIncorrect = STDData(knnIncorrectIndex);    
    
    % Computing the reward to correct neighbors
    correctReward = zeros(size(STDData,1),1);
    correctReward(knnCorrectIndex) = correctReward(knnCorrectIndex) + 1;
    
    % Update goodness for all neighbors
    Goodness(KNN) = Goodness(KNN) + alpha*(correctReward(KNN)-Goodness(KNN));

        
    % Oblivion
    if ((size(RetentionStrategy,2)>2) && (isequal(RetentionStrategy(3:4),'-O')))
        %Forgeting Instances
        STDData = STDData(Goodness >= InitGoodness);
        %Forgeting Classes
        Categories = Categories(Goodness >= InitGoodness);
        %Forgeting Goodness
        Goodness = Goodness(Goodness >= InitGoodness);
    end
    
end
