function [] = plotLDA()
    [std_data_matrix, parsed_data] = prepare_predibet('../docs/predibet/total_multi_test.arff');
    labels= parsed_data.result.values();
    data = std_data_matrix;
    dlab0 = data(labels==0,:);
    dlab1 = data(labels==1,:);
    newdata = [dlab0;dlab1];
    
    sizel0 = size(dlab0,1);
    sizel1 = size(dlab1,1);
    
    newlabels = [zeros(sizel0,1);ones(sizel1,1)];
    ldata = lda(newdata,newlabels);
    ldatatransf = [ones(size(newdata,1),1) newdata]*ldata';
    red0 = ldatatransf(1:sizel0,:);
    blue1 = ldatatransf(sizel1+1:size(ldatatransf,1),:);
    
    figure()
    plot(blue1(:,1),blue1(:,2),'bx');hold on;
    plot(red0(:,1),red0(:,2),'rx');hold on;
    
end