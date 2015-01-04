% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [std_data_matrix, parsed_data] = prepare_zoo_kmeans(file)
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
    breathes = transf_bool_to_num(pf.breathes.values()');
    venomous = transf_bool_to_num(pf.venomous.values()');
    fins = transf_bool_to_num(pf.fins().values');
    legs = pf.legs.values()';
    tail = transf_bool_to_num(pf.tail().values');
    domestic = transf_bool_to_num(pf.domestic().values');
    catsize = transf_bool_to_num(pf.catsize().values');
    
    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [hair,feathers,eggs,milk,airborne,aquatic,predator,toothed,backbone,breathes, venomous, fins,legs,tail,domestic,catsize];
    std_data_matrix = standarizer(data_matrix);
    parsed_data = pf;
    
    
end
