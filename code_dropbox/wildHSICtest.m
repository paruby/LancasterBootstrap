function [results] = wildHSICtest(K,L)
m=size(K);m=m(1);
H = eye(m)-1/m*ones(m,m);
Kc = H*K*H;
Lc = H*L*H;
statMatrix = Kc.*Lc;

results = bootstrap_null(m,500,statMatrix,0.05,@bootstrap_series,1);

end