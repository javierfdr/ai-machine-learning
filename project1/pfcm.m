% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [cluster_vector, f_cluster_vector, p_cluster_vector, centroids, niters, err] = pfcm(data, c, max_iters, fm, fn, fa, fb, epsilon, round_results)
    niters = max_iters;
    blank = ones(1,size(data,2));
    centroids = rand(c,size(data,2));
    n_samples = size(data,1);
    f_cluster_vector = zeros(n_samples,c);
    p_cluster_vector = zeros(n_samples,c);
    prev_centroids = ones(c,size(data,2))*realmax;
    cent_dist = realmax;
    m21 = 2 / (fm - 1);
    n11 = 1 / (fn - 1);
    
    % Estimating Gamma for PFCM with FCM
    [cv_fcm, fcv_fcm, cent_fcm, it_fcm, err_fcm] = fcm(data,c,niters,fm,epsilon, false);
    for i = 1:c
        dist_x_cent = 0;
        for n = 1:n_samples
            dist_x_cent(n) = pdist([data(n,:);cent_fcm(i,:)],'euclidean');                
        end
        K = 1; % common choice
        gi_vector = (fcv_fcm(:,i).^fn)';
        g(i) = K*(gi_vector*(dist_x_cent'.^2)) / sum(gi_vector);
            
        bg(i) = fb/g(i);
    end   
    
    while (cent_dist > epsilon) && (niters > 0)
                    
        for n = 1:n_samples
            for i = 1:c
                dist_x_centi = pdist([data(n,:);centroids(i,:)],'euclidean');
                dist_x = 0;
                for j = 1:c
                    dist_x_centj = pdist([data(n,:);centroids(j,:)],'euclidean');
                    dist_x = dist_x + ((dist_x_centi/dist_x_centj)^m21);
                end
                f_cluster_vector(n,i) = 1 / dist_x;
            end
        end
        
        for i = 1:c
            for n = 1:n_samples
                dist_x_centi = pdist([data(n,:);centroids(i,:)],'euclidean');
                p_cluster_vector(n,i) = 1 / (1 + ((bg(i)*(dist_x_centi^2))^n11));
            end
        end        
        
        prev_centroids = centroids;
        %Compute new centroids, vectorized, guaranteed
        fuzzy_vector = ((fa*(f_cluster_vector.^fm)) + (fb*(p_cluster_vector.^fn)))';
        centroids = (fuzzy_vector*data) ./ (sum(fuzzy_vector,2)*blank);
        
        cent_dist = 0;
        for i = 1:c
            cent_dist = cent_dist + pdist([prev_centroids(i,:);centroids(i,:)],'euclidean');
        end
               
        niters = niters - 1;
    end
    
    % Crisp cluster vector asigning each point to the most probable cluster
    [cluster_vector_prob , cluster_vector_cent] = max(f_cluster_vector,[],2);
    cluster_vector = [cluster_vector_cent, cluster_vector_prob];
    
    % Rounding and Output
    if round_results == true
        rfactor = 1e3; % for compatibility with octave
        f_cluster_vector = round(f_cluster_vector.*rfactor) ./ rfactor;
        p_cluster_vector = round(p_cluster_vector.*rfactor) ./ rfactor;
        centroids = round(centroids.*rfactor) ./ rfactor;
    end 
    niters = max_iters-niters;
    err = cent_dist;
end
