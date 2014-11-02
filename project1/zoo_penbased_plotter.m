% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = zoo_penbased_plotter(file,klist,niters,nattempts, performance_it, plot_graph, plot_silhouette)
    
    [standarized_data, data_struct] = prepare_penbased(file);
    kmeans_plotter(standarized_data, data_struct.a17.values()', klist, niters, nattempts,performance_it, plot_graph, plot_silhouette, 'generated_files/kmeans/penbased/');
   
end
