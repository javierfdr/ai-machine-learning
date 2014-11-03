% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = zoo_pfcm_hi_typ_plotter(file,clist,niters,nattempts, performance_it, plot_graph, plot_silhouette)
    
    [standarized_data, data_struct] = prepare_zoo_kmeans(file);
    pfcm_hi_typ_plotter(standarized_data,data_struct.type.values()',clist,niters,nattempts, performance_it, plot_graph, plot_silhouette,'generated_files/pfcm_hi_typ/zoo/');
   
end
