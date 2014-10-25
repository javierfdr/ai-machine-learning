% Plot k_means result where x value is the cluster number,
% y value is the distance to the cluster centroid and 
% the pt color corresponds to category
% Category must have the number of rows of cluster_dist columns
function [cHash] = plot_k_means(k, cluster_dist, categories)
    
    % create a hash for assigning a number to a category
    catNumHash = containers.Map();
    catName = containers.Map();
    count = 1;
    for i=1:size(categories(:,1),1)
        if ~(catNumHash.isKey(char(categories(i,1))))
            catNumHash(char(categories(i,1))) = count;
            catName(num2str(count)) = char(categories(i,1));
            count = count+1;
        end
    end

    % split clusters by building a hash (clusNum-> [centroid_distance])
    cHash = containers.Map();
    
    for i=1:size(cluster_dist(:,1),1)
        clusNum = cluster_dist(i,1);
        if ~(cHash.isKey(num2str(clusNum)))
            cHash(num2str(clusNum)) = [cluster_dist(i,2),catNumHash(char(categories(i,1)))];
        else
            row = cHash(num2str(clusNum));
            cHash(num2str(clusNum)) = [row;[cluster_dist(i,2),catNumHash(char(categories(i,1)))]];
        end
    end
    
    symbol_list = ['rx';'bo';'g*';'yx';'mv';'c>';'k<';'b+';'yh';'rd';'ys';'g^'];
    
    figure('name','K-Means plot');
    
    for ki=1:k
        cd_pair_list = cHash(num2str(ki));
        plot(cd_pair_list(:,2),cd_pair_list(:,1),symbol_list(ki,:),'MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
    
    % creating legend
    labels = {};
    for ki=1:k
        labels{1,ki} = strcat('Cluster: ', num2str(ki));
    end
    
    cats = {};
    for ki=1:size(catName,1)
        cats{1,ki} = strcat(catName(num2str(ki)));
    end
    
    legend(labels,'FontSize',14,'FontWeight','bold');
    set(gca, 'XTick',1:size(catName,1), 'XTickLabel',cats);


end