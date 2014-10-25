function [cluster_vector, centroids, niters] = fcm(c,data,max_iters,epsilon,m)
    niters = max_iters;
    centroids = zeros(c,size(data,2));
    blank = ones(1,size(data,2))
    n_samples = size(data,1);
    cluster_vector = rand(n_samples,c);
    prev_centroids = ones(size(centroids))*realmax;
    while (abs(sum(prev_centroids - centroids)) < epsilon) && (niters > 0)
        prev_centroids = centroids;
        %Compute new centroids, vectorized
        centroids = ((cluster_vector.^m)'*data) ./ sum((cluster_vector.^m)')*blank;
                     
        for n = 1:n_samples
            for i = 1:c
                dist_x_centi = pdist([data(n,:);centroids(i,:)],'euclidean');
                dist_x = 0
                for j = 1:c
                    dist_x = dist_x + (dist_x_centi/pdist([data(n,:);centroids(j,:)],'euclidean'))
                end
                cluster_vector(n,c) = 1 / (dist_x)^(2/m-1);
            end
        end
        
        niters = niters - 1;
    end
    niters = max_iters-niters;
end
