%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%autoregressive thing with Z dependent on both X and Y marginally
%a is a coefficient that determines dependence on X and Y
function [X,Y,Z] = example9(len,a)
X = zeros(1,len);
Y = zeros(1,len);
Z = zeros(1,len);

X(1) = randn;
Y(1) = randn;
Z(1) = randn;
for i = 2:len;
    X(i) = 0.5*X(i-1) + randn;
    Y(i) = 0.5*Y(i-1) + randn;
    
    %Z dependent on both X and Y marginally
    Z(i) = 0.5*Z(i-1) + a*(X(i) + Y(i)) + randn;
end