load('wildbootstrapnec.mat')
dependence_coefficients = [0.1,0.3,0.5,0.6,0.7,0.8,0.9];
rejections = tosave{1};

h=figure;

plot(dependence_coefficients,rejections(:,1),'-or')
xlabel('Dependence coefficient')
ylabel('Type I error')
title('False positives - Wild Bootstrap vs Permutation')

hold

plot(dependence_coefficients,rejections(:,2),'-o','color',[1,0.7,0])


legend('Lancaster with Wild Bootstrap','Lancaster with Permutation Bootstrap','Location','NorthWest')


ti = get(gca,'TightInset')
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/ICML_figure2.pdf');
saveas(h,'figures/ICML_figure2.fig');