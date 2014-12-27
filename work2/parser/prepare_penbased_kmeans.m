% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [std_data_matrix, parsed_data] = prepare_penbased_kmeans(file)
    pf = arffparser('read',file);
    data_struct = pf
    %% preparing attributes
    a1 = pf.a1.values()';
    a2 = pf.a2.values()';
    a3 = pf.a3.values()';
    a4 = pf.a4.values()';
    a5 = pf.a5.values()';
    a6 = pf.a6.values()';
    a7 = pf.a7.values()';
    a8 = pf.a8.values()';
    a9 = pf.a9.values()';
    a10 = pf.a10.values()';
    a11 = pf.a11.values()';
    a12 = pf.a12.values()';
    a13 = pf.a13.values()';
    a14 = pf.a14.values()';
    a15 = pf.a15.values()';
    a16 = pf.a16.values()';
    
    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16];
    std_data_matrix = standarizer(data_matrix);
    parsed_data = pf;
    
    
end
