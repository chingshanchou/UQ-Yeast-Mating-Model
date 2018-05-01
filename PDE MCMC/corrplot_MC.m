%MC = load('MC_2e6_15p');
C = corrcoef(MC);
C = [C zeros(size(C,1),1)];
C = [C; zeros(1,size(C,2))];

h1 = pcolor(C);
colormap(gray)
h = colorbar;
ylabel(h,'Correlation coefficient');
shading flat
%keyboard
%// get axes handle
ax = gca;
names = {'k_{24cm0}',
'k_{24cm1}',
'k_{24d}',
'k_{42a}',
'k_{42d}',
'k_{B1cm}',
'k_{B1mc}',
'k_{Cla4a}',
'k_{Cla4d}',
'C24_t',
'B1_t',
'q',
'h',
'D_{c42}',
'D_{c42a}'};

%// labels (shortened to fit data)
%// adjust position of ticks
set(ax,'XTick', (1:size(C,2))+0.5 )
set(ax,'YTick', (1:size(C,1))+0.5 )
%// set labels
set(ax,'XTickLabel',names)
set(ax,'YTickLabel',names)

set(gca,'fontsize',14)