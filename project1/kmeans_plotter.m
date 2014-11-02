% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% Processes the standarized_data applying k-means to each k in klist with
% a maximum of niters number of iterations for each kmeans run.
% The results of each run are plotted and the a performance graph
% is returned. This process is repeated nattempts times understanding
% the variability of the results
function [] = kmeans_plotter(standarized_data,categories,klist,niters,nattempts, performance_it, plot_graph, plot_silhouette)
    
    k_max = max(klist);    
    attempts_adjusted_i_list = [];
    attempts_sil_mean_list = [];
    
    % update seed for per-attempt rand_seed generation
    rng(1);
    
    for attempt_count=1:nattempts
        adjusted_i_list = [];
        sil_mean_list = [];
        
        % generate a seed number for this attempt
        rand_seed = randi(50000);
        
        % calculate k_max seeds to be used for each attempt iteration
        %k_seeds = datasample(standarized_data,k_max,'Replace',false);
        
        for i=1:size(klist,1)  
            %[cluster_vector, centroids, niters] = kmeans(standarized_data,klist(i),niters,k_seeds(1:klist(i),:),5);
            [cluster_vector, centroids, niters] = kmeans(standarized_data,klist(i),niters,max(klist),rand_seed, performance_it);
            if plot_graph
                plot_k_means(klist(i),cluster_vector,categories);
                [newData, Dmean, Deivec, Deival ] = pca(standarized_data, 2); 
            end
            
            if plot_silhouette
                figure('name',strcat('Silhouette for k: ',num2str(klist(i))));
                [s,h] = silhouette(standarized_data,cluster_vector(:,1));
                xlabel 'Silhouette Value';
                ylabel 'Cluster';
                mean_sil = mean(s);
            else
                s = silhouette(standarized_data,cluster_vector(:,1));
                mean_sil = mean(s);      
            end

            %%Creating help hashes for assigning the target category cluster
            % and directly creating category-cluster-assignation
            catNumHash = containers.Map();
            count = 1;
            target_clusters = [];
            for i=1:size(categories(:,1),1)
                if ~(catNumHash.isKey(char(categories(i,1))))
                    catNumHash(char(categories(i,1))) = count;
                    target_clusters = [target_clusters,count];
                    count = count+1;
                else
                    target_clusters = [target_clusters,catNumHash(char(categories(i,1)))];
                end
            end

            % calculate adjusted rand-index
            k_means_clusters = cluster_vector(:,1)';
            index=adjusted_randindex(k_means_clusters, target_clusters);
            adjusted_i_list = [adjusted_i_list, index];
            
            % accummulate silhouette mean index
            sil_mean_list = [sil_mean_list, mean_sil];
        end
        attempts_adjusted_i_list = [attempts_adjusted_i_list;adjusted_i_list];
        attempts_sil_mean_list = [attempts_sil_mean_list;sil_mean_list];
    end
    
    figure('name','Adjusted Rand Index for several k-means');    
    for attempt_count=1:nattempts
        symbol_list = ['b-';'r-';'c-';'m-';'y-';'k-';'g-'];
        plot(klist, attempts_adjusted_i_list(attempt_count,:),symbol_list(mod(attempt_count,7),1),klist, attempts_adjusted_i_list(attempt_count,:),'ro','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    xlabel('Value of K. Each line color is an attempt');
    ylabel('Adjusted index result');
    
    figure('name','Silhouette means');    
    for attempt_count=1:nattempts
        symbol_list = ['b-';'r-';'c-';'m-';'y-';'k-';'g-'];
        plot(klist, attempts_sil_mean_list(attempt_count,:),symbol_list(mod(attempt_count,7),1),klist, attempts_sil_mean_list(attempt_count,:),'ro','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    xlabel('Value of K. Each line color is an attempt');
    ylabel('Silhouette mean');    

end
