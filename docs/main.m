%% Main
%
% @authors: Maria Salam? Llorente
% @subject: Introduction to Machine Learning
% @studies: Master in Artificial Intelligence

%% Code 
clc   % Clear the screen 

path = 'data/iris.arff'; 
disp (path); 

matrix = parser_arff_file(path);
stdata = standarizer(matrix);

disp(matrix)
input (' Data standarized '); 
disp (stdata)

%% End 
input('Press ENTER to continue...');

