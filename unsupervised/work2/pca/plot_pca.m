function [cHash] = plot_pca(k, cluster_vector, categories, pca_data, save, plot_name)
    
    is_visible = 'off';

    %%Creating help hashes for plotting
    % create a hash for assigning a number to a category
    
    catNumHash = containers.Map();
    catName = containers.Map();
    count = 1;
    for i=1:size(categories(:,1),1)
        if isfloat(categories(i,1))
            index = char(num2str(categories(i,1)));
        else
            index = char(categories(i,1));
        end
        if ~(catNumHash.isKey(index))
            catNumHash(index) = count;
            catName(num2str(count)) = char(index);
            count = count+1; 
        end
    end

    % split clusters by building a hash (clusNum-> [centroid_distance])
    cHash = containers.Map();
    for i=1:size(cluster_vector(:,1),1)
        clusNum = cluster_vector(i,1);
        if isfloat(categories(i,1))
            value = char(num2str(categories(i,1)));
        else
            value = char(categories(i,1));
        end
        if ~(cHash.isKey(num2str(clusNum)))
            cHash(num2str(clusNum)) = [pca_data(i,:),catNumHash(value)];
        else
            row = cHash(num2str(clusNum));
            cHash(num2str(clusNum)) = [row;[pca_data(i,:),catNumHash(value)]];
        end
    end
    
    symbol_list = ['rx';'bo';'g*';'cx';'mv';'c>';'k<';'b+';'rh';'rd';'ys';'g^'];
    
    %% Plotting the results
    pca_h = figure('name',strcat('PCA ',num2str(k),'-means'),'visible',is_visible);
    clust_size=[];
    for ki=1:k
        % the cluster is empty
        if ~(cHash.isKey(num2str(ki)))
            plot([],[],'','MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
            clust_size= [clust_size,0];
            continue;
        end
        cd_pair_list = cHash(num2str(ki));
        clust_size= [clust_size,size(cd_pair_list(:,2),1)];
        plot(cd_pair_list(:,1),cd_pair_list(:,2),symbol_list(ki,:),'MarkerSize',8,'LineWidth',1,'MarkerFaceColor',[0.8,0.8,0.8]);hold on;
    end
 
    % creating legend
    labels = {};
    for ki=1:k
        labels{1,ki} = strcat('C-',num2str(ki),':',num2str(clust_size(ki)));
    end
    
    cats = {};
    for ki=1:size(catName,1)
        cats{1,ki} = strcat(catName(num2str(ki)));
    end
    
    legend(labels,'FontSize',14,'FontWeight','bold');
    
    if save
        saveas(pca_h,plot_name,'png');
    end   

end