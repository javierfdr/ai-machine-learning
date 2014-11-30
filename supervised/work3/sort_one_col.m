% Sorts the first column of matrix x preserving the order for the rest
function [sortedmatrix] = sort_one_col(x)
    [values, order] = sort(x(:,1));
    sortedmatrix = x(order,:);
end