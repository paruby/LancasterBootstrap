clear all
data = csvread('data/CHF-USD-GBP-CAD/CHF-USD-CHF-GBP-USD-CAD.csv');
X = data(:,1);
Y = data(:,2);
Z = data(:,3);

X=flipud(X);
Y=flipud(Y);
Z=flipud(Z);

X = log(X);
Y = log(Y);
Z = log(Z);

Xraw = X;
Yraw = Y;
Zraw = Z;

Xs = smooth(X);
Ys = smooth(Y);
Zs = smooth(Z);

Xp=X-Xs;
Yp=Y-Ys;
Zp=Z-Zs;

%normalised timeseries data
X = X - mean(X);
X = X./sqrt(var(X));

Y = Y - mean(Y);
Y = Y./sqrt(var(Y));    

Z = Z - mean(Z);
Z = Z./sqrt(var(Z));

%fluctuations of timeseries data

Xp = Xp - mean(Xp);
Xp = Xp./sqrt(var(Xp));

Yp = Yp - mean(Yp);
Yp = Yp./sqrt(var(Yp));    

Zp = Zp - mean(Zp);
Zp = Zp./sqrt(var(Zp));

results_normalised = all_tests(X',Y',Z',0.2,500,0.05);

h=figure

plot(X)
hold
plot(Y)
plot(Z)
legend('CHF/USD','CHF/GBP','USD/CAD')
xlabel('days since 01/01/1990')
ylabel('Log-exchange rate (normalised)')
title('Pre-processed exchange rate data')

ti = get(gca,'TightInset')
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/real_data_example_normalised_data.pdf');
saveas(h,'figures/real_data_example_normalised_data.fig');


results_fluctuations = all_tests(Xp',Yp',Zp',0.8,500,0.05);

h=figure
subplot(3,1,1)
plot(Xp)
title('Fluctuations from running average exchange rate data')
legend('CHF/USD')
subplot(3,1,2)
plot(Yp,'color',[0.8500    0.3250    0.0980])
legend('CHF/GBP')
ylabel('Log-exchange rate fluctuations (normalised)')
subplot(3,1,3)
plot(Zp,'color', [0.9290    0.6940    0.1250])
legend('USD/CAD')
xlabel('days since 01/01/1990')


% ti = get(gca,'TightInset')
% set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
% set(gca,'units','centimeters')
% pos = get(gca,'Position');
% ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/real_data_example_fluctuations.pdf');
saveas(h,'figures/real_data_example_fluctuations.fig');