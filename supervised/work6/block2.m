% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 1
clear all; close all; clc;


%% Consider training a full tree what is the expected training error
% The training error is expected to be zero because each node will
% have exactly one example so it will always classify the correct class
% for that example (which is the example class itself).
% However a full tree will definitely tend to overfit so it will perform
% worst on a test set.

load example_dataset_1.mat;

input('Press enter to calculate and plot decision tree from training data');

% Training default regression tree
tree = classregtree(data',labels);

% showing default regression tree
view(tree);

% calculating and showing tree training error as percentage of
% misclassified such as: <0 == -1, >0 == 1

y = tree(data');
[error,accuracy] = getTreeError(y,labels);

disp(strcat('Accuracy: ',num2str(accuracy)));
disp(strcat('Error: ',num2str(error)));

% the obtained accuracy and error are
% Accuracy:0.86916
% Error:0.13084

%% building a full tree
input('Press enter to calculate and plot full decision tree from training data');
tree = classregtree(data',labels,'minparent',2,'minleaf',1,'prune','off','mergeleaves','off');
view(tree);

y = tree(data');
[error,accuracy] = getTreeError(y,labels);

disp(strcat('Accuracy: ',num2str(accuracy)));
disp(strcat('Error: ',num2str(error)));

% the obtained accuracy and error are
% Accuracy:1
% Error:0

% as expected the full tree, which is computable for this dataset is 0,
% since a complete splitting of the data can be performed so for the
% training set each example is obtaining its exact value.









