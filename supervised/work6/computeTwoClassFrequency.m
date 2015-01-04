
% Computes the frequency of classes -1 and 1 givin a vector of 
% index of datapoints and a full labels vector to match the class
function [c1f, c2f] = computeTwoClassFrequency(dataIndex, labels)
    classes = labels(dataIndex);
    c1f = size(find(classes==-1),1);
    c2f = size(find(classes==1),1);
end