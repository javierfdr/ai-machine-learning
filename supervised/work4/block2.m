% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

input('Block 2: Creating modified datasets... press enter');
% 1) Create dataset D1, replacing the NaN values with the mean value of the
% corresponding attribute without considering the missing values.
D1 = nans2mean(x);
input('Displaying values modified in D1 (difference with original x)... press enter ');
Dtemp = x;
Dtemp(isnan(x)) = 0;
disp(D1-Dtemp);
    
% 2) Create dataset D2, replacing the NaN values with the mean value of the
% corresponding attribute without considering the missing values 
% conditioned to the class they belong.    
D2 = nans2mean(x,y,true);
input('Displaying values modified in D2 (difference with original x)... press enter ');
disp(D2-Dtemp);

% 3) [Optional :] Explain another method to deal with missing values
% and apply it to preprocess the training data. Include the reference
% of the method used. Consider this new dataset as D3.
D3 = x;
D3(isnan(x)) = 0;
D3(:,y==1) = D3(:,y==1) + conv2(D3(:,y==1), [1 0 1]/2, "same").*(isnan(x(:,y==1)));
D3(:,y==-1) = D3(:,y==-1) + conv2(D3(:,y==-1), [1 0 1]/2, "same").*(isnan(x(:,y==-1)));
input('Displaying values modified in D3 (difference with D2)... press enter ');
disp(D3-D2);

% NaNs in D3 are replaced by the mean of the two neighboring values, for
% neighbors of the same class. This type of filtering makes sense in
% time related data, so it is perhaps meaningless for this dataset,
% however it has some interesting properties that will be explained  
% further in the report.

% 4) Which are the new means?
input('Displaying new means for D1... press enter ');
d1meanattrs = nanmean(D1,2);
disp('Mean of the attributes in D1: ');
dispvarray(d1meanattrs);

d1meanattrsp = nanmean(D1(:,y==1),2);
disp('Mean of the attributes in for class 1 in D1:');
dispvarray(d1meanattrsp);

d1meanattrsn = nanmean(D1(:,y==-1),2);
disp('Mean of the attributes in for class -1 in D1:');
dispvarray(d1meanattrsn);


input('Displaying new means for D2... press enter ');
d2meanattrs = nanmean(D2,2);
disp('Mean of the attributes in D2: ');
dispvarray(d2meanattrs);

d2meanattrsp = nanmean(D2(:,y==1),2);
disp('Mean of the attributes in for class 1 in D2:');
dispvarray(d2meanattrsp);

d2meanattrsn = nanmean(D2(:,y==-1),2);
disp('Mean of the attributes in for class -1 in D2:');
dispvarray(d2meanattrsn);

input('Displaying new means for D3... press enter ');
d3meanattrs = nanmean(D3,2);
disp('Mean of the attributes in D3: ');
dispvarray(d3meanattrs);

d3meanattrsp = nanmean(D3(:,y==1),2);
disp('Mean of the attributes in for class 1 in D3:');
dispvarray(d3meanattrsp);

d3meanattrsn = nanmean(D3(:,y==-1),2);
disp('Mean of the attributes in for class -1 in D3:');
dispvarray(d3meanattrsn);

