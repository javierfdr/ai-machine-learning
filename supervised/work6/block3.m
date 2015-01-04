% Introduction to Machine Learning (IML) - Work 6
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

%% This script does the work related to question block 1
clear all; close all; clc;

% building validation and training sets for K=10 on the current dataset
load example_dataset_1.mat;

dataT = data';
[TrainingFolds, ValidationFolds] = buildFoldValidationSets(dataT, 10);

% computing class frequency for original problem and partitions
[c1f,c2f] = computeTwoClassFrequency([1:size(dataT,1)],labels);

disp('Showing two class frequency for original data and every fold');
disp(strcat('Org: ',' C1',' C-1'));
disp(strcat('---->',num2str(c1f),' | ',num2str(c2f)));

sprintf('\n\n');

for f=1:10
    tf = TrainingFolds(f,:);
    [c1f,c2f] = computeTwoClassFrequency(tf,labels);
    
    disp(strcat('T-F: ',num2str(f),' C1',' C-1'));
    disp(strcat('---->',num2str(c1f),' | ',num2str(c2f)));    
    
    vf = ValidationFolds(f,:);
    [c1f,c2f] = computeTwoClassFrequency(vf,labels);
    
    disp(strcat('V-F: ',num2str(f),' C1',' C-1'));
    disp(strcat('---->',num2str(c1f),' | ',num2str(c2f)));    
    
    sprintf('\n\n');
end


