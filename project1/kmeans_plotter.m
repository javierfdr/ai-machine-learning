% Processes the standarized_data applying k-means to each k in klist with
% a maximum of niters number of iterations for each kmeans run.
% The results of each run are plotted and the a performance graph
% is returned. This process is repeated nattempts times understanding
% the variability of the results
function [] = kmeans_plotter(standarized_data,categories,klist,niters,nattempts, plot_graph)
    
    k_max = max(klist);

    attempts_adjusted_i_list = [];
    for attempt_count=1:nattempts
        adjusted_i_list = [];
        
        % calculate k_max seeds to be used for each attempt iteration
        k_seeds = datasample(standarized_data,k_max,'Replace',false);
        
        for i=1:size(klist,1)  
            [cluster_vector, centroids, niters] = kmeans(standarized_data,klist(i),niters,k_seeds(1:klist(i),:));
            if plot_graph
                plot_k_means(klist(i),cluster_vector,categories);
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
            [AR,RI,MI,HI]=RandIndex(k_means_clusters, target_clusters);
            k_means_clusters
            target_clusters
            adjusted_i_list = [adjusted_i_list, AR];
        end
        attempts_adjusted_i_list = [attempts_adjusted_i_list;adjusted_i_list];
    end
    
    figure('name','Adjusted Rand Index for several k-means run on zoo.arff');    
    for attempt_count=1:nattempts
        symbol_list = ['b-';'r-';'c-';'m-'];
        plot(klist, attempts_adjusted_i_list(attempt_count,:),symbol_list(attempt_count,1),klist, attempts_adjusted_i_list(attempt_count,:),'ro','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    xlabel('Value of K. Each line color is an attempt');
    ylabel('Adjusted index result');
    
end