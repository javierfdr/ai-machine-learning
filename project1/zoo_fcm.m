% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [data_struct, cluster_vector, centroids, niters, err] = zoo_fcm(file,k,niters)
    pf = arffparser('read',file);
    data_struct = pf;
    %% preparing attributes
    hair = transf_bool_to_num(pf.hair.values()');
    feathers = transf_bool_to_num(pf.feathers.values()');
    eggs = transf_bool_to_num(pf.eggs.values()');
    milk = transf_bool_to_num(pf.milk.values()');
    airborne = transf_bool_to_num(pf.airborne.values()');
    aquatic = transf_bool_to_num(pf.aquatic.values()');
    predator = transf_bool_to_num(pf.predator.values()');
    toothed = transf_bool_to_num(pf.toothed.values()');
    backbone = transf_bool_to_num(pf.backbone.values()');
    fins = transf_bool_to_num(pf.fins().values');
    legs = pf.legs.values()';
    tail = transf_bool_to_num(pf.tail().values');
    domestic = transf_bool_to_num(pf.domestic().values');
    catsize = transf_bool_to_num(pf.catsize().values');
    
    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [hair,feathers,eggs,milk,airborne,aquatic,predator,toothed,backbone,fins,legs,tail,domestic,catsize];
    std_data_matrix = standarizer(data_matrix);
    
    % running kmeans for the standarized data, finding k clusters in a
    % maximum niters number of iterations
    [cluster_vector, centroids, niters, err] = fcm(std_data_matrix,k,niters,2,0.001);
    
end
