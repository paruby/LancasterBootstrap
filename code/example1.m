%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates example dataset with (x,y) indep of z
%based on sums of white noise
function [X,Y,Z] = example1(len)
X = cumsum(randn(1,len));
Y = X + randn(1,len);
Z = cumsum(0.5*randn(1,len));
end