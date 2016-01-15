%profile testing
len = 10000;
[X,Y,Z] = example3(len);
X=X(len-1000:end);
Y=Y(len-1000:end);
Z=Z(len-1000:end);
results = all_tests(X,Y,Z,5,500,0.05);
results{1}
results{2}
results{3}
results{4}

len = 1000;
[X,Y,Z] = example5(len);
results = all_tests(X,Y,Z,0.5,500,0.05);


% wild hsic test
K = GaussKern(X',X',5);
L = GaussKern(Y',Y',5);
M = GaussKern(Z',Z',5);

resultsHSIC_XY = wildHSICtest(K,L);
resultsHSIC_XZ = wildHSICtest(K,M);
resultsHSIC_YZ = wildHSICtest(L,M);

Kc = empirically_centre(K);
Lc = empirically_centre(L);
Mc = empirically_centre(M);

resultsHSIC_XY_Z = wildHSICtest(Kc.*Lc,Mc);
resultsHSIC_XZ_Y = wildHSICtest(Kc.*Mc,Lc);
resultsHSIC_YZ_X = wildHSICtest(Lc.*Mc,Kc);

resultswhatX = wildHSICtest(K,L.*M);
resultswhatY = wildHSICtest(L,K.*M);
resultswhatZ = wildHSICtest(M,K.*L);