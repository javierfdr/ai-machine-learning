% Introduction to Machine Learning (IML) - Work 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)
% Based on the work of Pramod  Vemulapalli, see kd_buildtree for details

function [IDX,d] = kd_knnsearch(TREE,Y,K,node_number)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS
% TREE        --- the cell array that contains the tree
% Y           --- the point of interest
% K           --- the number of neighbors to retrieve
% node_number --- Internal Variable, Do not Define

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUTS
% IDX  --- the indexes of the knn in the original matrix that were used
%          to build the tree
% d    --- the distance from the knn to the given point

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global best_points_mat
global number_of_points
global tree_cell
global safety_check;

dim =size(Y,2);
IDX=[];
d=[];

if (nargin==3)
    safety_check=0;
    best_points_mat=zeros(K,dim+1+1+1);% for index in tree, index in original mat, dist to point
    number_of_points=0;
    node_number=1;

    tree_cell=TREE;
    clear TREE;
end

if (isempty(safety_check))
    error ('Insufficient number of input variables ... please check ');
end


% if the current node is a leaf then output its results
if(strcmp(tree_cell(node_number).type,'leaf'))
    node_check(Y,K,node_number);
    return;
end

% if the current node is not a leaf
% check to see if the point is to the left of the split dimension
% if it is to the left then recurse to the left
if (Y(tree_cell(node_number).splitdim)<=tree_cell(node_number).splitval)
    if (isempty(tree_cell(node_number).left))
        % incase the left node is empty, then output current results
    else
        kd_knnsearch(0,Y,K,tree_cell(node_number).left);
    end
else
    % as the point is to the right of the split dimension
    % recurse to the right
    if (isempty(tree_cell(node_number).right))
        % incase the right node is empty, then output current results
    else
        kd_knnsearch(0,Y,K,tree_cell(node_number).right);
    end    
end

% do the computation to decide if you need to search on the otherside
if (number_of_points<K)
    search_otherside= 'true';
else

    sum_value=0;
    dist_of_kthpoint=best_points_mat(K,dim+3);

    for i=1:dim

        if (Y(i)<tree_cell(node_number).hyperrect(1,i))
            sum_value = sum_value + (Y(i)-tree_cell(node_number).hyperrect(1,i)).^2;
            if (sum_value > dist_of_kthpoint)
                search_otherside='false';
                break;
            end
        elseif (Y(i)>tree_cell(node_number).hyperrect(2,i))
            sum_value = sum_value + (Y(i)-tree_cell(node_number).hyperrect(2,i)).^2;
            if (sum_value > dist_of_kthpoint)
                search_otherside='false';
                break;
            end
        end
    end

    search_otherside= 'true';
end



if (strcmp(search_otherside,'true'))

    node_check(Y,K,node_number);

    % if the current node is not a leaf
    % check to see if the point is to the left of the split dimension
    % if it is to the left then decide whether to recurse to the right
    if (Y(tree_cell(node_number).splitdim)<=tree_cell(node_number).splitval)
        if (isempty(tree_cell(node_number).right))
            % incase the right node is empty, then output current results

        else
            % as the Y is to the right of the split dimension
            % decide whether to recurse to the left
            kd_knnsearch(0,Y,K,tree_cell(node_number).right);
        end  
    else
        if (isempty(tree_cell(node_number).left))
            % incase the left node is empty, then output current results

        else
            % as the point is to the right of the split dimension
            % decide whether to recurse to the left
            kd_knnsearch(0,Y,K,tree_cell(node_number).left);
        end
    end

end

if (nargin==3)

    best_points_mat=sortrows(best_points_mat,dim+1);
    IDX=best_points_mat(1:number_of_points,dim+1)';
    d=sqrt(best_points_mat(1:number_of_points,dim+3)');

    clear global best_points_mat;
    clear global number_of_points;
    clear global tree_cell;
    clear global safety_check;

end


function []=node_check(point,k,node_number)

    %global best_points_mat
    %global number_of_points
    %global tree_cell

    dim =size(point,2);
    distance = sum((point-tree_cell(node_number).nodevector).^2);

    for numindex = 1:size(tree_cell(node_number).index);
        if (number_of_points==k && best_points_mat(k,dim+3)>distance)
            best_points_mat(k,1:dim)=tree_cell(node_number).nodevector;
            best_points_mat(k,dim+1)=tree_cell(node_number).index(numindex);
            best_points_mat(k,dim+2)=node_number;
            best_points_mat(k,dim+3)=distance;
            best_points_mat=sortrows(best_points_mat,dim+3);

        elseif(number_of_points<k)
            number_of_points=number_of_points+1;
            best_points_mat(number_of_points,1:dim)=tree_cell(node_number).nodevector;
            best_points_mat(number_of_points,dim+1)=tree_cell(node_number).index(numindex);
            best_points_mat(number_of_points,dim+2)=node_number;
            best_points_mat(number_of_points,dim+3)=distance;
            % once the variable gets filled up then sort the rows 
            if(number_of_points==k)
                best_points_mat=sortrows(best_points_mat,dim+3);
            end

        end
    end
end

return;

end
