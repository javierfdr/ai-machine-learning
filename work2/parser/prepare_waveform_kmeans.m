% Introduction to Machine Learning (IML) - project 1
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function [std_data_matrix, parsed_data] = prepare_waveform_kmeans(file)
    pf = arffparser('read',file);
    data_struct = pf
    %% preparing attributes
    x1 = pf.x1.values()';
    x2 = pf.x2.values()';
    x3 = pf.x3.values()';
    x4 = pf.x4.values()';
    x5 = pf.x5.values()';
    x6 = pf.x6.values()';
    x7 = pf.x7.values()';
    x8 = pf.x8.values()';
    x9 = pf.x9.values()';
    x10 = pf.x10.values()';
    x11 = pf.x11.values()';
    x12 = pf.x12.values()';
    x13 = pf.x13.values()';
    x14 = pf.x14.values()';
    x15 = pf.x15.values()';
    x16 = pf.x16.values()';
    x17 = pf.x17.values()';
    x18 = pf.x18.values()';
    x19 = pf.x19.values()';
    x20 = pf.x20.values()';
    x21 = pf.x21.values()';
    x22 = pf.x22.values()';
    x23 = pf.x23.values()';
    x24 = pf.x24.values()';
    x25 = pf.x25.values()';
    x26 = pf.x26.values()';
    x27 = pf.x27.values()';
    x28 = pf.x28.values()';
    x29 = pf.x29.values()';
    x30 = pf.x30.values()';
    x31 = pf.x31.values()';
    x32 = pf.x32.values()';
    x33 = pf.x33.values()';
    x34 = pf.x34.values()';
    x35 = pf.x35.values()';
    x36 = pf.x36.values()';
    x37 = pf.x37.values()';
    x38 = pf.x38.values()';
    x39 = pf.x39.values()';
    x40 = pf.x40.values()';
    
    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40];
    std_data_matrix = standarizer(data_matrix);
    parsed_data = pf;
    
    
end
