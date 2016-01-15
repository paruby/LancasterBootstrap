function [ results ] = bootstrap_null(m,numBootstrap,...
    statMatrix,alpha,wild_bootstrap,test_type)

processes = wild_bootstrap(m,numBootstrap);

testStat = m*mean2(statMatrix);

testStats = zeros(numBootstrap,1);
for process = 1:numBootstrap
    mn = mean(processes(:,process));
    if test_type==1
        %matFix = (processes(:,process)-mn)*(processes(:,process)-mn)';
        vec = processes(:,process)-mn;
    else
        %matFix = processes(:,process)*processes(:,process)';
        vec = processes(:,process);
    end
    %testStats(process) =  m*mean2(statMatrix.*matFix );
    testStats(process) = (1/m)*(vec'*statMatrix*vec);
end

results.testStat = testStat;
results.quantile = quantile(testStats,1-alpha);
results.reject = testStat > results.quantile;
results.pvalue = sum(testStats>testStat)/length(testStats);
end

