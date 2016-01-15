%this experiment uses example 11 (for which the null hypothesis is true)
%and calculates the pvalues for many repeated runs of the same experiment.
%It calculates the sorted pvalues for each of them and then works out what
%the empirical type I error rate is as a function of the alpha cut off
%(which should be the theoretical type I error rate)
clear all
numexps = 4000;

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
    [X,Y,Z] = example11(1000);
    [T,results] = evalc('all_tests(X,Y,Z,1,500,0.05);');
    pvalues_lancaster(i,:) = results.sorted_pvalues;
    pvalues_HSIC(i,:) = results.HSIC_p_sorted;
    pvalues_3HSIC(i,:) = results.sorted_pvalues_3HSIC;
end

tosave = {pvalues_lancaster,pvalues_HSIC,pvalues_3HSIC};
save('error_rate_pvalues_example11_2_with3HSIC','tosave')

%generate plot
h=figure;


%pairwise HSIC with holm-bonferroni
alpha=0:0.01:0.25;
typeIerror = zeros(1,length(alpha));
for j=1:length(alpha);
    counter=0;
    threshold = 4 - [1,2,3];
    threshold = [alpha(j),alpha(j),alpha(j)]./threshold;
    for i=1:numexps;
        p_sorted = pvalues_HSIC(i,:);
        critical = (p_sorted<threshold);
%         if isequal(find(p_sorted<threshold,1,'last'),3)
%             counter = counter+1;
%         end
          if critical(1)==1 && critical(2)==1;
              counter = counter+1;
          end
    end
    typeIerror(j) = counter/numexps;
end
plot(alpha,typeIerror,'-o')


xlabel('Desired type I error rate \alpha')
ylabel('empirical type I error rate')
title('Controlling Type I error')

hold
%Lancaster with naive
typeIerror = zeros(1,length(alpha));
for j=1:length(alpha);
    counter=0;
    for i=1:numexps;
        p_sorted = pvalues_lancaster(i,:);
          if sum(p_sorted<alpha(j))==3
              counter = counter+1;
          end
    end
    typeIerror(j) = counter/numexps;
end
plot(alpha,typeIerror,'-o')
alpha=0:0.01:0.25;

%Lancaster with holm bonferroni
typeIerror = zeros(1,length(alpha));
for j=1:length(alpha);
    counter=0;
    threshold = 4 - [1,2,3];
    threshold = [alpha(j),alpha(j),alpha(j)]./threshold;
    for i=1:numexps;
        p_sorted = pvalues_lancaster(i,:);
%         if isequal(find(p_sorted<threshold,1,'last'),3)
%             counter = counter+1;
%         end
          if sum(p_sorted<threshold)==3
              counter = counter+1;
          end
    end
    typeIerror(j) = counter/numexps;
end

plot(alpha,typeIerror,'-o')

%3HSIC with naive
typeIerror3HSICnaive = zeros(1,length(alpha));
for j=1:length(alpha);
    counter=0;
    for i=1:numexps;
        p_sorted = pvalues_3HSIC(i,:);
          if sum(p_sorted<alpha(j))==3
              counter = counter+1;
          end
    end
    typeIerror3HSICnaive(j) = counter/numexps;
end
plot(alpha,typeIerror3HSICnaive,'-o')
alpha=0:0.01:0.25;

%3HSIC with holm bonferroni
typeIerror3HSIChb = zeros(1,length(alpha));
for j=1:length(alpha);
    counter=0;
    threshold = 4 - [1,2,3];
    threshold = [alpha(j),alpha(j),alpha(j)]./threshold;
    for i=1:numexps;
        p_sorted = pvalues_3HSIC(i,:);
          if sum(p_sorted<threshold)==3
              counter = counter+1;
          end
    end
    typeIerror3HSIChb(j) = counter/numexps;
end

plot(alpha,typeIerror3HSIChb,'-o')

legend('Pairwise HSIC with Holm-Bonferroni','Lancaster with "Naive" correction','Lancaster with Holm-Bonferroni','3-way HSIC with "Naive" correction','3-way HSIC with Holm-Bonferroni','Location','NorthWest')


ti = get(gca,'TightInset')
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
saveas(h,'figures/TypeIErrorExample11_with3HSIC.pdf');
saveas(h,'figures/TypeIErrorExample11_with3HSIC.fig');

