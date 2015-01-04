function [std_data_matrix, parsed_data] = prepare_predibet(file)
    pf = arffparser('read',file);
    data_struct = pf;
    %% preparing attributes
    t1level = pf.t1level.values()';
    t1pts = pf.t1pts.values()';
    t1results = pf.t1results.values()';
    t1pos = pf.t1pos.values()';
    t1gf = pf.t1gf.values()';
    t1ga = pf.t1ga.values()';
    t1home = pf.t1home.values()';
    t2level = pf.t2level.values()';
    t2pts = pf.t2pts.values()';
    t2results = pf.t2results.values()';
    t2pos = pf.t2pos.values()';
    t2gf = pf.t2gf.values()';
    t2ga = pf.t2ga.values()';
    t2away= pf.t2away.values()';
    
    data_matrix = [t1level, t1pts,t1results,t1pos, t1gf,t1ga,t1home,t2level,t2pts,t2results,t2pos,t2gf,t2ga,t2away];
    std_data_matrix = standarizer(data_matrix);
    parsed_data = pf;
    
end
