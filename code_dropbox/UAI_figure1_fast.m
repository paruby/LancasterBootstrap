load('UAI_figure1.mat')
dependence_coefficients = 0:0.001:0.2;
rejections = tosave_with3HSIC{1};

%generate plot
h=figure;

%plot(dependence_coefficients,rejections(:,1),'-o')
plot(dependence_coefficients,rejections(:,2),'-or')
xlabel('Dependence coefficient')
ylabel('Power')
title('Power of HSIC and Lancaster joint factorisation tests')

hold


plot(dependence_coefficients,rejections(:,3),'-o','color',[1,0.7,0])
plot(dependence_coefficients,rejections(:,4),'-ob')
plot(dependence_coefficients,rejections(:,5),'-o','color',[0 0.8 0] )

legend('Lancaster (S)',...
'Lancaster (HB)',...
'3-way HSIC (S)',...
'3-way HSIC (HB)','Location','SouthEast')


ti = get(gca,'TightInset')
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/UAI_Figure1.pdf');
saveas(h,'figures/UAI_Figure1.fig');