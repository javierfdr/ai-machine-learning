function [totalStats] = insertStats(combStats,totalStats, combination,isWeighted)
    combinations = ['DD-O','DD','DE-O','DE','NR-O','NR','AR-O','AR'];
    
    if size(combination,2)==4
        if isequal(combination(1,1:4),'DD-O')           
            if ~isWeighted
                totalStats = setfield(totalStats,'DDO',combStats);
            elseif isWeighted
                totalStats.WDDO = combStats;
            end
        elseif isequal(combination(1:4),'DE-O')
            if ~isWeighted
                totalStats.DDE = combStats;
            elseif isWeighted
                totalStats.WDDE = combStats;
            end     
        elseif isequal(combination(1:4),'NR-O')
            if ~isWeighted
                totalStats.NRO = combStats;
            elseif isWeighted
                totalStats.WNRO = combStats;
            end        
        elseif isequal(combination(1:4),'AR-O')
            if ~isWeighted
                totalStats.ARO = combStats;
            elseif isWeighted
                totalStats.WARO = combStats;
            end                    
        end
    
    elseif size(combination,2)==2
        if isequal(combination(1:2),'DD')
            if ~isWeighted
                totalStats.DD = combStats;
            elseif isWeighted
                totalStats.WDD = combStats;
            end        
        elseif isequal(combination(1:2),'DE')
            if ~isWeighted
                totalStats.DE = combStats;
            elseif isWeighted
                totalStats.WDE = combStats;
            end         
        elseif isequal(combination(1:2),'NR')
            if ~isWeighted
                totalStats.NR = combStats;
            elseif isWeighted
                totalStats.WNR = combStats;
            end          
        elseif isequal(combination(1:2),'AR')
            if ~isWeighted
                totalStats.AR = combStats;
            elseif isWeighted
                totalStats.WAR = combStats;
            end                      
        end   
    end
    
    
    
end