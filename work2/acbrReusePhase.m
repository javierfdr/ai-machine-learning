
% Returns the classification of an instance picking a neighbor following
% the given strategy.
% If strategy is 'MostSimilar' then the class of the instance with lowest
% distance will be returned
function [instance,class] = acbrReusePhase(TrainData, TrainClasses, KNND , Strategy)
    Distance = KNND(:,2);
    KNN = KNND(:,1);
    
    if Strategy == 'MostSimilar'
        [m, index] = min(Distance);
        instance = TrainData(index,:);
        class = TrainClasses(index);
    end
    
end