% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = tester()

%file = '../docs/data/zoo.arff';
%[pd, cv, cent, niters]=zoo_kmeans(file,7,300);
%cat = pd.type.values()';
%plot_k_means(7,cv,cat);

file = '../docs/data/zoo.arff';
[data_segment,pd] = prepare_zoo_kmeans(file);
[cv, cent, niters] = kmeans(data_segment,3,300,[]);
cat = pd.type.values()';
plot_k_means(3,cv,cat);
