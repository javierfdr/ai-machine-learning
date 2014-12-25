function [Goodness] = acbrReviewPhase(STDData, Categories, KNN, D, Goodness, Class, alpha)
    
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
    
    % Update goodness for correct neighbors
    Goodness(KNN) = Goodness(KNN) + alpha*abs(correctReward(KNN)-Goodness(KNN));

    % Update goodness for incorrect neighbors
    
    
end