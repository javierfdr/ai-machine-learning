function [class] = zoo_cbr()
    [std,pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
    categories = pf.type.values()';
    
    k=3;
    instance = std(1,:);
    goodness = ones(size(std,1),1)*0.5;
    class = cbr(std,categories,goodness, instance,k,'MostSimilar');
    
end