% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function arindex = adjusted_randindex(found_clusters,expert_clusters)

    n=length(found_clusters);
    fc_num=max(found_clusters);
    ec_num=max(expert_clusters);


    % building confusion matrix
    conf_matrix=zeros(fc_num,ec_num);
    for i=1:n
        % updating clustering matches in each example
        conf_matrix(found_clusters(i),expert_clusters(i))= conf_matrix(found_clusters(i),expert_clusters(i))+1;
    end
    sum_rows=sum(conf_matrix,2);
    sum_colums=sum(conf_matrix,1);

    % Sum of all pairs combinated in 2
    nij_sum=0;
    for i=1:fc_num
        for j=1:ec_num
            if conf_matrix(i,j)>1
                nij_sum=nij_sum+nchoosek(conf_matrix(i,j),2);
            end
        end
    end

    % Sum of all rows combinated in 2
    ai_sum = 0;
    for i=1:fc_num
        if sum_rows(i)>1
            ai_sum=ai_sum+nchoosek(sum_rows(i),2);
        end
    end

    % Sum of all columns combinated in 2
    bj_sum=0;
    for j=1:ec_num
        if sum_colums(j)>1
            bj_sum=bj_sum+nchoosek(sum_colums(j),2);
        end
    end

    all_pairs=nchoosek(n,2);

    arindex=(nij_sum-ai_sum*bj_sum/all_pairs)/(0.5*(ai_sum+bj_sum)-ai_sum*bj_sum/all_pairs);
end
