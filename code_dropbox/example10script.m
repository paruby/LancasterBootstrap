%this experiment uses example 9 (X->Z<-Y with edges detectable by HSIC). We
%perform the experiments for varying degrees of dependence of Z on X and Y
% we compare the test power of the lancaster test and the HSIC-based joint
% factorisation test
clear all

dependence_coefficients = 0:0.005:0.04;
%first columns are for HSIC, second columns are for lancaster, 4&5 for
%3HSIC
rejections = zeros(length(dependence_coefficients),4);%for alpha=0.05
%also record all of the pvalues in case we want to do something later
pvalues=cell(length(dependence_coefficients),2);
for j=1:length(dependence_coefficients);
    fprintf('Simulating data with dependence coeff:')
    fprintf(num2str(dependence_coefficients(j)))
    fprintf('\n------------------------\n')
    numexps = 500;
    
    num_rejects_HSIC = 0;
    num_rejects_Lancaster_naive = 0;
    num_rejects_Lancaster_bonferroni = 0;
    num_rejects_3HSIC_naive = 0;
    num_rejects_3HSIC_bonferroni = 0;
    
    pvalues_lancaster = zeros(numexps,3);
    pvalues_HSIC = zeros(numexps,3);
    pvalues_3HSIC = zeros(numexps,3);
    for i=1:numexps;
        if mod(i,1)==0;
            fprintf(num2str(i))
            fprintf(', ')
        end
        if mod(i,10)==0;
            fprintf('\n')
        end
        [X,Y,Z] = example10(2000,dependence_coefficients(j));%dependence_coefficients(j));
        [T,results] = evalc('all_tests(X,Y,Z,1,250,0.05);');
        pvalues_lancaster(i,:) = results.sorted_pvalues;
        pvalues_HSIC(i,:) = results.HSIC_p_sorted;
        pvalues_3HSIC(i,:) = results.sorted_pvalues_3HSIC;
        if results.reject_factorisation_HSIC ==1;
            num_rejects_HSIC = num_rejects_HSIC+1;
        end
        if results.reject_lancaster_null_naive ==1;
            num_rejects_Lancaster_naive = num_rejects_Lancaster_naive+1;
        end
        if results.reject_lancaster_null_bonferroni ==1;
            num_rejects_Lancaster_bonferroni = num_rejects_Lancaster_bonferroni+1;
        end
        if results.reject_3HSIC_null_naive ==1;
            num_rejects_3HSIC_naive = num_rejects_3HSIC_naive+1;
        end
        if results.reject_3HSIC_null_bonferroni ==1;
            num_rejects_3HSIC_bonferroni = num_rejects_3HSIC_bonferroni+1;
        end
    end
    pvalues{j,1} = pvalues_HSIC;
    pvalues{j,2} = pvalues_lancaster;
    rejections(j,1) = num_rejects_HSIC/numexps;
    rejections(j,2) = num_rejects_Lancaster_naive/numexps;
    rejections(j,3) = num_rejects_Lancaster_bonferroni/numexps;
    rejections(j,4) = num_rejects_3HSIC_naive/numexps;
    rejections(j,5) = num_rejects_3HSIC_bonferroni/numexps;
end
tosave_with3HSIC = {rejections,pvalues};
save('example10script_with3HSIC','tosave_with3HSIC')

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
plot(dependence_coefficients,rejections(:,5),'-og')

legend('Lancaster with simple correction','Lancaster with Holm-Bonferroni','3-way HSIC with simple correction','3-way HSIC with Holm-Bonferroni','Location','NorthWest')


ti = get(gca,'TightInset')
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/ICML_Figure1.pdf');
saveas(h,'figures/ICML_Figure1.fig');
