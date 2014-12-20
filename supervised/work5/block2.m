% Introduction to Machine Learning (IML) - Work 5
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 1
% clear all; close all; clc;
% load example_dataset_1.mat;
% 
% testing linear dataset
% input('Press enter to calculate Soft margin lambda=1e-2');
% [a,b,sv] = train_soft_margin(data',labels',1e-2);
% draw_soft_margin(data,labels,a,b,sv);
% 
% input('Press enter to calculate Soft margin lambda=2.7e-1');
% [a,b,sv] = train_soft_margin(data',labels',2.79e-1);
% draw_soft_margin(data,labels,a,b,sv);
% 
% input('Press enter to calculate Soft margin lambda=1');
% [a,b,sv] = train_soft_margin(data',labels',1);
% draw_soft_margin(data,labels,a,b,sv);
% 
% input('Press enter to calculate Soft margin lambda=1e2');
% [a,b,sv] = train_soft_margin(data',labels',1e2);
% draw_soft_margin(data,labels,a,b,sv);
% 
% % Testing nonlinear dataset
% clear all; close all; clc;
% %create_toy_dataset('nonlinear-toy-dataset');
% load nonlinear-toy-dataset;
% 
% input('Press enter to calculate Soft margin for non-linear dataset lambda=0');
% [a,b,sv] = train_soft_margin(data',labels',0)
% draw_soft_margin(data,labels,a,b,sv);

% clear all; close all; clc;
% load example_dataset_1.mat;
% 
% input('Press enter to calculate Soft margin for linear dataset and constrained solution');
% [a,b,sv] = train_soft_margin_constrained(data',labels',1)
% draw_soft_margin(data,labels,a,b,sv);
% 
clear all; close all; clc;
load example_dataset_1.mat;

input('Press enter to calculate Soft margin for linear dataset and constrained solution');
[a,b,sv] = train_soft_margin_constrained(data',labels',1e2)
draw_soft_margin(data,labels,a,b,sv);



