% calculates the error 1/-1 target values
function [error,accuracy] = getClassificationError(result,labels)
    class1 = find(result<0);
    class2 = find(result>0);

    wellClassified1 = size(find(labels(class1)==-1),1);
    wellClassified2 = size(find(labels(class2)== 1),1);

    wellClassified = wellClassified1+wellClassified2;

    accuracy = wellClassified/(size(class1,1)+size(class2,1));
    error = 1-accuracy;
end