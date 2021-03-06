% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = pfcm_plotter(standarized_data,categories,klist,niters,nattempts, performance_it, plot_graph, plot_silhouette, save_file_path)
    
    is_visible = 'off';


    k_max = max(klist);    
    attempts_adjusted_i_list = [];
    attempts_sil_mean_list = [];
    
    % update seed for per-attempt rand_seed generation
    rng(333);
    
    % pfcm predefined parameters
    fm = 1.15;
    fn = 1.15;
    fa = 1;
    fb = 1;
    epsilon = 1e-6;
    round_results = true;
    
    for attempt_count=1:nattempts
        adjusted_i_list = [];
        sil_mean_list = [];
        
        % generate a seed number for this attempt
        rand_seed = randi(555);
        
        % calculate k_max seeds to be used for each attempt iteration
        %k_seeds = datasample(standarized_data,k_max,'Replace',false);
        
        for i=1:size(klist,1)  
            %[cluster_vector, centroids, niters] = kmeans(standarized_data,klist(i),niters,k_seeds(1:klist(i),:),5);
            [cluster_vector, fcv, pcvm centroids, nit, err] = pfcmv(standarized_data, klist(i), niters, fm, fn, fa, fb, epsilon, round_results);
            if plot_graph
                plot_name = strcat(save_file_path,'confusion-graph c-',num2str(klist(i)),'-attempt-',num2str(attempt_count));
                plot_k_means(klist(i),cluster_vector,categories,true,plot_name);
                
                plot_name= strcat(save_file_path,'pca-graph c-',num2str(klist(i)),'-attempt-',num2str(attempt_count));
                [newData, Dmean, Deivec, Deival ] = pca(standarized_data, 2); 
                plot_pca(klist(i),cluster_vector,categories,newData,true,plot_name);
            end
            
            if plot_silhouette
                h = figure('name',strcat('Silhouette for k: ',num2str(klist(i))),'visible',is_visible);
                [s,h] = silhouette(standarized_data,cluster_vector(:,1));
                xlabel 'Silhouette Value';
                ylabel 'Cluster';
                mean_sil = mean(s);

                plot_name = strcat(save_file_path,'silhouette-graph c-',num2str(klist(i)),'-attempt-',num2str(attempt_count));
                saveas(h,plot_name,'png');
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
    
    h=figure('name','Adjusted Rand Index for several k-means','visible',is_visible);    
    for attempt_count=1:nattempts
        symbol_list = ['b-';'r-';'c-';'m-';'y-';'k-';'g-'];
        plot(klist, attempts_adjusted_i_list(attempt_count,:),symbol_list(mod(attempt_count,7),1),klist, attempts_adjusted_i_list(attempt_count,:),'ro','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    xlabel('Value of K. Each line color is an attempt');
    ylabel('Adjusted index result');

    plot_name = strcat(save_file_path,'adjusted-rand-index',num2str(attempt_count));
    saveas(h,plot_name,'png');
    
    h = figure('name','Silhouette means','visible',is_visible);    
    for attempt_count=1:nattempts
        symbol_list = ['b-';'r-';'c-';'m-';'y-';'k-';'g-'];
        plot(klist, attempts_sil_mean_list(attempt_count,:),symbol_list(mod(attempt_count,7),1),klist, attempts_sil_mean_list(attempt_count,:),'ro','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    xlabel('Value of K. Each line color is an attempt');
    ylabel('Silhouette mean');
    
    plot_name = strcat(save_file_path,'silhouette-mean-index',num2str(attempt_count));
    saveas(h,plot_name,'png');

end
