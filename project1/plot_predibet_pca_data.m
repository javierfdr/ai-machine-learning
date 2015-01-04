function [newData,categories] = plot_predibet_pca_data(file,standarized_data,data_struct)

    if size(standarized_data,1)==0
        [standarized_data, data_struct] = prepare_predibet(file);
    end
    categories = data_struct.result.values()';

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
            catName(num2str(count)) = index;
            count = count+1;
        end
    end
    
    % build data cluster_vector
    cv = [];
    for i=1:size(standarized_data,1)       
        if isfloat(categories(i,1))
            index = char(num2str(categories(i,1)));
        else
            index = char(categories(i,1));
        end
        cv = [cv;[catNumHash(index),1]];
    end
    
    [newData, Dmean, Deivec, Deival ] = pca(standarized_data, 6);
    
    % plotting pca from standarized data
    plot_pca([3],cv,categories,newData,true,'generated_files/pca/predibet/pca-plot');
    

end   
