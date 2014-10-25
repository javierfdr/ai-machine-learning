function [] = tester()

%file = '../docs/data/zoo.arff';
%[pd, cv, cent, niters]=zoo_kmeans(file,7,300);
%cat = pd.type.values()';
%plot_k_means(7,cv,cat);

file = '../docs/data/segment.arff';
[pd, cv, cent, niters]=segment_kmeans(file,3,300);
cat = pd.class.values()';
plot_k_means(3,cv,cat);