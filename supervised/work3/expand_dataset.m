function [z] = expand_dataset(x,p)
    z = x;
    for i=2:p
        z = [z,x.^i];
    end
end

