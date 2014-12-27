function [combination] = getCombination(i)
    %combinations = ['DD-O','DD','DE-O','DE','NR-O','NR','AR-O','AR'];
    if i==1
       combination = 'DD-O';
    elseif i==2
       combination = 'DD';
    elseif i==3
        combination = 'DE-O';
    elseif i==4
        combination = 'DE';
    elseif i==5
        combination = 'NR-O';
    elseif i==6
        combination = 'NR';
    elseif i==7
        combination = 'AR-O';
    elseif i==8
        combination = 'AR';        
    end
end