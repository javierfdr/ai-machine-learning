% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Executes kmeans algorithm to a nxm matrix of data examples defined by
% 'data', choosing a 'k' number of clusters and running for a maximum of
% 'max_iters' iterations. 'k_seed_num' is the maximum num of k being used
%  while testing different k's, in order to generate consistent centroids 
% (first maxk - k centroids are the same).
% 'seed' specifies a seed number for random number generator. If 0 is given
% a custom seed is used
% 'performance_it' indicates the number of internal iterations to be
% run on kmeans to reach a result with the best performance in point to
% cluster centroid distance.
% The function returns 'cluster_vector' a nx2 matrix indicating the cluster
% assigned to each example ni and the distance to the centroid.
% 'centroids' the final centroids converged. 
% 'niters' number of iterations reached until kmeans converged
function [cluster_vector, centroids, num_iters_kmean] = kmeans(data,k, max_iters, k_seed_num, seed, performance_it)
    disp(strcat('Running k-means with values k:',num2str(k),' max_iters:',num2str(max_iters),' performance_iters: ',num2str(performance_it)));
    best_clus_vector = [];
    best_centroids = [];
    best_niters = [];
    best_performance = realmin;
    
    % setting the random seed
    if seed==0
        rng(12002001);
    else
        rng(seed);
    end
    for p=1:performance_it
        disp(strcat('k-means internal iter ',num2str(p),'/',num2str(performance_it)));
        num_iters_kmean = max_iters;
        
        % picking k random points from data for each centroid
        % first k centroids are the same for a different k
        rand_data = randperm(size(data,2),k_seed_num);
        centroids=[];
        for i=1:k
            centroids=[centroids;data(rand_data(i),:)];
        end
        
        %centroids = datasample(data,k,'Replace',false)
        
        n_samples = size(data,1);
        cluster_vector = [zeros(n_samples,1),(ones(n_samples,1).*realmax)];
        prev_centroids = ones(size(centroids))*realmax;
        % find new centroids and redistribute until no new centroid is
        % calculated or the max number of iterations is reached
        while ~isequal(prev_centroids, centroids) && (num_iters_kmean > 0)
            dist_matrix = pdist2(data,centroids);
            [cluster_vector(:,2), cluster_vector(:,1)] = min(dist_matrix,[],2);

            prev_centroids = centroids;
            for cent = 1:k
                points_set_i = cluster_vector(:,1) == cent;
                
                % recalculate centroid as the mean of the set of points
                % belonging to the same cluster
                centroids(cent,:)= sum(data(points_set_i,:)) / sum(points_set_i);
            end
            num_iters_kmean = num_iters_kmean - 1;
        end
        num_iters_kmean = max_iters-num_iters_kmean
        %performance = sum(cluster_vector(:,2));
        
        s = silhouette(data,cluster_vector(:,1));
        performance = mean(s); 
        
        if performance > best_performance
            best_performance = performance
            best_clus_vector = cluster_vector;
            best_centroids = centroids;
            best_niters = num_iters_kmean;
        end   
    end
end
