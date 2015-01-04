% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [cluster_vector, f_cluster_vector, p_cluster_vector, centroids, niters, err] = pfcmv(data, c, max_iters, fm, fn, fa, fb, epsilon, round_results)
    disp(strcat('Running PFCM with c:',num2str(c),' and niters: ',num2str(max_iters)));

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
    [cv_fcm, fcv_fcm, cent_fcm, it_fcm, err_fcm] = fcmv(data,c,niters,fm,epsilon, false);
    dist_matrix_fcm = pdist2(data,cent_fcm);
    for i = 1:c
        K = 1; % common choice
        gi_vector = (fcv_fcm(:,i).^fn)';
        g(i) = K*(gi_vector*(dist_matrix_fcm(:,i).^2)) / sum(gi_vector);
        bg(i) = fb/g(i);
    end   
    
    while (cent_dist > epsilon) && (niters > 0)
                    
        dist_matrix = pdist2(data,centroids);
        for i = 1:c
            dist_matrix_i = repmat(dist_matrix(:,i),1,c);
            f_cluster_vector(:,i) = 1 ./ sum((dist_matrix_i ./ dist_matrix).^m21, 2);
        end
        
        for i = 1:c
            p_cluster_vector(:,i) = 1 ./ (1 + ((bg(i).*(dist_matrix(:,i).^2)).^n11));
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
    cluster_vector = [cluster_vector_cent, 1./cluster_vector_prob];
    
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
