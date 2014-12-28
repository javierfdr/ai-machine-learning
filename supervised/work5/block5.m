% Introduction to Machine Learning (IML) - Work 5
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 5
clear all; close all; clc;
load example_dataset_3.mat;

disp('examples for class -1');
sum(labels==-1)
disp('examples for class 1');
sum(labels==1)

input('Press enter to search for best lambda');
bestError = realmax;
bestLambda = -1;
bestA = [];
bestB = [];
bestSV = [];
for i=1e-1:1e-1:10
    [a,b,sv,v,error] = train_soft_margin_dual(data',labels',i);
    if error < bestError
        bestLambda = i;
        bestError = error;
        bestA = a;
        bestB = b;
        bestSV = sv;
    end
end
bestError
bestLambda
draw_soft_margin(data,labels,bestA,bestB,bestSV,'Soft margin (dual) on example_dataset_3 best lambda');
