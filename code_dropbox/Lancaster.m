%Paul Rubenstein, 2015
%Code for Lancaster interaction
%uses the gaussian kernel with fixed bandwidth and returns empirical
%lancaster interaction
function [Lancaster_Interaction] = Lancaster(X,Y,Z,sigma)
n=length(X);
fprintf('Constructing X gram matrix...\n')
K = GaussKern(X',X',sigma);
fprintf('Constructing Y gram matrix...\n')
L = GaussKern(Y',Y',sigma);
fprintf('Constructing Z gram matrix...\n')
M = GaussKern(Z',Z',sigma);

Kc = empirically_centre(K);
clear K;
Lc = empirically_centre(L);
clear L;
Mc = empirically_centre(M);
clear M;

statMatrix = Kc.*Lc.*Mc;
Lancaster_Interaction = sum(sum(statMatrix))/(n^2);
return
