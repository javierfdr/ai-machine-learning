% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 1
clear all; close all; clc;
load example_dataset_1.mat;
[ K, L2 ] = gramm_matrix(data,1);
figure('name','Gramm Matrix');
imagesc(K);
%[max,idx] = max(K); % max values are always on the diagonal
[V,D] = eig(K);
sum(sum(D < -1e-10)) % this must be zero to be pos def
figure('name','L2 distance');
imagesc(L2);
[afunc,sv,v,error] = train_soft_margin_dual_rbf(data',labels',1,1);
draw_soft_margin_rbf(data,labels,afunc,sv,'Soft margin dual RBF');
