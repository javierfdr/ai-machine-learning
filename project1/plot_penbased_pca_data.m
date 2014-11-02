function [] = plot_penbased_pca_data(file)
    
    [standarized_data, data_struct] = prepare_penbased(file);
    categories = data_struct.class.values()';

    %%Creating help hashes for plotting
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
    
    % build data cluster_vector
    cv = [];
    for i=1:size(standarized_data,1)
        cv = [cv;[catNumHash(char(categories(i,1))),1]];
    end
    
    [newData, Dmean, Deivec, Deival ] = pca(standarized_data, 2);
    
    % plotting pca from standarized data
    plot_pca([16],cv,categories,newData,true,'generated_files/pca/penbased/pca-plot');

end   
