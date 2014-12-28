% Introduction to Machine Learning (IML) - Work 5
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 4
clear all; close all; clc;
load example_dataset_2.mat;

input('Press enter to calculate Soft margin lambda=1e-2');
[a,b,sv,v] = train_soft_margin_dual(data',labels',1e-2);
draw_soft_margin(data,labels,a,b,sv,'Soft margin (dual) on example_dataset_2 lambda 1e-2');

input('Press enter to calculate Soft margin lambda=2.7e-1');
[a,b,sv,v] = train_soft_margin_dual(data',labels',2.79e-1);
draw_soft_margin(data,labels,a,b,sv,'Soft margin (dual) on example_dataset_2 lambda 2.79e-1');

input('Press enter to calculate Soft margin lambda=1');
[a,b,sv,v] = train_soft_margin_dual(data',labels',1);
draw_soft_margin(data,labels,a,b,sv,'Soft margin (dual) on example_dataset_2 lambda 1');

input('Press enter to calculate Soft margin lambda=1e2');
[a,b,sv,v] = train_soft_margin_dual(data',labels',1e2);
draw_soft_margin(data,labels,a,b,sv,'Soft margin (dual) on example_dataset_2 lambda 1e2');

% Just checking that the primal and the dual are equal
% [pa,pb,psv] = train_soft_margin(data',labels',1e2);
% draw_soft_margin(data,labels,pa,pb,psv,'Soft margin on example_dataset_2 lambda 1e2');
% a-pa
% b-pb
% sv-psv

input('Press enter to proceed to next section...');
%%
clear all; close all; clc;
load example_dataset_2.mat;

input('Press enter to calculate Soft margin lambda=10');
[a,b,sv,v] = train_soft_margin_dual(data',labels',10);
%draw_soft_margin(data,labels,a,b,sv,'Soft margin (dual) on example_dataset_2 lambda 10');
disp(v');
disp((1e-5*10 < v')&(v' < 10));

input('Press enter to proceed to next section...');
