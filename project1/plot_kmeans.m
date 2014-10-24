% Plots a bidemensional matrix A and the found centroids cent
function [] = plot_kmeans(A,cent)
    figure('name','K-Means plot');
    plot(A(:,1),A(:,2),'rx',cent(:,1),cent(:,2),'.b');
    plot(A(:,1),A(:,2),'rx',cent(:,1),cent(:,2),'.b');
end