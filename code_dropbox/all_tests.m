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
xresults = bootstrap_null(n,numBootstraps,xMatrix,alpha,@bootstrap_series_2,2);
clear xMatrix


fprintf('Constructing Y independence test statistic...\n')
yMatrix = Lc.*empirically_centre(Kc.*Mc);
fprintf('Bootstrapping Y independence test statistic...\n')
yresults = bootstrap_null(n,numBootstraps,yMatrix,alpha,@bootstrap_series_2,2);
clear yMatrix

fprintf('Constructing Z independence test statistic...\n')
zMatrix = Mc.*empirically_centre(Kc.*Lc);
fprintf('Bootstrapping Z independence test statistic...\n')
zresults = bootstrap_null(n,numBootstraps,zMatrix,alpha,@bootstrap_series_2,2);
clear zMatrix

fprintf('Constructing total independence test statistic...\n')
totalMatrix = Kc.*Lc.*Mc;
fprintf('Bootstrapping total independence test statistic...\n')
totalresults = bootstrap_null(n,numBootstraps,totalMatrix,alpha,@bootstrap_series_2,2);
clear totalMatrix


fprintf('Constructing X vs Y HSIC test statistic...\n')
xyHSICmatrix = Kc.*Lc;
fprintf('Bootstrapping XY HSIC test statistic...\n')
xyHSICresults = bootstrap_null(n,numBootstraps,xyHSICmatrix,alpha,@bootstrap_series_2,2);
clear xyHSICmatrix

fprintf('Constructing X vs Z HSIC test statistic...\n')
xzHSICmatrix = Kc.*Mc;
fprintf('Bootstrapping XZ HSIC test statistic...\n')
xzHSICresults = bootstrap_null(n,numBootstraps,xzHSICmatrix,alpha,@bootstrap_series_2,2);
clear xzHSICmatrix

fprintf('Constructing Y vs Z HSIC test statistic...\n')
yzHSICmatrix = Lc.*Mc;
fprintf('Bootstrapping YZ HSIC test statistic...\n')
yzHSICresults = bootstrap_null(n,numBootstraps,yzHSICmatrix,alpha,@bootstrap_series_2,2);
clear yzHSICmatrix

% fprintf('Constructing uncentred X independence test statistic...\n')
% xMatrixuc = x_indep_matrix_uncentred(K,L,M);
% fprintf('Constructing uncentred Y independence test statistic...\n')
% yMatrixuc = y_indep_matrix_uncentred(K,L,M);
% fprintf('Constructing uncentred Z independence test statistic...\n')
% zMatrixuc = z_indep_matrix_uncentred(K,L,M);


fprintf('Constructing (XY) vs Z HSIC test statistic...\n')
XY_Z_HSICmatrix = KLc.*Mc;
fprintf('Bootstrapping (XY) vs Z HSIC test statistic...\n')
XY_Z_HSICresults = bootstrap_null(n,numBootstraps,XY_Z_HSICmatrix,alpha,@bootstrap_series_2,2);
clear XY_Z_HSICmatrix

fprintf('Constructing (XZ) vs Y HSIC test statistic...\n')
XZ_Y_HSICmatrix = KMc.*Lc;
fprintf('Bootstrapping (XZ) vs Y HSIC test statistic...\n')
XZ_Y_HSICresults = bootstrap_null(n,numBootstraps,XZ_Y_HSICmatrix,alpha,@bootstrap_series_2,2);
clear XZ_Y_HSICmatrix

fprintf('Constructing (YZ) vs X HSIC test statistic...\n')
YZ_X_HSICmatrix = LMc.*Kc;
fprintf('Bootstrapping (YZ) vs X HSIC test statistic...\n')
YZ_X_HSICresults = bootstrap_null(n,numBootstraps,YZ_X_HSICmatrix,alpha,@bootstrap_series_2,2);
clear YZ_X_HSICmatrix





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

fprintf('\n\nPairwise HSIC test results\n----------------------\n')
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



fprintf('\n\nThreeway HSIC test results\n----------------------\n')
if XY_Z_HSICresults.reject == 1
    fprintf('(X,Y) and Z are dependent [the distribution does not factorise]\n')
