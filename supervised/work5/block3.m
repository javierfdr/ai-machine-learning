% Introduction to Machine Learning (IML) - Work 5
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 3
clear all; close all; clc;
load example_dataset_2.mat;

input('Press enter to calculate Soft margin lambda=1e-2');
[a,b,sv] = train_soft_margin(data',labels',1e-2);
draw_soft_margin(data,labels,a,b,sv,'Soft margin on example_dataset_2 lambda 1e-2');

input('Press enter to calculate Soft margin lambda=2.7e-1');
[a,b,sv] = train_soft_margin(data',labels',2.79e-1);
draw_soft_margin(data,labels,a,b,sv,'Soft margin on example_dataset_2 lambda 2.79e-1');

input('Press enter to calculate Soft margin lambda=1');
[a,b,sv] = train_soft_margin(data',labels',1);
draw_soft_margin(data,labels,a,b,sv,'Soft margin on example_dataset_2 lambda 1');

input('Press enter to calculate Soft margin lambda=1e2');
[a,b,sv] = train_soft_margin(data',labels',1e2);
draw_soft_margin(data,labels,a,b,sv,'Soft margin on example_dataset_2 lambda 1e2');

input('Press enter to proceed to next section...');
%%
clear all; close all; clc;
load example_dataset_2.mat;

input('Press enter to calculate Soft margin for linear dataset and constrained solution');
[a,b,sv,u] = train_soft_margin_constrained(data',labels',10)
%draw_soft_margin(data,labels,a,b,sv,'Soft margin (constrained) on example_dataset_2 lambda 10');

% Just checking that the two constrained solutions are equal
% [a,b,sv,nu,nv] = train_soft_margin_constrained_uv(data',labels',10);
% draw_soft_margin(data,labels,a,b,sv,'Soft margin (constrained uv) on example_dataset_2 lambda 10');
% sort(u)-sort([nu;nv]') < 1e-5

input('Press enter to proceed to next section...');
