% Processes the given file applying k-means to each k in klist with
% a maximum of niters number of iterations for each kmeans run.
% The results of each run are plotted and the a performance graph
% is returned. This process is repeated nattempts times understanding
% the variability of the results
function [] = zoo_kmeans_plotter(file,klist,niters,nattempts, plot_graph)
    
    [standarized_data, data_struct] = prepare_zoo_kmeans(file);
    kmeans_plotter(standarized_data, data_struct.type.values()', klist, niters, nattempts, plot_graph);
   
end