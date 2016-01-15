%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%autregressive processes with all independent
function [X,Y,Z] = example13(len,a)
X = zeros(1,len);
Y = zeros(1,len);
Z = zeros(1,len);

X(1) = randn;
Y(1) = randn;
Z(1) = randn;
for i = 2:len;
    X(i) = a*X(i-1) + randn;
    Y(i) = a*Y(i-1) + randn;
    
    %Z dependent on both X and Y marginally
    Z(i) = a*Z(i-1) + randn;
end