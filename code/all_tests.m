%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%performs each of the 4 tests, taking the data
%as input using Gaussian kernel with fixed sigma
%for all data
function [results] = all_tests(X,Y,Z,sigma,numBootstraps,alpha)
n=length(X);
%TODO: add check that X,Y,Z same length

fprintf('Constructing X gram matrix...\n')
K = GaussKern(X',X',sigma);
fprintf('Constructing Y gram matrix...\n')
L = GaussKern(Y',Y',sigma);
fprintf('Constructing Z gram matrix...\n')
M = GaussKern(Z',Z',sigma);

fprintf('Constructing X independence test statistic...\n')
xMatrix = x_indep_matrix(K,L,M);
fprintf('Constructing Y independence test statistic...\n')
yMatrix = y_indep_matrix(K,L,M);
fprintf('Constructing Z independence test statistic...\n')
zMatrix = z_indep_matrix(K,L,M);
fprintf('Constructing total independence test statistic...\n')
totalMatrix = total_indep_matrix(K,L,M);

fprintf('Bootstrapping X independence test statistic...\n')
xresults = bootstrap_null(n,numBootstraps,xMatrix,alpha,@bootstrap_series,0);
fprintf('Bootstrapping Y independence test statistic...\n')
yresults = bootstrap_null(n,numBootstraps,yMatrix,alpha,@bootstrap_series,0);
fprintf('Bootstrapping Z independence test statistic...\n')
zresults = bootstrap_null(n,numBootstraps,zMatrix,alpha,@bootstrap_series,0);
fprintf('Bootstrapping total independence test statistic...\n')
totalresults = bootstrap_null(n,numBootstraps,totalMatrix,alpha,@bootstrap_series,0);
if xresults.reject == 1
    fprintf('x not independent of (y,z)\n')
else
    fprintf('x independence of (y,z) cannot be rejected\n')
end
if yresults.reject == 1
    fprintf('y not independent of (x,z)\n')
else
    fprintf('y independence of (x,z) cannot be rejected\n')
end
if zresults.reject == 1
    fprintf('z not independent of (x,y)\n')
else
    fprintf('z independence of (x,y) cannot be rejected\n')
end
if totalresults.reject == 1
    fprintf('total independence rejected\n')
else
    fprintf('total independence cannot be rejected\n')
end
results = {xresults,yresults,zresults,totalresults};
end