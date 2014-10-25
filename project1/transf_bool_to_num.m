% Converts an horizontal vector of 'true'/'false' values to a 1/0 vector
% of the same dimensions
function [t_vector] = transf_bool_to_num(vector)
    t_vector = [];
    ncol = size(vector,1);
    for i = 1:ncol
        t_vector = [t_vector; str2num(char(vector(i,1)))];
    end
end