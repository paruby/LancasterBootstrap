%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates example dataset with (x,y) indep of z
%based on random samples of uniform distribution
function [X,Y,Z] = example4(len)
X = rand(1,len);
Y = X;
Z = rand(1,len);
end