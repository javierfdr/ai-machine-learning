% Introduction to Machine Learning (IML) - Exercise 3
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = ex1()
%     
    %%
    input('Block 1: Loading and analizing diabetes.mat... press enter');
    % data values will be loaded to x and y
    load('diabetes.mat');
    
    %plot(x,y,'bo'); hold on;
    %creating legend
    %labels{1,1} = 'Dataset Points';
    %legend(labels,'FontSize',14,'FontWeight','bold');
    
    [nfeatures, nsamples] = size(x);
    % 1) Cardinality (nsamples) of the training set
    disp(['Cardinality (nsamples) of the training set: ',int2str(nsamples)]);
    % 2) Dimensionality (nfeatures) of the training set
    disp(['Dimensionality (nfeatures) of the training set: ',int2str(nfeatures)]);
    
    % 3) Mean of the training set, many options
    meanattrs = nanmean(x,2);
    disp('Mean of the attributes in the training set, discarding NaNs: ');
    disp(meanattrs);
    
    meanattrsp = nanmean(x(:,y==1),2);
    disp('Mean of the attributes in for class 1: ');
    disp(meanattrsp);
    
    meanattrsn = nanmean(x(:,y==-1),2);
    disp('Mean of the attributes in for class -1: ');
    disp(meanattrsn);
        
    disp(['Mean of the mean of the attributes ("Global Mean") in the training set: ',int2str(mean(meanattrs))]);
    
    %%
    input('Block 2: Creating modified datasets... press enter');
    % 1) Create dataset D1, replacing the NaN values with the mean value of the
    % corresponding attribute without considering the missing values.
    D1 = x;
    D1(isnan(x)) = 0;
    D1 = D1 + repmat(meanattrs,1,size(x,2)).*(isnan(x));
    Dtemp = x;
    Dtemp(isnan(x)) = 0;
    %input('Displaying values modified in D1 (difference with original x)... press enter ');
    %disp(D1-Dtemp);
        
    % 2) Create dataset D2, replacing the NaN values with the mean value of the
    % corresponding attribute without considering the missing values 
    % conditioned to the class they belong.    
    D2 = x;
    D2(isnan(x)) = 0;
    D2(:,y==1) = D2(:,y==1) + repmat(meanattrsp,1,size(x(:,y==1),2)).*(isnan(x(:,y==1)));
    D2(:,y==-1) = D2(:,y==-1) + repmat(meanattrsn,1,size(x(:,y==-1),2)).*(isnan(x(:,y==-1)));
    %input('Displaying values modified in D2 (difference with original x)... press enter ');
    %disp(D2-Dtemp);
    
    % 3) [Optional :] Explain another method to deal with missing values
    % and apply it to preprocess the training data. Include the reference
    % of the method used. Consider this new dataset as D3.
    D3 = x;
    D3(isnan(x)) = 0;
    D3(:,y==1) = D3(:,y==1) + conv2(D3(:,y==1), [1 0 1]/2, "same").*(isnan(x(:,y==1)));
    D3(:,y==-1) = D3(:,y==-1) + conv2(D3(:,y==-1), [1 0 1]/2, "same").*(isnan(x(:,y==-1)));
    %input('Displaying values modified in D3 (difference with D2)... press enter ');
    %disp(D3-D2);
    
    % NaNs in D3 are replaced by the mean of the two neighboring values, for
    % neighbors of the same class. This type of filtering makes sense in
    % time related data, so it is perhaps meaningless for this dataset,
    % however it has some interesting properties that will be explained  
    % further in the report.
    
    %{
    % 4) Which are the new means?
    input('Displaying new means for D1... press enter ');
    d1meanattrs = nanmean(D1,2);
    disp('Mean of the attributes in D1: ');
    disp(d1meanattrs);
    
    d1meanattrsp = nanmean(D1(:,y==1),2);
    disp('Mean of the attributes in for class 1 in D1:');
    disp(d1meanattrsp);
    
    d1meanattrsn = nanmean(D1(:,y==-1),2);
    disp('Mean of the attributes in for class -1 in D1:');
    disp(d1meanattrsn);
    
    
    input('Displaying new means for D2... press enter ');
    d2meanattrs = nanmean(D2,2);
    disp('Mean of the attributes in D2: ');
    disp(d2meanattrs);
    
    d2meanattrsp = nanmean(D2(:,y==1),2);
    disp('Mean of the attributes in for class 1 in D2:');
    disp(d2meanattrsp);
    
    d2meanattrsn = nanmean(D2(:,y==-1),2);
    disp('Mean of the attributes in for class -1 in D2:');
    disp(d2meanattrsn);
    
    input('Displaying new means for D3... press enter ');
    d3meanattrs = nanmean(D3,2);
    disp('Mean of the attributes in D3: ');
    disp(d3meanattrs);
    
    d3meanattrsp = nanmean(D3(:,y==1),2);
    disp('Mean of the attributes in for class 1 in D3:');
    disp(d3meanattrsp);
    
    d3meanattrsn = nanmean(D3(:,y==-1),2);
    disp('Mean of the attributes in for class -1 in D3:');
    disp(d3meanattrsn);
    %}
    
    
    %%
    input('Block 3: Training linear threshold regressor... press enter');
    % 1) In this model you have to learn the threshold value. It is 0.
    
    % 2) Report the normal vector of the separating hyperplane for each data set
    
    xtilde1 = [ones(1,size(x,2)); D1];
    % the function pinv should be equivalent to:
    % xtildepsi1 = inv(xtilde1*xtilde1')*xtilde1;
    xtildepsi1 = pinv(xtilde1)';
    ws1 = xtildepsi1 * y;
    disp('Vector defining hyperplane for D1:');
    disp(ws1);
    
    xtilde2 = [ones(1,size(x,2)); D2];
    xtildepsi2 = pinv(xtilde2)';
    ws2 = xtildepsi2 * y;
    disp('Vector defining hyperplane for D2:');
    disp(ws2);
    
    xtilde3 = [ones(1,size(x,2)); D3];
    xtildepsi3 = pinv(xtilde3)';
    ws3 = xtildepsi3 * y;
    disp('Vector defining hyperplane for D3:');
    disp(ws3);
    
    
    % 3) Compute the error rates achieved on the training data
    input('Computing error rates for classifiers based on D1, D2, D3... press enter');
    xtilde = x;
    xtilde(isnan(x)) = 0;
    xtilde = [ones(1,size(x,2)); xtilde];
    
    tmpcost = ((xtilde'*ws1) - y);
    cost1 = (1/nsamples) * tmpcost' * tmpcost;
    
    tmperr = (sign(xtilde'*ws1) + y) == 0;    
    err1 = ((1/nsamples) * sum(tmperr))*100;
    
    disp(['Results for D1: Cost: ', num2str(cost1), ' Error %: ', num2str(err1)]);
    
    tmpcost = ((xtilde'*ws2) - y);
    cost2 = (1/nsamples) * tmpcost' * tmpcost;
    
    tmperr = (sign(xtilde'*ws2) + y) == 0;    
    err2 = ((1/nsamples) * sum(tmperr))*100;
    
    disp(['Results for D2: Cost: ', num2str(cost2), ' Error %: ', num2str(err2)]);
    
    tmpcost = ((xtilde'*ws3) - y);
    cost3 = (1/nsamples) * tmpcost' * tmpcost;
    
    tmperr = (sign(xtilde'*ws3) + y) == 0;    
    err3 = ((1/nsamples) * sum(tmperr))*100;
    
    disp(['Results for D3: Cost: ', num2str(cost3), ' Error %: ', num2str(err3)]);
    
    %[wgdesc1 , conv_m] = gdescent(D1,y,1e-5,1e-6,100000,false,false);
    %wgdesc1-ws1
    
    
end
    
