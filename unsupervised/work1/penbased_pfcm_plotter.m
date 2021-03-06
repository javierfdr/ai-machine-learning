% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [] = penbased_pfcm_plotter(file,clist,niters,nattempts, performance_it, plot_graph, plot_silhouette)
    
    [standarized_data, data_struct] = prepare_penbased(file);
    pfcm_plotter(standarized_data,data_struct.a17.values()',clist,niters,nattempts, performance_it, plot_graph, plot_silhouette,'generated_files/pfcm/penbased/');
   
end
