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
function [cluster_vector, centroids, niters] = kmeans(data,k,max_iters, k_seed_num, seed, performance_it)
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
        niters = max_iters;
        
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
        %performance = sum(cluster_vector(:,2));
        
        s = silhouette(data,cluster_vector(:,1));
        performance = mean(s); 
        
        if performance > best_performance
            best_performance = performance
            best_clus_vector = cluster_vector;
            best_centroids = centroids;
            best_niters = niters;
        end   
    end
end
