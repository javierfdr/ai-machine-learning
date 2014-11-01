% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [cluster_vector, centroids, niters] = kmeans(data,k,max_iters, k_seeds)
    niters = max_iters;
    
    if size(k_seeds,1)==0
        centroids = datasample(data,k,'Replace',false);
    else
        centroids = k_seeds;
    end
    n_samples = size(data,1);
    cluster_vector = [zeros(n_samples,1),(ones(n_samples,1).*realmax)];
    prev_centroids = ones(size(centroids))*realmax;
    % find new centroids and redistribute until no new centroid is
    % calculated or the max number of iterations is reached
    while ~isequal(prev_centroids, centroids) && (niters > 0)
        for n = 1:n_samples
            min_d = realmax;
            min_c = 0;
            for c = 1:k
                pair_point_centroid = [centroids(c,:);data(n,:)];
                d = pdist(pair_point_centroid,'euclidean');
                if  d < min_d
                    min_c = c;
                    min_d = d;
                end
            end
            % replaces current best centroid and distance for point n
            cluster_vector(n,1) = min_c;
            cluster_vector(n,2) = min_d;
        end
        prev_centroids = centroids;
        for cent = 1:k
            points_bag = [];
            for n = 1:n_samples
                % group together the points of the same cluster
                if cluster_vector(n,1) == cent
                    points_bag = [points_bag;data(n,:)];
                end
            end
            % recalculate centroid as the mean of the set of points
            % belonging to the same cluster
            centroids(cent,:)= mean(points_bag);
        end
        niters = niters - 1;
    end
    niters = max_iters-niters;
end
