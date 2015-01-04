% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [data_struct, cluster_vector, centroids, niters] = segment_kmeans(file,k,niters)
    pf = arffparser('read',file);
    data_struct = pf;
    %% preparing attributes
    centroid_col = pf.regioncentroidcol.values()';
    centroid_row = pf.regioncentroidrow.values()';
    
    
    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [centroid_col, centroid_row];
    std_data_matrix = standarizer(data_matrix);
    
    % running kmeans for the standarized data, finding k clusters in a
    % maximum niters number of iterations
    [cluster_vector, centroids, niters] = kmeans(std_data_matrix,k,niters);
    
    
end
