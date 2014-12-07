% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function dispvarray(array)
    disp(['[', strjoin(arrayfun(@num2str,array,'UniformOutput',false),';'), ']']);
    disp('');
end
