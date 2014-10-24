function [cluster_vector, centroids, niters] = kmeans(k,data,max_iters)
    niters = max_iters;
    centroids = datasample(data,k,'Replace',false);
    n_samples = size(data,1);
    cluster_vector = [zeros(n_samples,1),(ones(n_samples,1).*realmax)];
    prev_centroids = ones(size(centroids))*realmax;
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
            cluster_vector(n,1) = min_c;
            cluster_vector(n,2) = min_d;
        end
        prev_centroids = centroids;
        for cent = 1:k
            points_bag = [];
            for n = 1:n_samples
                if cluster_vector(n,1) == cent
                    points_bag = [points_bag;data(n,:)];
                end
            end
            centroids(cent,:)= mean(points_bag);
        end
        niters = niters - 1;
    end
    niters = max_iters-niters;
end