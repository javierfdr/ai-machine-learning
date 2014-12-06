% Introduction to Machine Learning (IML) - Exercise 4
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

function ws = alinealreg(x,y)

    xtilde = [ones(1,size(x,2)); x];
    % the function pinv should be equivalent to:
    % xtildepsi1 = inv(xtilde1*xtilde1')*xtilde1;
    xtildepsi = pinv(xtilde)';
    ws = xtildepsi * y;

end
