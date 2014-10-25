function [] = tester()

file = '../docs/data/zoo.arff';
[pd, cv, cent, niters]=zoo_kmeans(file,7,300);
plot_k_means(7,cv,cat);