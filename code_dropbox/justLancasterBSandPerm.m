%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%performs each of the 4 tests, taking the data
%as input using Gaussian kernel with fixed sigma
%for all data
function [all_results] = justLancasterBSandPerm(X,Y,Z,sigma,numBootstraps,alpha)
n=length(X);
%TODO: add check that X,Y,Z same length

fprintf('Constructing X gram matrix...\n')
K = GaussKern(X',X',sigma);
fprintf('Constructing Y gram matrix...\n')
L = GaussKern(Y',Y',sigma);
fprintf('Constructing Z gram matrix...\n')
M = GaussKern(Z',Z',sigma);

Kc = empirically_centre(K);
Lc = empirically_centre(L);
Mc = empirically_centre(M);

KLc = empirically_centre(K.*L);
KMc = empirically_centre(K.*M);
LMc = empirically_centre(L.*M);

clear K;
clear L;
clear M;


fprintf('Constructing X independence test statistic...\n')
xMatrix = Kc.*empirically_centre(Lc.*Mc);
fprintf('Bootstrapping X independence test statistic...\n')
xresults = bootstrap_null(n,numBootstraps,xMatrix,alpha,@bootstrap_series,2);
fprintf('Permuting X independence test statistic...\n')
xperm = perm_null(n,numBootstraps,Kc,Lc.*Mc,0.05);
clear xMatrix


fprintf('Constructing Y independence test statistic...\n')
yMatrix = Lc.*empirically_centre(Kc.*Mc);
fprintf('Bootstrapping Y independence test statistic...\n')
yresults = bootstrap_null(n,numBootstraps,yMatrix,alpha,@bootstrap_series,2);
fprintf('Permuting Y independence test statistic...\n')
yperm = perm_null(n,numBootstraps,Lc,Mc.*Mc,0.05);
clear yMatrix

fprintf('Constructing Z independence test statistic...\n')
zMatrix = Mc.*empirically_centre(Kc.*Lc);
fprintf('Bootstrapping Z independence test statistic...\n')
zresults = bootstrap_null(n,numBootstraps,zMatrix,alpha,@bootstrap_series,2);
fprintf('Permuting Z independence test statistic...\n')
zperm = perm_null(n,numBootstraps,Mc,Kc.*Lc,0.05);
clear zMatrix




fprintf('\n\n')
fprintf('Lancaster bootstrap test results\n----------------------\n')


if xresults.reject == 1
    fprintf('x not independent of (y,z) [the distribution does not factorise]\n')
else
    fprintf('x independence of (y,z) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(xresults.pvalue))
fprintf('\n')
if yresults.reject == 1
    fprintf('y not independent of (x,z) [the distribution does not factorise]\n')
else
    fprintf('y independence of (x,z) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(yresults.pvalue))
fprintf('\n')
if zresults.reject == 1
    fprintf('z not independent of (x,y) [the distribution does not factorise]\n')
else
    fprintf('z independence of (x,y) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(zresults.pvalue))
fprintf('\n')

fprintf('\n\n')
fprintf('Lancaster permutation test results\n----------------------\n')


if xperm.reject == 1
    fprintf('x not independent of (y,z) [the distribution does not factorise]\n')
else
    fprintf('x independence of (y,z) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(xperm.pvalue))
fprintf('\n')
if yperm.reject == 1
    fprintf('y not independent of (x,z) [the distribution does not factorise]\n')
else
    fprintf('y independence of (x,z) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(yperm.pvalue))
fprintf('\n')
if zperm.reject == 1
    fprintf('z not independent of (x,y) [the distribution does not factorise]\n')
else
    fprintf('z independence of (x,y) cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(zperm.pvalue))
fprintf('\n')

results.xLancaster = xresults;
results.yLancaster = yresults;
results.zLancaster = zresults;

results.xperm = xperm;
results.yperm = yperm;
results.zperm = zperm;



fprintf('\nLancaster bootstrap: Performing "Naive" correction')
fprintf('\n----------------------\n')
p = [xresults.pvalue, yresults.pvalue, zresults.pvalue];
threshold = [alpha,alpha,alpha];
if sum(p<threshold)==3
    reject_factorisation_naive = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_naive = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end

fprintf('\nLancaster permutation: Performing "Naive" correction')
fprintf('\n----------------------\n')
p = [xperm.pvalue, yperm.pvalue, zperm.pvalue];
threshold = [alpha,alpha,alpha];
if sum(p<threshold)==3
    reject_factorisation_naive_perm = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_naive_perm = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end

results.pvalues = p;
results.reject_lancaster_null_naive = reject_factorisation_naive;
results.reject_lancaster_null_naive_perm = reject_factorisation_naive_perm;



all_results = results;
end

