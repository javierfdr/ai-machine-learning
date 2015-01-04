function [] = draw_soft_margin_rbf(data,labels,afunc,sv,figurename)
    figure('name',figurename);axis([-1 1 -1 1]);hold on; 
    data = data';
    d1 = data(labels==-1,:);
    d2 = data(labels==1,:);
    
    plot(d1(:,1),d1(:,2),'rx'); hold on;
    plot(d2(:,1),d2(:,2),'b*');

    % drawing the support vectors
    plot(sv(:,1),sv(:,2),'go'); hold on;

    % drawing the margins
    x1plot = linspace(min(data(:,1)), max(data(:,1)), 100)';
    x2plot = linspace(min(data(:,2)), max(data(:,2)), 100)';
    [X1, X2] = meshgrid(x1plot, x2plot);
    vals = zeros(size(X1));
    for i = 1:size(X1, 2)
       this_X = [X1(:, i), X2(:, i)];
       vals(:, i) = afunc(this_X');
    end
    
    % Plot the SVM boundary
    contour(X1, X2, vals, [0 0], '-g');
    contour(X1, X2, vals, [-1 1], '--g');
    set(gcf,'renderer','OpenGL');

end