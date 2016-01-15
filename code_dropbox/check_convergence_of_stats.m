%a short script to see if normalised lancaster converges to 
%hsic test statistic if null true (and not if not under null)
results={};
j=0;
for i = 1000:500:6000;
j=j+1;
len = 100000;
[X,Y,Z] = example3(len);
X=X(len-i:end);
Y=Y(len-i:end);
Z=Z(len-i:end);

K = GaussKern(X',X',5);
L = GaussKern(Y',Y',5);
M = GaussKern(Z',Z',5);
Kc=empirically_centre(K);
Lc=empirically_centre(L);
Mc=empirically_centre(M);

m=size(M);m=m(1);

res.lancaster = (1/m)*sum(sum(Kc.*Lc.*Mc));
res.lancaster2 = (1/m)*sum(sum(Kc.* empirically_centre(Lc.*Mc))); 
res.yindep = (1/m)*sum(sum(Lc.*empirically_centre(K.*M)));
res.zindep = (1/m)*sum(sum(Mc.*empirically_centre(K.*L)));

results{j} = res;
end