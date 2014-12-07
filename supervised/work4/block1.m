% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

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
dispvarray(meanattrs);

meanattrsp = nanmean(x(:,y==1),2);
disp('Mean of the attributes in for class 1: ');
dispvarray(meanattrsp);

meanattrsn = nanmean(x(:,y==-1),2);
disp('Mean of the attributes in for class -1: ');
dispvarray(meanattrsn);
    
disp(['Mean of the mean of the attributes ("Global Mean") in the training set: ',int2str(mean(meanattrs))]);

