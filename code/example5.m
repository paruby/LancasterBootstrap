%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
% XOR example: X,Y are generated independently,
% Z=XOR(X,Y). Not timeseries
function [X,Y,Z] = example5(len)
X = rand(1,len);
X=(X>0.5);
Y = rand(1,len);
Y=(Y>0.5);
Z=xor(X,Y);
X=double(X);
Y=double(Y);
Z=double(Z);
end