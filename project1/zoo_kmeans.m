function [data_matrix] = zoo_kmeans(file)
    pf = arffparser('read',file);
    data_matrix = [pf.animal.values()', pf.legs.values()'];
    
    
end