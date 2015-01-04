function [w] = categoriesToArray(catCell)
    w = [];
    for i=1:size(catCell)
        v = 0;
        
        c = char(catCell(i));
        
        sh = size(char(catCell(i)))==size('winhome');
        sd = size(char(catCell(i)))==size('draw');
        sa = size(char(catCell(i)))==size('winaway');
        
        if sh==1
            comphome = (c=='winhome');
        else
            comphome = [0 1];
        end
        
        if sd==1
            compdraw = (c=='draw');
        else
            compdraw = [0 1];
        end
        
        if sa==1
            compaway = (c=='winaway');
        else
            compaway = [0 1];
        end
        
        
        if min(comphome)==max(comphome)
           w = [w,0]; 
        elseif min(compdraw)==max(compdraw)
            w = [w,0.5];
        elseif min(compaway)==max(compaway)
            w = [w,1];
        end
    end
    
end