% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [cluster_vector, centroids, niters, err] = fcm(data,c,max_iters,m,epsilon)
    niters = max_iters;
    blank = ones(1,size(data,2));
    centroids = zeros(c,size(data,2));
    n_samples = size(data,1);
    cluster_vector = rand(n_samples,c);
    prev_centroids = ones(c,size(data,2))*realmax;
    while (abs(sum(sum(prev_centroids - centroids))) > epsilon) && (niters > 0)
        prev_centroids = centroids;
        %Compute new centroids, vectorized, guaranteed
        fuzzy_vector = (cluster_vector.^m)';
        centroids = (fuzzy_vector*data) ./ (sum(fuzzy_vector,2)*blank);
                     
        for n = 1:n_samples
            for i = 1:c
                dist_x_centi = pdist([data(n,:);centroids(i,:)],'euclidean');
                dist_x = 0;
                for j = 1:c
                    dist_x_centj = pdist([data(n,:);centroids(j,:)],'euclidean');
                    dist_x = dist_x + ((dist_x_centi/dist_x_centj)^(2/(m-1)));
                end
                cluster_vector(n,i) = 1 / dist_x;
            end
        end
        
        niters = niters - 1;
    end
    niters = max_iters-niters;
    err = abs(sum(sum(prev_centroids - centroids)));
end
