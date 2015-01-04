function [newCategories] = predibetCategoriesToNumbers(categories)
    home = strcmp(categories,'winhome');
    away = strcmp(categories,'winaway');
    away = away*2;
    draw = strcmp(categories,'draw');
    draw = draw*3;
    
    newCategories = home+away+draw;
    
end