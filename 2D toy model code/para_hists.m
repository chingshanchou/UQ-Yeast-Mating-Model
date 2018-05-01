function para_hists()

names = {'k_{Ga}','k_{Gd}'};
theta = load('MC');
total = size(theta,1);

figure(1)
burn = round(0.2*total); % burn-in, number of iterates to throw away
% Histograms 
for i = 1:2
    subplot(2,1,i)
    histogram(theta(burn:end,i),'BinWidth',0.05,'Normalization','pdf')
    xlim([-1 1]);
    yl = ylim;
    title(names{i})
    set(gca,'fontsize',14)
end
figure(2)
EDGES{1} = linspace(-1,1,201);
EDGES{2} = linspace(-1,1,201);
n = hist3(theta,'Edges',EDGES,'Normalization','pdf'); % default is to 10x10 bins
n1 = n';
%n1(size(n,1) + 1, size(n,2) + 1) = 0;
%xb = linspace(min(theta(:,1)),max(theta(:,1)),size(n,1)+1);
%yb = linspace(min(theta(:,2)),max(theta(:,2)),size(n,1)+1);
h = pcolor(EDGES{1},EDGES{2},n1);
h.ZData = ones(size(n1)) * -max(max(n));
colormap(jet) % heat map
colorbar
%contour(n1)
xlabel('k_{Ga}');
ylabel('k_{Gd}');
xlim([-1 1])
ylim([-1 1])
set(gca,'fontsize',14)

end