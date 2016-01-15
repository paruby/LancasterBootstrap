function [ results ] = perm_null(m,numPerm,...
    permMat,fixMat,alpha)

testStat = m*mean2(permMat.*fixMat);

testStats = zeros(numPerm,1);
for process = 1:numPerm
    r = randperm(m);
    permutedMat = permMat(r,r);
    nullSampleMat = permutedMat.*fixMat;
    testStats(process) =  m*mean2(nullSampleMat );
end

results.testStat = testStat;
results.quantile = quantile(testStats,1-alpha);
results.reject = testStat > results.quantile;
results.pvalue = sum(testStats>testStat)/length(testStats);
end

