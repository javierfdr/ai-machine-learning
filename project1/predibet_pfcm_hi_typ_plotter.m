
function [] = predibet_pfcm_hi_typ_plotter(file,clist,niters,nattempts, performance_it, plot_graph, plot_silhouette)
    
    [standarized_data, data_struct] = prepare_predibet(file);
    pfcm_hi_typ_plotter(standarized_data,data_struct.result.values()',clist,niters,nattempts, performance_it, plot_graph, plot_silhouette,'generated_files/pfcm_hi_typ/predibet/');
   
end
