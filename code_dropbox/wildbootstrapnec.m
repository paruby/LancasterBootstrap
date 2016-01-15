clear all

dependence_coefficients = [0.1,0.3,0.5,0.6,0.7,0.8,0.9];
%first column for bootstrap, second columns for permutation
rejections = zeros(length(dependence_coefficients),2);%for alpha=0.05
%also record all of the pvalues in case we want to do something later
pvalues=cell(length(dependence_coefficients),2);
for j=1:length(dependence_coefficients);
    fprintf('Simulating data with dependence coeff:')
    fprintf(num2str(dependence_coefficients(j)))
    fprintf('\n------------------------\n')
    numexps = 500;
    
    num_rejects_Lancaster_naive = 0;
    num_rejects_Lancaster_perm = 0;
    
    for i=1:numexps;
        if mod(i,1)==0;
            fprintf(num2str(i))
            fprintf(', ')
        end
        if mod(i,10)==0;
            fprintf('\n')
        end
        [X,Y,Z] = example13(1000,dependence_coefficients(j));%dependence_coefficients(j));
        [T,results] = evalc('justLancasterBSandPerm(X,Y,Z,1,250,0.05);');
        if results.reject_lancaster_null_naive ==1;
            num_rejects_Lancaster_naive = num_rejects_Lancaster_naive+1;
        end
        if results.reject_lancaster_null_naive_perm ==1;
            num_rejects_Lancaster_perm = num_rejects_Lancaster_perm+1;
        end
    end
    rejections(j,1) = num_rejects_Lancaster_naive/numexps;
    rejections(j,2) = num_rejects_Lancaster_perm/numexps;
end
tosave = {rejections};
save('wildbootstrapnec','tosave')

h=figure;

plot(dependence_coefficients,rejections(:,1),'-o')
xlabel('Dependence coefficient')
ylabel('Type I error')
title('False positives - Wild Bootstrap vs Permutation')

hold

plot(dependence_coefficients,rejections(:,2),'-o')


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
saveas(h,'figures/wildBootstrap_is_necessary.pdf');
saveas(h,'figures/wildBootstrap_is_necessary.fig');
