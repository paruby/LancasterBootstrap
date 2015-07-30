%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%performs each of the 4 tests, taking the data
%as input using Gaussian kernel with fixed sigma
%for all data
function [all_results] = all_tests(X,Y,Z,sigma,numBootstraps,alpha)
n=length(X);
%TODO: add check that X,Y,Z same length

fprintf('Constructing X gram matrix...\n')
K = GaussKern(X',X',sigma);
fprintf('Constructing Y gram matrix...\n')
L = GaussKern(Y',Y',sigma);
fprintf('Constructing Z gram matrix...\n')
M = GaussKern(Z',Z',sigma);

Kc = empirically_centre(K);
clear K
Lc = empirically_centre(L);
clear L
Mc = empirically_centre(M);
clear M;



fprintf('Constructing X independence test statistic...\n')
xMatrix = Kc.*empirically_centre(Lc.*Mc);
fprintf('Bootstrapping X independence test statistic...\n')
xresults = bootstrap_null(n,numBootstraps,xMatrix,alpha,@bootstrap_series,2);
clear xMatrix


fprintf('Constructing Y independence test statistic...\n')
yMatrix = Lc.*empirically_centre(Kc.*Mc);
fprintf('Bootstrapping Y independence test statistic...\n')
yresults = bootstrap_null(n,numBootstraps,yMatrix,alpha,@bootstrap_series,2);
clear yMatrix

fprintf('Constructing Z independence test statistic...\n')
zMatrix = Mc.*empirically_centre(Kc.*Lc);
fprintf('Bootstrapping Z independence test statistic...\n')
zresults = bootstrap_null(n,numBootstraps,zMatrix,alpha,@bootstrap_series,2);
clear zMatrix

fprintf('Constructing total independence test statistic...\n')
totalMatrix = Kc.*Lc.*Mc;
fprintf('Bootstrapping total independence test statistic...\n')
totalresults = bootstrap_null(n,numBootstraps,totalMatrix,alpha,@bootstrap_series,2);
clear totalMatrix


fprintf('Constructing X vs Y HSIC test statistic...\n')
xyHSICmatrix = Kc.*Lc;
fprintf('Bootstrapping XY HSIC test statistic...\n')
xyHSICresults = bootstrap_null(n,numBootstraps,xyHSICmatrix,alpha,@bootstrap_series,2);
clear xyHSICmatrix

fprintf('Constructing X vs Z HSIC test statistic...\n')
xzHSICmatrix = Kc.*Mc;
fprintf('Bootstrapping XZ HSIC test statistic...\n')
xzHSICresults = bootstrap_null(n,numBootstraps,xzHSICmatrix,alpha,@bootstrap_series,2);
clear xzHSICmatrix

fprintf('Constructing Y vs Z HSIC test statistic...\n')
yzHSICmatrix = Lc.*Mc;
fprintf('Bootstrapping YZ HSIC test statistic...\n')
yzHSICresults = bootstrap_null(n,numBootstraps,yzHSICmatrix,alpha,@bootstrap_series,2);
clear yzHSICmatrix

% fprintf('Constructing uncentred X independence test statistic...\n')
% xMatrixuc = x_indep_matrix_uncentred(K,L,M);
% fprintf('Constructing uncentred Y independence test statistic...\n')
% yMatrixuc = y_indep_matrix_uncentred(K,L,M);
% fprintf('Constructing uncentred Z independence test statistic...\n')
% zMatrixuc = z_indep_matrix_uncentred(K,L,M);












fprintf('\n\n')
fprintf('Lancaster test results\n----------------------\n')


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
if totalresults.reject == 1
    fprintf('total independence rejected [the distribution does not factorise]\n')
else
    fprintf('total independence cannot be rejected\n')
end
fprintf('      p-value: ')
fprintf(num2str(totalresults.pvalue))
fprintf('\n')

fprintf('\n\nHSIC test results\n----------------------\n')
if xyHSICresults.reject == 1
    fprintf('x and y are dependent [the distribution does not factorise]\n')
else
    fprintf('x and y are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(xyHSICresults.pvalue))
fprintf('\n')
if xzHSICresults.reject == 1
    fprintf('x and z are dependent [the distribution does not factorise]\n')
else
    fprintf('x and z are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(xzHSICresults.pvalue))
fprintf('\n')
if yzHSICresults.reject == 1
    fprintf('y and z are dependent [the distribution does not factorise]\n')
else
    fprintf('y and z are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(yzHSICresults.pvalue))
fprintf('\n')

%results = {xresults,yresults,zresults,totalresults};

results.xLancaster = xresults;
results.yLancaster = yresults;
results.zLancaster = zresults;
results.totalLancaster = totalresults;

results.xyHSIC = xyHSICresults;
results.xzHSIC = xzHSICresults;
results.yzHSIC = yzHSICresults;


% fprintf('Bootstrapping uncentred X independence test statistic...\n')
% xresultsuc = bootstrap_null(n,numBootstraps,xMatrixuc,alpha,@bootstrap_series,2);
% fprintf('Bootstrapping uncentred Y independence test statistic...\n')
% yresultsuc = bootstrap_null(n,numBootstraps,yMatrixuc,alpha,@bootstrap_series,2);
% fprintf('Bootstrapping uncentred Z independence test statistic...\n')
% zresultsuc = bootstrap_null(n,numBootstraps,zMatrixuc,alpha,@bootstrap_series,2);
% 
% if xresultsuc.reject == 1
%     fprintf('x (uc) not independent of (y,z)\n')
% else
%     fprintf('x (uc) independence of (y,z) cannot be rejected\n')
% end
% if yresultsuc.reject == 1
%     fprintf('y (uc) not independent of (x,z)\n')
% else
%     fprintf('y (uc) independence of (x,z) cannot be rejected\n')
% end
% if zresultsuc.reject == 1
%     fprintf('z (uc) not independent of (x,y)\n')
% else
%     fprintf('z (uc) independence of (x,y) cannot be rejected\n')
% end
% resultsuc = {xresultsuc,yresultsuc,zresultsuc};


%all_results = {results,resultsuc};
all_results = results;
end

