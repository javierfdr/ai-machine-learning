% graphs the polynomial of degree np from a range of x
% values within [minx,maxx] and using the given graph 
% weights gdw. A precreated figure is asummed.
function [rms] = polygraph(p,minx,maxx,w,marker)
     
    xrange = minx:0.01:maxx;
    xrange = xrange';
    xpanded = expand_dataset(xrange,p);

    o = ones(size(xpanded,1),1);
    xrange_expanded = [o,xpanded]; 
    y = lfunc(w,xrange_expanded);
    plot(xrange,y,marker); hold on;
    
end