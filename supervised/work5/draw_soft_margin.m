function [] = draw_soft_margin(data,labels,a,b,sv)
    figure('name','Soft margin on toy dataset');axis([-1 1 -1 1]);hold on; 
    xmin = min(data,[],2);
    xmax = max(data,[],2);

    % Projecting in 2d ( taking the first feature only)
    x = linspace(-1,1,100);
    y = (-(a(1)*x)-b)/a(2); % solving plane == 0 %
    plot(x,y,'g-'); hold on;

    data = data';
    d1 = data(labels==-1,:);
    d2 = data(labels==1,:);

    plot(d1(:,1),d1(:,2),'rx'); hold on;
    plot(d2(:,1),d2(:,2),'b*');

    % drawing the support vectors
    plot(sv(:,1),sv(:,2),'go'); hold on;

    % drawing the margins
    x = linspace(-1,1,100);
    y = (1-(a(1)*x)-b)/a(2); % margin line == 1
    plot(x,y,'g--'); hold on;

    x = linspace(-1,1,100);
    y = (-1-(a(1)*x)-b)/a(2); % margin line == 1
    plot(x,y,'g--'); hold on;

end