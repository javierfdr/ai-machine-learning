% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Returns the classification of an instance picking a neighbor following
% the given strategy.
% If strategy is 'MostSimilar' then the class of the instance with lowest
% distance will be returned
function [instance,class] = acbrReusePhase(TrainData, TrainClasses, KNND , Strategy)
    Distance = KNND(:,2);
    KNN = KNND(:,1);
    
    if isequal(Strategy,'MostSimilar')
    
        [m, index] = min(Distance);
        instance = TrainData(KNN(index),:);
        class = TrainClasses(KNN(index));
        
    elseif isequal(Strategy,'WeightedVoting')    
    
        WEIGHTS = KNND(:,3);
        k = size(KNN);
        uniqueClasses = unique(TrainClasses);
        numUnique = size(uniqueClasses,1);
        
        votes = zeros(size(uniqueClasses,1),1);
        for i=1:k
            for c=1:numUnique
                if isequal(uniqueClasses(c), TrainClasses(KNN(i)))
                    votes(c) = votes(c) + WEIGHTS(i);
                end
            end
        end
        [max, index] = max(votes);
        class = uniqueClasses(index);
        instance = TrainData(KNN(1));
        mindist = Distance(1);
        for i=1:k
            if isequal(TrainClasses(KNN(i)), class)
                if Distance(i) < mindist
                    instance = TrainData(KNN(i));
                    mindist = Distance(i);
                end 
            end            
        end        
    end
    
end