else
    fprintf('(X,Y) and Z are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(XY_Z_HSICresults.pvalue))
fprintf('\n')
if XZ_Y_HSICresults.reject == 1
    fprintf('(X,Z) and Y are dependent [the distribution does not factorise]\n')
else
    fprintf('(X,Z) and Y are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(XZ_Y_HSICresults.pvalue))
fprintf('\n')
if YZ_X_HSICresults.reject == 1
    fprintf('(Y,Z) and X are dependent [the distribution does not factorise]\n')
else
    fprintf('(Y,Z) and X are independent\n')
end
fprintf('      p-value: ')
fprintf(num2str(YZ_X_HSICresults.pvalue))
fprintf('\n')



results.xLancaster = xresults;
results.yLancaster = yresults;
results.zLancaster = zresults;
results.totalLancaster = totalresults;

results.xyHSIC = xyHSICresults;
results.xzHSIC = xzHSICresults;
results.yzHSIC = yzHSICresults;

results.XY_Z_HSIC = XY_Z_HSICresults;
results.XZ_Y_HSIC = XZ_Y_HSICresults;
results.YZ_X_HSIC = YZ_X_HSICresults;

fprintf('\nLancaster Performing Holm-Bonferroni correction')
fprintf('\n----------------------\n')
p = [xresults.pvalue, yresults.pvalue, zresults.pvalue];
p_sorted = sort(p);
threshold = 4 - [1,2,3];
threshold = [alpha,alpha,alpha]./threshold;
if sum(p_sorted<threshold)==3
    reject_factorisation_bonferroni = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_bonferroni = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end

results.sorted_pvalues = p_sorted;    
results.reject_lancaster_null_bonferroni = reject_factorisation_bonferroni;


fprintf('\nLancaster: Performing "Naive" (but better) correction')
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

results.pvalues = p;
results.reject_lancaster_null_naive = reject_factorisation_naive;

fprintf('\nPerforming pairwise HSIC joint factorisation test with Holm-Bonferroni multiple correction')
fprintf('\n----------------------\n')
pXY = xyHSICresults.pvalue;
pXZ = xzHSICresults.pvalue;
pYZ = yzHSICresults.pvalue;
HSIC_p_sorted = sort([pXY,pXZ,pYZ]);

threshold = 4 - [1,2,3];
threshold = [alpha,alpha,alpha]./threshold;
critical = (HSIC_p_sorted<threshold);
if (critical(1)==1) && (critical(2) ==1)
    reject_factorisation_HSIC = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_HSIC = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end
results.HSIC_p_sorted = HSIC_p_sorted;
results.reject_factorisation_HSIC = reject_factorisation_HSIC;

%3way hsic start
fprintf('\n3 way HSIC: Performing Holm-Bonferroni correction')
fprintf('\n----------------------\n')
p_3HSIC = [XY_Z_HSICresults.pvalue, YZ_X_HSICresults.pvalue, XZ_Y_HSICresults.pvalue];
p_sorted_3HSIC = sort(p_3HSIC);
threshold = 4 - [1,2,3];
threshold = [alpha,alpha,alpha]./threshold;
if sum(p_sorted_3HSIC<threshold)==3
    reject_factorisation_bonferroni_3HSIC = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_bonferroni_3HSIC = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end

results.sorted_pvalues_3HSIC = p_sorted_3HSIC;    
results.reject_3HSIC_null_bonferroni = reject_factorisation_bonferroni_3HSIC;


fprintf('\n3 way HSIC: Performing "Naive" (but better) correction')
fprintf('\n----------------------\n')
threshold = [alpha,alpha,alpha];
if sum(p_sorted_3HSIC<threshold)==3
    reject_factorisation_naive_3HSIC = 1;
    fprintf('Reject null hypothesis: Joint distribution does not factorise\n')
else
    reject_factorisation_naive_3HSIC = 0;
    fprintf('Cannot reject null hypothesis: joint distribution may or may not factorise\n')
end

results.reject_3HSIC_null_naive = reject_factorisation_naive_3HSIC;

%3wayhsic end



all_results = results;
end

