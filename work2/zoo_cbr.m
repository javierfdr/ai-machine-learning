function [class] = zoo_cbr()
    [std,pf] = prepare_zoo_kmeans('datasets_iml_course/zoo/zoo.arff');
    categories = pf.type.values()';
    
    k=3;
    instance = std(1,:);
    class = cbr(std,categories,instance,k,'MostSimilar');
    
end