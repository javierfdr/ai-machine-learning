% Introduction to Machine Learning (IML) - Work 5
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 6
clear all; close all; clc;
load example_dataset_3.mat;

input('Press enter to search for best lambda with normal and weighted error');
bestError = realmax;
bestLambda = -1;
bestA = [];
bestB = [];
bestSV = [];
bestWError = realmax;
bestWLambda = -1;
bestWA = [];
bestWB = [];
bestWSV = [];
for i=1e-1:1e-1:20
    [a,b,sv,u,v,error,weightedError] = train_soft_margin_constrained_uv_weighted(data',labels',i);
    
    if error < bestError
        bestLambda = i;
        bestError = error;
        bestA = a;
        bestB = b;
        bestSV = sv;
    end
    
    if weightedError < bestWError
        bestWLambda = i;
        bestWError = weightedError;
        bestWA = a;
        bestWB = b;
        bestWSV = sv;
    end
end
bestError
bestWError
bestLambda
bestWLambda
draw_soft_margin(data,labels,bestA,bestB,bestSV,'Soft margin weighted on example_dataset_3 best lambda');
draw_soft_margin(data,labels,bestWA,bestWB,bestWSV,'Soft margin weighted on example_dataset_3 best lambda + Weighted error');
